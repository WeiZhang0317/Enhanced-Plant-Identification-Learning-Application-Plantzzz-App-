import React from 'react';
import { Link } from 'react-router-dom';
import './Sidebar.css'; 

const Sidebar = () => {
  return (
    <div className="sidebar">
      <Link to="/profile">Profile</Link>
      <Link to="/all-quizzes">All Quizzes</Link>
      <Link to="/incorrect-answers/:progressId" >Review Mistakes</Link>
      <Link to="/completed-quizzes">Completed Quizzes</Link>
    </div>
  );
};

export default Sidebar;
