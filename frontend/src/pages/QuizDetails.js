import React, { useCallback,useState, useEffect, useRef } from 'react';
import { useParams } from 'react-router-dom';
import { useUserContext } from '../contexts/UserContext';
import { useQuiz } from '../contexts/QuizContext'; 
import '../styles/QuizDetails.css';
import { useNavigate } from 'react-router-dom';


const QuizDetails = () => {
  const { quizId } = useParams();
  const { user } = useUserContext();
  const navigate = useNavigate();
  const { saveResponse } = useQuiz(); 
  const [quizDetails, setQuizDetails] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedOption, setSelectedOption] = useState(null);
  const [feedback, setFeedback] = useState(null);
  const [timer, setTimer] = useState(0);
  const timerRef = useRef(null);
  const [answers, setAnswers] = useState({});
  const [hasSavedProgress, setHasSavedProgress] = useState(false); 
  const [showScoreModal, setShowScoreModal] = useState(false); // State to control the visibility of the score modal
  const [finalScore, setFinalScore] = useState(0); // State to store the final score
  const [isSubmitted, setIsSubmitted] = useState(false); 


  useEffect(() => {
    const startTime = Date.now();
    timerRef.current = setInterval(() => {
      setTimer(Date.now() - startTime);
    }, 1000);

    async function fetchQuizDetails() {
      setLoading(true);
      try {
        const response = await fetch(`http://localhost:5000/user/quiz/${quizId}`);
        const data = await response.json();
        data.questions.forEach(question => {
          if (question.questionType === 'true_false') {
            question.options = [
              { optionId: 'T', optionText: 'True', isCorrect: question.correctAnswer === 'True' },
              { optionId: 'F', optionText: 'False', isCorrect: question.correctAnswer === 'False' }
            ];
          }
        });
        setQuizDetails(data);
      } catch (error) {
        console.error('Failed to fetch quiz details:', error);
      } finally {
        setLoading(false);
      }
    }

    fetchQuizDetails();
    return () => clearInterval(timerRef.current);
  }, [quizId]);
  

  const changeQuestion = useCallback((newIndex) => {
    setCurrentQuestionIndex(newIndex);
    const questionId = quizDetails.questions[newIndex].questionId;
    if (answers[questionId]) {
      setSelectedOption(answers[questionId].selectedOptionId);
      setFeedback(answers[questionId].feedback);
    } else {
      setSelectedOption(null);
      setFeedback(null);
    }
  }, [quizDetails, answers]); 
  
  useEffect(() => {
    const handleKeyDown = (event) => {
      if (event.key === 'ArrowRight' && currentQuestionIndex < quizDetails?.questions.length - 1) {
        changeQuestion(currentQuestionIndex + 1);
      } else if (event.key === 'ArrowLeft' && currentQuestionIndex > 0) {
        changeQuestion(currentQuestionIndex - 1);
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
}, [currentQuestionIndex, quizDetails, changeQuestion]); 

  
  


  const handleOptionSelect = (option) => {
  if (!option || !quizDetails) {
    console.error('Option or quiz details are undefined');
    return;
  }
  setSelectedOption(option);
  const currentQuestion = quizDetails.questions[currentQuestionIndex];
  const isCorrect = option.isCorrect;

  // Save response locally
  saveResponse({
    questionId: currentQuestion.questionId,
    selectedOptionId: option.optionId,
    isCorrect
  });

  // Update local answers state
  setAnswers(prev => ({
    ...prev,
    [currentQuestion.questionId]: {
      questionId: currentQuestion.questionId,
      selectedOptionId: option.optionId,
      isCorrect: isCorrect,
      feedback: isCorrect ? "Correct Answer!" : `Wrong Answer! Correct is: ${currentQuestion.correctAnswer}`
    }
  }));

  setSelectedOption(option.optionId);
  setFeedback(isCorrect ? "Correct Answer!" : `Wrong Answer! Correct is: ${currentQuestion.correctAnswer}`);
};





const saveProgress = async () => {
  if (!isSubmitted) {
    try {
      const response = await fetch(`http://localhost:5000/user/save-progress/${quizId}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          studentId: user.studentId,
          answers: Object.values(answers)  // Assuming this sends only new answers or is managed accordingly on the backend
        })
      });

      const data = await response.json();
      if (data) {
        setHasSavedProgress(true);  // Enable the submit button after progress is saved
        alert(data.message);  // Show backend message
      }
    } catch (error) {
      console.error('Failed to save progress:', error);
      alert('Failed to save progress');
    }
  }
};



const submitQuiz = async () => {
  try {
    const response = await fetch(`http://localhost:5000/user/submit-quiz/${quizId}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        studentId: user.studentId
      })
    });

    const data = await response.json();
    setFinalScore(data.final_score); // Store the final score received from the backend
    setShowScoreModal(true); // Show the score modal
    setIsSubmitted(true); // Prevent further modifications
    setAnswers({}); // Optionally clear answers to prevent reuse in the UI
  } catch (error) {
    console.error('Failed to submit quiz:', error);
    alert('Failed to submit quiz');
  }
};

 
// const scoreModal = showScoreModal && (
//   <div className="score-modal">
//     <h2>Your Final Score: {finalScore}</h2>
//     <button onClick={() => {
//       setShowScoreModal(false);
//       navigate('/quiz-list'); // Use navigate instead of history.push
//     }}>
//       Back to Quiz Page
//     </button>
//   </div>
// );


  const formatTime = (ms) => {
    const seconds = Math.floor(ms / 1000);
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
  };


  if (loading) return <div>Loading...</div>;
  if (!quizDetails || quizDetails.questions.length === 0) return <div>No quiz found!</div>;

  const question = quizDetails.questions[currentQuestionIndex];
  const totalQuestions = quizDetails.questions.length;
  const progress = (currentQuestionIndex + 1) / totalQuestions * 100;

  return (
    <div className="quiz-container">
      <h1>{quizDetails.quizName}</h1>
      <div>Time Elapsed: {formatTime(timer)}</div>
      <div className="progress-bar">
        <div className="progress-bar-fill" style={{ width: `${progress}%` }}>{Math.round(progress)}%</div>
      </div>
      <div className="question-card">
        <h3>{question.questionText}</h3>
        {question.imageUrl && <img src={question.imageUrl} alt={question.commonName} className="question-image" />}
        {question.options?.map((option) => (
          <button
          key={option.optionId}
          className={`option-button ${selectedOption?.optionId === option.optionId ? 'selected' : ''}`}
          onClick={() => handleOptionSelect(option)}
          disabled={selectedOption !== null || isSubmitted}  // Disable if an option is already selected or if the quiz is submitted
        >
          {option.optionLabel ? `${option.optionLabel}. ${option.optionText}` : option.optionText}
        </button>
        ))}
        {feedback && (
          <div className={`feedback ${feedback.startsWith('Correct') ? 'correct' : 'incorrect'}`}>
            {feedback}
          </div>
        )}
      </div>
      <div className="navigation-buttons">
      <button onClick={() => changeQuestion(currentQuestionIndex - 1)} disabled={currentQuestionIndex === 0 || isSubmitted}>Previous</button>
      <button onClick={() => changeQuestion(currentQuestionIndex + 1)} disabled={currentQuestionIndex === totalQuestions - 1 || isSubmitted}>Next</button>
      <button onClick={saveProgress} className="save-progress-button" disabled={isSubmitted}>Save Progress</button>
      <button onClick={submitQuiz} className="submit-quiz-button" disabled={!hasSavedProgress || isSubmitted}>Submit Quiz</button>

      </div>
      {showScoreModal && (
        <div className="score-modal">
          <h2>Your Final Score: {finalScore}</h2>
          <button onClick={() => {
            setShowScoreModal(false);
            navigate('/quiz-list'); 
          }}>Back to Quiz Page</button>
        </div>
      )}
    </div>
  );
  

};

export default QuizDetails;
