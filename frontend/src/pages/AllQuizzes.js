import React from 'react'; // Remove unused imports
import { Link } from 'react-router-dom';
import '../styles/AllQuizzes.css';

const QuizCard = ({ quiz }) => {
        const baseUrl = 'http://localhost:5000/static/';
        return (
            <div className="quiz-card">
                <img src={`${baseUrl}${quiz.QuizImageURL}`} alt={`Quiz ${quiz.QuizName}`} className="quiz-image" />
                <div className="quiz-title">{quiz.QuizName}</div>
                <Link to={`/quiz/${quiz.QuizID}`} className="start-quiz-btn">Start Quiz</Link>
            </div>
        );
    };

const AllQuizzes = ({ quizzes }) => {
    if (!quizzes.length) {
        return <div>Loading quizzes...</div>; // Simple loading indicator
    }

    return (
        <div className="all-quizzes">
            <h2>All Quizzes</h2>
            <div className="quiz-grid">
                {quizzes.map((quiz) => (
                    <QuizCard key={quiz.QuizID} quiz={quiz} />
                ))}
            </div>
        </div>
    );
};

export default AllQuizzes;
