import React, { useState, useEffect } from 'react';
import { useUserContext } from '../contexts/UserContext';
import '../styles/Profile.css';
import studentAvatar from '../images/student.png';
import teacherAvatar from '../images/teacher.png'; 

const Profile = () => {
    const { user, setUser } = useUserContext();
    const [editing, setEditing] = useState(false);
    const [username, setUsername] = useState(user ? user.username : '');
    const [email, setEmail] = useState(user ? user.email : '');
    const [password, setPassword] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [errorMessage, setErrorMessage] = useState('');
    const [successMessage, setSuccessMessage] = useState('');

    useEffect(() => {
        setUsername(user ? user.username : '');
        setEmail(user ? user.email : '');
    }, [user]);

    const handleEditToggle = () => setEditing(!editing);

    const handleSave = async () => {
        try {
            const userData = { username, email, newPassword, userId: user.userId };
            const response = await fetch('http://localhost:5000/user/update-profile', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(userData)
            });
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const result = await response.json();
            if (setUser) {
                setUser({
                    ...user,
                    email:result.Email,
                    username:result.Username
                });
            }
            setEditing(false);
            setPassword('');
            setNewPassword('');
            setErrorMessage('');
            setSuccessMessage('Profile updated successfully');
            setTimeout(() => {
                setSuccessMessage('');
            }, 3000); // Hide success message after 3 seconds
        } catch (error) {
            console.error('Failed to fetch:', error);
            setErrorMessage('Failed to update profile: ' + error.message);
        }
    };

    // Decide which avatar to use based on the user type
    const avatar = user && user.userType === 'teacher' ? teacherAvatar : studentAvatar;

    return (
        <div className="profile">
            <img src={avatar} alt={`${user && user.userType === 'teacher' ? 'Teacher' : 'Student'} Avatar`} className="student-avatar"/>
            {!editing ? (
                <>
                    <h1>Welcome back, {username}!</h1>
                    <p>Email: {email}</p>
                    <button onClick={handleEditToggle}>Edit Profile</button>
                </>
            ) : (
                <>
                    <label>Username:</label>
                    <input value={username} onChange={e => setUsername(e.target.value)} placeholder="Username" />
                    <label>Email:</label>
                    <input value={email} onChange={e => setEmail(e.target.value)} placeholder="Email" />
                    <label>New Password:</label>
                    <input type="password" value={newPassword} onChange={e => setNewPassword(e.target.value)} placeholder="New Password" />
                    <div className="button-group">
                        <button onClick={handleSave}>Save</button>
                        <button onClick={handleEditToggle}>Cancel</button>
                    </div>
                </>
            )}
            {errorMessage && <p className="error-message">{errorMessage}</p>}
            {successMessage && <p className="success-message">{successMessage}</p>}
        </div>
    );
};

export default Profile;