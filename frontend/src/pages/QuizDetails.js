import React, { useState, useEffect, useCallback } from 'react';
import { useParams } from 'react-router-dom';
import '../styles/QuizDetails.css'; // 确保路径正确

const QuizDetails = () => {
  const { quizId } = useParams();
  const [quizDetails, setQuizDetails] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);

  useEffect(() => {
    const fetchQuizDetails = async () => {
      setLoading(true);
      try {
        const response = await fetch(`http://localhost:5000/user/quiz/${quizId}`);
        const data = await response.json();
        setQuizDetails(data);
      } catch (error) {
        console.error('Failed to fetch quiz details:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchQuizDetails();
  }, [quizId]);

  const goToNextQuestion = useCallback(() => {
    if (currentQuestionIndex < quizDetails.questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
    }
  }, [currentQuestionIndex, quizDetails]);

  const goToPreviousQuestion = useCallback(() => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
    }
  }, [currentQuestionIndex]);

  useEffect(() => {
    const handleKeyDown = (event) => {
      if (event.key === 'ArrowRight') {
        goToNextQuestion();
      } else if (event.key === 'ArrowLeft') {
        goToPreviousQuestion();
      }
    };

    window.addEventListener('keydown', handleKeyDown);

    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [goToNextQuestion, goToPreviousQuestion]); // Now includes dependencies

  if (loading) return <div>Loading...</div>;
  if (!quizDetails || quizDetails.questions.length === 0) return <div>No quiz found!</div>;

  const question = quizDetails.questions[currentQuestionIndex];
  const totalQuestions = quizDetails.questions.length;
  const progress = (currentQuestionIndex + 1) / totalQuestions * 100;

  return (
    <div className="quiz-container">
      <h1>{quizDetails.quizName}</h1>
      <div className="progress-bar">
        <div className="progress-bar-fill" style={{ width: `${progress}%` }}>{Math.round(progress)}%</div>
      </div>
      <div className="question-card">
        <h3>{question.questionText}</h3>
        {question.imageUrl && <img src={question.imageUrl} alt={question.commonName} className="question-image" />}
      </div>
      <div className="navigation-buttons">
        <button onClick={goToPreviousQuestion} disabled={currentQuestionIndex === 0}>Previous</button>
        <button onClick={goToNextQuestion} disabled={currentQuestionIndex === totalQuestions - 1}>Next</button>
      </div>
    </div>
  );
};

export default QuizDetails;
