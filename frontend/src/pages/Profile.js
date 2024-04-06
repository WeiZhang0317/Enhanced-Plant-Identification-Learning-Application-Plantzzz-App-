import React from 'react';
import '../styles/Profile.css';

const Profile = ({ studentInfo }) => {
  return (
    <div className="profile">
      <h1>Welcome back, {studentInfo.username}!</h1>
      <p>Email: {studentInfo.email}</p>
      <p>Enrollment Year: {studentInfo.enrollmentYear}</p>
    </div>
  );
};

export default Profile;
