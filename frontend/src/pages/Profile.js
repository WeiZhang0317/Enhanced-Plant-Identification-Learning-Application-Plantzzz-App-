import React from 'react';
import { useUserContext } from '../contexts/UserContext';
import '../styles/Profile.css';
import studentAvatar from '../images/student.png';

const Profile = () => {
    const { user } = useUserContext(); // Using the custom hook to access the user context

    return (
        <div className="profile">
            <img src={studentAvatar} alt="Student Avatar" className="student-avatar"/>
            <h1>Welcome back, {user ? user.username : ''}!</h1>
            <p>Email: {user ? user.email : ''}</p>
            {user && user.userType === 'student' && <p>Enrollment Year: {user.enrollmentYear}</p>}
            {user && user.userType === 'teacher' && <p>Title: {user.title}</p>}
        </div>
    );
};

export default Profile;
