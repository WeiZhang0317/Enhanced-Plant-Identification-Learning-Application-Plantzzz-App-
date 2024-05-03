import React, { useState, useContext } from 'react';
import { useUserContext } from '../contexts/UserContext';
import '../styles/Profile.css';
import studentAvatar from '../images/student.png';

const Profile = () => {
    const { user, setUser } = useUserContext(); // Assuming setUser is used to update context
    const [editing, setEditing] = useState(false);
    const [username, setUsername] = useState(user ? user.username : '');
    const [email, setEmail] = useState(user ? user.email : '');
    const [password, setPassword] = useState('');
    const [newPassword, setNewPassword] = useState('');

    const handleEditToggle = () => setEditing(!editing);

    const handleSave = async () => {
        try {
            const response = await fetch('http://localhost:5000/user/update-profile', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, email, newPassword })
            });
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const result = await response.json();
            setUser(result); // Update the user context
            setEditing(false);
            setPassword('');
            setNewPassword('');
        } catch (error) {
            console.error('Failed to fetch:', error);
            alert('Failed to update profile: ' + error.message);
        }
    };
    
   
    return (
        <div className="profile">
            <img src={studentAvatar} alt="Student Avatar" className="student-avatar"/>
            {!editing ? (
                <>
                    <h1>Welcome back, {username}!</h1>
                    <p>Email: {email}</p>
                    <button onClick={handleEditToggle}>Edit Profile</button>
                </>
            ) : (
                <>
                    <input value={username} onChange={e => setUsername(e.target.value)} placeholder="Username" />
                    <input value={email} onChange={e => setEmail(e.target.value)} placeholder="Email" />
                    <input type="password" value={password} onChange={e => setPassword(e.target.value)} placeholder="Current Password" />
                    <input type="password" value={newPassword} onChange={e => setNewPassword(e.target.value)} placeholder="New Password" />
                    <button onClick={handleSave}>Save</button>
                    <button onClick={handleEditToggle}>Cancel</button>
                </>
            )}
        </div>
    );
};

export default Profile;
