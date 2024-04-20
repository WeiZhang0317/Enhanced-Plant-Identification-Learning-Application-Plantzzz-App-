import React, { useCallback,useState, useEffect, useRef } from 'react';
import { useParams } from 'react-router-dom';
import { useUserContext } from '../contexts/UserContext';
import { useQuiz } from '../contexts/QuizContext'; 
import '../styles/QuizDetails.css';

const QuizDetails = () => {
  const { quizId } = useParams();
  const { user } = useUserContext();
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
  try {
    const response = await fetch(`http://localhost:5000/user/save-progress/${quizId}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        studentId: user.studentId,
        answers: Object.values(answers)  // 使用处理后的答案数组
      })
    });

    const data = await response.json();
      if (data) { // 假设后端在保存成功时返回了一些数据

      setHasSavedProgress(true);  // 更新状态以启用提交按钮

      alert(data.message);  // 显示后端返回的消息

    }  // 显示后端返回的消息
  } catch (error) {
    console.error('Failed to save progress:', error);
    alert('Failed to save progress');
  }
};

const submitQuiz = async () => {
  try {
    const response = await fetch(`http://localhost:5000/user/submit-quiz/${quizId}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        studentId: user.studentId,
        answers: Object.values(answers)
      })
    });

    const data = await response.json();
    alert(`Your score is: ${data.final_score}`);
    setAnswers({});  // 清空答案状态，模拟重新开始
  } catch (error) {
    console.error('Failed to submit quiz:', error);
    alert('Failed to submit quiz');
  }
};


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
            disabled={selectedOption !== null}
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
        <button onClick={() => changeQuestion(currentQuestionIndex - 1)} disabled={currentQuestionIndex === 0}>Previous</button>
        <button onClick={() => changeQuestion(currentQuestionIndex + 1)} disabled={currentQuestionIndex === totalQuestions - 1}>Next</button>
        <button onClick={saveProgress} className="save-progress-button">Save Progress</button>
        <button onClick={submitQuiz} className="submit-quiz-button" disabled={!hasSavedProgress}>Submit Quiz</button> 
      </div>
    </div>
  );
};

export default QuizDetails;