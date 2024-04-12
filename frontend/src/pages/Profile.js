import React, { useEffect, useState } from 'react';
import { useUserContext } from '../contexts/UserContext'; // Make sure the path is correct
import '../styles/Profile.css';
import studentAvatar from '../images/student.png';

const Profile = () => {
    const { user } = useUserContext(); // Using the custom hook to access the user context
    const [studentInfo, setStudentInfo] = useState({
        username: '',
        email: '',
        enrollmentYear: ''
    });

    useEffect(() => {
        const fetchStudentInfo = async () => {
            try {
                const studentId = user?.studentId;
                if (!studentId) {
                    console.error('Student ID is not available');
                    return;
                }
                // Correct URL based on your Flask app's configured route
                const response = await fetch(`http://localhost:5000/student/info?studentId=${studentId}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch student information');
                }
                const data = await response.json();
                // Set state with the correct keys based on your API response
                setStudentInfo({
                    username: data.Username, // Ensure these property names match the keys returned from your API
                    email: data.Email,
                    enrollmentYear: data.EnrollmentYear
                });
            } catch (error) {
                console.error('Error fetching student info:', error);
            }
        };

        fetchStudentInfo();
    }, [user]); // Dependency on 'user' ensures this effect runs again if the user context updates

    return (
        <div className="profile">
            <img src={studentAvatar} alt="Student Avatar" className="student-avatar"/>
            <h1>Welcome back, {studentInfo.username}!</h1>
            <p>Email: {studentInfo.email}</p>
            <p>Enrollment Year: {studentInfo.enrollmentYear}</p>
        </div>
    );
};

export default Profile;
