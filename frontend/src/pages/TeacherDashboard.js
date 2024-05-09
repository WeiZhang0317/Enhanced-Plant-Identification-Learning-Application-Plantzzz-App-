import React, { useState, useEffect } from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation';
import Profile from './Profile';
import AllQuizzes from './AllQuizzes';
import EditQuiz from './EditQuiz'; // Make sure this component exists
import '../styles/Dashboard.css';

function TeacherDashboard() {

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
    <div className="teacher-dashboard">
      <Navigation />
      <div className="content" style={{ display: 'flex', flexDirection: 'row' }}>
        <div className="sidebar">
          <NavLink to="profile" className={getNavLinkClass}>Profile</NavLink>
          <NavLink to="all-quizzes" className={getNavLinkClass}>All Quizzes</NavLink>
        </div>
        <div className="main-content" style={{ flexGrow: 1 }}>
        <Routes>
          <Route path="profile" element={<Profile />} />
          <Route path="all-quizzes" element={<AllQuizzes quizzes={allQuizzes} />} />
          <Route path="edit-quiz/:quizId" element={<EditQuiz />} />
          <Route index element={<Profile />} />
        </Routes>
        </div>
      </div>
    </div>
  );
}

export default TeacherDashboard;
