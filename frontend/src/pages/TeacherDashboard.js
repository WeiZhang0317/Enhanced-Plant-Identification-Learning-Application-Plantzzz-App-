import React from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation';
import Profile from './Profile';
import EditQuiz from './EditQuiz'; // Make sure this component exists
import '../styles/Dashboard.css';

function TeacherDashboard() {
  return (
    <div className="teacher-dashboard">
      <Navigation />
      <div className="content" style={{ display: 'flex', flexDirection: 'row' }}>
        <div className="sidebar">
          <NavLink to="profile" className={({ isActive }) => isActive ? 'active-link' : ''}>Profile</NavLink>
          <NavLink to="edit-quiz" className={({ isActive }) => isActive ? 'active-link' : ''}>Edit Quiz</NavLink>
        </div>
        <div className="main-content" style={{ flexGrow: 1 }}>
          <Routes>
            <Route path="profile" element={<Profile />} />
            <Route path="edit-quiz" element={<EditQuiz />} />
            <Route index element={<Profile />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default TeacherDashboard;
