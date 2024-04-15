import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';

const QuizDetails = () => {
  const { quizId } = useParams();
  const [quizDetails, setQuizDetails] = useState(null);
  const [loading, setLoading] = useState(true);

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

  if (loading) return <div>Loading...</div>;
  if (!quizDetails) return <div>No quiz found!</div>;

  return (
    <div>
      <h1>{quizDetails.quizName}</h1>
      <img src={quizDetails.quizImageUrl} alt={`Quiz ${quizDetails.quizName}`} />
      {quizDetails.questions.map(question => (
        <div key={question.questionId}>
          <h3>{question.questionText}</h3>
          {question.imageUrl && <img src={question.imageUrl} alt={question.commonName} />}
          {/* Render options based on questionType */}
        </div>
      ))}
    </div>
  );
};

export default QuizDetails;
