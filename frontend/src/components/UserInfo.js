import React from 'react';
import { useUserContext } from '../contexts/UserContext'; // 确保路径正确

const UserInfo = () => {
    const { user } = useUserContext(); // 使用自定义钩子获取用户数据

    if (!user) {
        return <div>No user information available.</div>;
    }

    return (
        <div>
            <h1>User Information</h1>
            <p><strong>Username:</strong> {user.username}</p>
            <p><strong>Email:</strong> {user.email}</p>
            <p><strong>User Type:</strong> {user.userType}</p>
            {/* 仅当用户是学生时显示 */}
            {user.userType === 'student' && (
                <>
                    <p><strong>Student ID:</strong> {user.studentId}</p>
                    <p><strong>Enrollment Year:</strong> {user.enrollmentYear}</p>
                </>
            )}
            {/* 仅当用户是教师时显示 */}
            {user.userType === 'teacher' && (
                <>
                    <p><strong>Teacher ID:</strong> {user.teacherId}</p>
                    <p><strong>Title:</strong> {user.title}</p>
                </>
            )}
        </div>
    );
};

export default UserInfo;
