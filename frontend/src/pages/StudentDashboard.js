import React, { useState, useEffect } from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation'; // This is your horizontal navigation bar
import Profile from './Profile';
import OngoingQuizzes from './OngoingQuizzes';
import CompletedQuizzes from './CompletedQuizzes';
import '../styles/StudentDashboard.css'; // Path to your stylesheet

function StudentDashboard() {
  const [studentInfo, setStudentInfo] = useState({});
  const [ongoingQuizzes, setOngoingQuizzes] = useState([]);
  const [completedQuizzes, setCompletedQuizzes] = useState([]);

  // Fetch student information from backend
  useEffect(() => {
    // Assuming backend URL is http://localhost:5000
    const fetchStudentInfo = async () => {
      const response = await fetch('http://localhost:5000/student/student/info?studentId=1');
      if (response.ok) {
        const data = await response.json();
        setStudentInfo(data);
      }
    };
    fetchStudentInfo();
  }, []);

  // Fetch ongoing quizzes from backend
  useEffect(() => {
    const fetchOngoingQuizzes = async () => {
      const response = await fetch('http://localhost:5000/student/quizzes/ongoing?studentId=1');
      if (response.ok) {
        const data = await response.json();
        setOngoingQuizzes(data);
      }
    };
    fetchOngoingQuizzes();
  }, []);

  // Fetch completed quizzes from backend
  useEffect(() => {
    const fetchCompletedQuizzes = async () => {
      const response = await fetch('http://localhost:5000/student/quizzes/completed?studentId=1');
      if (response.ok) {
        const data = await response.json();
        setCompletedQuizzes(data);
      }
    };
    fetchCompletedQuizzes();
  }, []);

  // Function to determine the active NavLink class
  const getNavLinkClass = ({ isActive }) => isActive ? 'active-link' : '';


  return (
    <div className="student-dashboard">
      <Navigation /> {/* Horizontal navigation component */}

      {/* Content area */}
      <div className="content">
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
        <div className="main-content">
          <Routes>
            <Route path="profile" element={<Profile studentInfo={studentInfo} />} />
            <Route path="ongoing-quizzes" element={<OngoingQuizzes quizzes={ongoingQuizzes} />} />
            <Route path="completed-quizzes" element={<CompletedQuizzes quizzes={completedQuizzes} />} />
            {/* Add a redirect for the base path to profile */}
            <Route index element={<Profile studentInfo={studentInfo} />} />
          </Routes>
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;