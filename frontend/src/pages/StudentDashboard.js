import React, { useState, useEffect } from 'react';
import { NavLink, Routes, Route } from 'react-router-dom';
import Navigation from '../components/Navigation';
import Profile from './Profile';
import OngoingQuizzes from './OngoingQuizzes';
import CompletedQuizzes from './CompletedQuizzes';
import DefaultInfoCard from '../components/DefaultInfoCard';
import '../styles/StudentDashboard.css';

function StudentDashboard() {
  const [studentInfo, setStudentInfo] = useState({});
  const [ongoingQuizzes, setOngoingQuizzes] = useState([]);
  const [completedQuizzes, setCompletedQuizzes] = useState([]);

  useEffect(() => {
    const fetchStudentInfo = async () => {
      const response = await fetch('http://localhost:5000/student/student/info?studentId=1');
      if (response.ok) {
        const data = await response.json();
        setStudentInfo(data);
      }
    };
    fetchStudentInfo();
  }, []);

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

  const getNavLinkClass = ({ isActive }) => isActive ? 'active-link' : '';

  return (
    <div className="student-dashboard">
      <Navigation />
      <div className="content">
        <div className="sidebar">
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
        <div className="main-content">
          <Routes>
            <Route path="profile" element={<Profile studentInfo={studentInfo} />} />
            <Route path="ongoing-quizzes" element={<OngoingQuizzes quizzes={ongoingQuizzes} />} />
            <Route path="completed-quizzes" element={<CompletedQuizzes quizzes={completedQuizzes} />} />
            <Route index element={<Profile studentInfo={studentInfo} />} />
          </Routes>
        </div>
        <div className="sidebar-right">
          <DefaultInfoCard
            color="info"
            icon="school"
            title="Welcome!"
            description={`Hello, ${studentInfo.name || 'student'}! Ready to learn?`}
          />
          <DefaultInfoCard
            color="success"
            icon="task"
            title="Quiz Progress"
            description="Current Progress"
            value={`${ongoingQuizzes.length} Ongoing`}
          />
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;
