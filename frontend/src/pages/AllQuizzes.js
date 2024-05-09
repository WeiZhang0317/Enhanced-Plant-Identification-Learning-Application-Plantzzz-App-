import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useUserContext } from '../contexts/UserContext'; // Make sure to import useUserContext correctly
import '../styles/AllQuizzes.css';

const QuizCard = ({ quiz }) => {
    const { user } = useUserContext(); // Accessing user context to determine the link path
    const baseUrl = 'http://localhost:5000/static/';
    const linkPath = user.userType === 'teacher' ? `/teacher/dashboard/edit-quiz/${quiz.QuizID}` : `/student/dashboard/quiz/${quiz.QuizID}`;
    const linkText = user.userType === 'teacher' ? 'Edit Quiz' : 'Start Quiz';

    return (
        <div className="quiz-card">
            <img src={`${baseUrl}${quiz.QuizImageURL}`} alt={`Quiz ${quiz.QuizName}`} className="quiz-image" />
            <div className="quiz-title">{quiz.QuizName}</div>
            <Link to={linkPath} className="start-quiz-btn">{linkText}</Link>
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

