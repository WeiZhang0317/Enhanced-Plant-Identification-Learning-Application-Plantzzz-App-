import React from 'react';
import '../styles/Profile.css';
// Import the student avatar image
import studentAvatar from '../images/student.png'; // Adjust the path as necessary

const Profile = ({ studentInfo }) => {
  return (
    <div className="profile">
      {/* Display the student avatar */}
      <img src={studentAvatar} alt="Student Avatar" className="student-avatar"/>
      <h1>Welcome back, {studentInfo.username}!</h1>
      <p>Email: {studentInfo.email}</p>
      <p>Enrollment Year: {studentInfo.enrollmentYear}</p>
    </div>
  );
};

export default Profile;
