import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/AllQuizzes.css'; // Ensure to create this stylesheet

const QuizCard = ({ quiz }) => {
  return (
    <div className="quiz-card">
      <img src={quiz.image} alt={`Quiz ${quiz.title}`} className="quiz-image" />
      <div className="quiz-title">{quiz.title}</div>
      <Link to={`/quiz/${quiz.id}`} className="start-quiz-btn">Start Quiz</Link>
    </div>
  );
};

const AllQuizzes = ({ quizzes }) => {
  return (
    <div className="all-quizzes">
      <h2>All Quizzes</h2>
      <div className="quiz-grid">
        {quizzes.map((quiz) => (
          <QuizCard key={quiz.id} quiz={quiz} />
        ))}
      </div>
    </div>
  );
};

export default AllQuizzes;
