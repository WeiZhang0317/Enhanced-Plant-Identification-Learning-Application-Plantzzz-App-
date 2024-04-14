import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import '../styles/OngoingQuizzes.css';

function OngoingQuizzes() {
  const [ongoingQuizzes, setOngoingQuizzes] = useState([]);
  const [error, setError] = useState(null);  // Added state for error handling

  useEffect(() => {
    fetchOngoingQuizzes();
  }, []);

  const fetchOngoingQuizzes = async () => {
    try {
      const response = await fetch('ongoing-quizzes');  // 更新了请求的URL
      if (!response.ok) {  // Check if the response is successful
        // If the response status is not OK, throw an error with the status
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      const data = await response.json(); 
      console.log('Received data:', data); // This will be executed only if the response is OK
      setOngoingQuizzes(data);
    } catch (error) {
      // Log the error to the console and set it to state
      console.error('Error fetching ongoing quizzes:', error);
      setError(error.toString()); // Store the error message in state
    }
  };

  // Below, we will render the error message if there is an error
  return (
    <div>
      <h2>Ongoing Quizzes</h2>
      {error && <div className="error-message">{error}</div>}  {/* Display the error message if there is an error */}
      <div className="quiz-list">
        {ongoingQuizzes.map(quiz => (
          <Link to={`/quiz/${quiz.QuizID}`} key={quiz.QuizID} className="quiz-card">
            <img src={quiz.QuizImageURL} alt={quiz.QuizName} />
            <p>{quiz.QuizName}</p>
          </Link>
        ))}
      </div>
    </div>
  );
}

export default OngoingQuizzes;
