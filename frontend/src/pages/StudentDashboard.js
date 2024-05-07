import React, { useState, useEffect } from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation';
import Profile from './Profile';
import AllQuizzes from './AllQuizzes';
import StudentReview from './StudentReview';
import MistakeSummary from './MistakeSummary';
import ScoreRanking from './ScoreRanking';
import QuizDetails from './QuizDetails';  
import '../styles/Dashboard.css';

function StudentDashboard() {
  const [allQuizzes, setAllQuizzes] = useState([]); 

  useEffect(() => {
    // Fetch all quizzes when component mounts using full URL
    const fetchQuizzes = async () => {
      try {
        const response = await fetch('http://localhost:5000/user/all-quizzes');
        const quizzes = await response.json(); // Assuming the response body will be the JSON array of quizzes
        setAllQuizzes(quizzes);
      } catch (error) {
        console.error('Failed to fetch quizzes:', error);
      }
    };

    fetchQuizzes();
  }, []);

  const getNavLinkClass = ({ isActive }) => isActive ? 'active-link' : '';

  return (
    <div className="student-dashboard">
      <Navigation />
      <div className="content" style={{ display: 'flex', flexDirection: 'row' }}>
        <div className="sidebar">
          <NavLink to="profile" className={getNavLinkClass}>Profile</NavLink>
          <NavLink to="all-quizzes" className={getNavLinkClass}>All Quizzes</NavLink>
          <NavLink to="question-review" className={getNavLinkClass}>Finished Quiz Review</NavLink>
          <NavLink to="score-ranking" className={getNavLinkClass}>Score Ranking</NavLink>
        </div>
        <div className="main-content" style={{ flexGrow: 1 }}>
          <Routes>
            <Route path="profile" element={<Profile />} />
            <Route path="all-quizzes" element={<AllQuizzes quizzes={allQuizzes} />} />
            <Route path="quiz/:quizId" element={<QuizDetails />} />
            <Route path="question-review" element={<StudentReview />} />  {/* 已更新，不再传递 quizzes */}
            <Route path="question-review/incorrect-answers/:progressId" element={<MistakeSummary />} />
            <Route path="score-ranking" element={<ScoreRanking />} />
            <Route index element={<Profile />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;
