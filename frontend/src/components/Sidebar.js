import React from 'react';
import { Link } from 'react-router-dom';
import './Sidebar.css'; // 假设你已经创建了一个对应的CSS文件

const Sidebar = () => {
  return (
    <div className="sidebar">
      <Link to="/profile">Profile</Link>
      <Link to="/ongoing-quizzes">Ongoing Quizzes</Link>
      <Link to="/completed-quizzes">Completed Quizzes</Link>
    </div>
  );
};

export default Sidebar;
