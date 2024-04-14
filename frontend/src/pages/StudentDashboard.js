import React from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation'; // This is your horizontal navigation bar
import Profile from './Profile';
import OngoingQuizzes from './OngoingQuizzes';
import CompletedQuizzes from './CompletedQuizzes';
import '../styles/StudentDashboard.css'; // Path to your stylesheet

function StudentDashboard() {
  // Dummy data for quizzes, replace these with actual quiz fetching logic if needed
  const ongoingQuizzes = []; // Replace with actual quiz data fetching logic
  const completedQuizzes = []; // Replace with actual quiz data fetching logic

  // Function to determine the active NavLink class
  const getNavLinkClass = ({ isActive }) => isActive ? 'active-link' : '';

  return (
    <div className="student-dashboard">
      <Navigation /> {/* Horizontal navigation component */}

      {/* Content area */}
      <div className="content" style={{ display: 'flex', flexDirection: 'row' }}>
        <div className="sidebar">
          {/* Sidebar with NavLink components */}
          <NavLink to="profile" className={getNavLinkClass}>
            Profile
          </NavLink>
          <NavLink to="ongoing-quizzes" className={getNavLinkClass}>
            Ongoing Quizzes
          </NavLink>
          <NavLink to="completed-quizzes" className={getNavLinkClass}>
            Completed Quizzes
          </NavLink>
        </div>

        {/* Route handling for the main area */}
        <div className="main-content" style={{ flexGrow: 1 }}>
          <Routes>
            <Route path="profile" element={<Profile />} />
            <Route path="ongoing-quizzes" element={<OngoingQuizzes quizzes={ongoingQuizzes} />} />
            <Route path="completed-quizzes" element={<CompletedQuizzes quizzes={completedQuizzes} />} />
            {/* Add a redirect for the base path to profile */}
            <Route index element={<Profile />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;
