import React, { useState, useEffect } from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation';
import Profile from './Profile';
import AllQuizzes from './AllQuizzes';
import OngoingQuizzes from './OngoingQuizzes';
import CompletedQuizzes from './CompletedQuizzes';
import '../styles/StudentDashboard.css';

function StudentDashboard() {
  const [allQuizzes, setAllQuizzes] = useState([]); // State for all quizzes
  const [ongoingQuizzes] = useState([]); // Dummy state, add fetching logic similar to allQuizzes if required
  const [completedQuizzes] = useState([]); // Dummy state, add fetching logic similar to allQuizzes if required

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
          <NavLink to="ongoing-quizzes" className={getNavLinkClass}>Ongoing Quizzes</NavLink>
          <NavLink to="completed-quizzes" className={getNavLinkClass}>Completed Quizzes</NavLink>
        </div>
        <div className="main-content" style={{ flexGrow: 1 }}>
          <Routes>
            <Route path="profile" element={<Profile />} />
            <Route path="all-quizzes" element={<AllQuizzes quizzes={allQuizzes} />} />
            <Route path="ongoing-quizzes" element={<OngoingQuizzes quizzes={ongoingQuizzes} />} />
            <Route path="completed-quizzes" element={<CompletedQuizzes quizzes={completedQuizzes} />} />
            <Route index element={<Profile />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;

