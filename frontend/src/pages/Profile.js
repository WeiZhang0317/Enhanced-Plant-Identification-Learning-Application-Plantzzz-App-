import React, { useEffect, useState } from 'react';
import { useUserContext } from '../contexts/UserContext';
import '../styles/Profile.css';
import studentAvatar from '../images/student.png';

const Profile = () => {
    const { user } = useUserContext(); // 使用自定义钩子访问用户上下文
    const [studentInfo, setStudentInfo] = useState({
        username: '',
        email: '',
        enrollmentYear: ''
    });

    useEffect(() => {
        // 使用 userId 来获取学生信息
        const fetchStudentInfo = async (userId) => {
            try {
                if (!userId) {
                    console.error('User ID is not available');
                    return;
                }
                // 根据 Flask 应用的配置路由，使用正确的 URL
                const response = await fetch(`http://localhost:5000/student/info?userId=${userId}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error('Failed to fetch student information');
                }
                const data = await response.json();
                // 根据 API 响应设置状态
                setStudentInfo({
                    username: data.Username, // 确保这些属性名称与 API 返回的键匹配
                    email: data.Email,
                    enrollmentYear: data.EnrollmentYear
                });
            } catch (error) {
                console.error('Error fetching student info:', error);
            }
        };

        // 如果 user 对象中有 userId，就调用 fetchStudentInfo
        if (user && user.userId) {
            fetchStudentInfo(user.userId);
        }
    }, [user]); // 如果 user 上下文更新，这个 effect 就会再次运行

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
