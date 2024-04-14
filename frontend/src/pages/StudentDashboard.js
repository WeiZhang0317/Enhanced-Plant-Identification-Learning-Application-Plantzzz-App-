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


// import React, { useState, useEffect } from 'react';
// import { useNavigate } from 'react-router-dom';  // 引入 useNavigate 钩子
// import Navigation from '../components/Navigation';

// function StudentDashboard() {
//   const navigate = useNavigate();  // 使用 useNavigate 钩子

//   // 示例按钮点击事件处理器，用于导航到 UserInfo 页面
//   const handleViewUserInfo = () => {
//     navigate('/user-info');  // 导航到 UserInfo 页面
//   };

//   return (
//     <div className="student-dashboard">
//       <Navigation />
//       <button onClick={handleViewUserInfo} style={{ margin: '20px', padding: '10px 20px' }}>
//         View User Info
//       </button>
//       {/* 其余的 Dashboard 组件内容 */}
//     </div>
//   );
// }

// export default StudentDashboard;
