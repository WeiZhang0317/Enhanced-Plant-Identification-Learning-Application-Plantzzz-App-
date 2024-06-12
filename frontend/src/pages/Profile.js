import React, { useState, useEffect } from "react";
import { useUserContext } from "../contexts/UserContext";
import { message, Input, Typography } from "antd";
import "../styles/Profile.css";
import studentAvatar from "../images/student.png";
import teacherAvatar from "../images/teacher.png";

const { Text } = Typography;

const Profile = () => {
  const { user, setUser } = useUserContext();
  const [editing, setEditing] = useState(false);
  const [username, setUsername] = useState(user ? user.username : "");
  const [email, setEmail] = useState(user ? user.email : "");
  const [password, setPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [errorMessage, setErrorMessage] = useState("");
  const [currentPassword, setCurrentPassword] = useState("");

  useEffect(() => {
    setUsername(user ? user.username : "");
    setEmail(user ? user.email : "");
  }, [user]);

  const handleEditToggle = () => setEditing(!editing);

  const handleSave = async () => {
    try {
      const userData = {
        username,
        email,
        currentPassword,
        newPassword,
        userId: user.userId,
      };
      const response = await fetch(
        "http://localhost:5000/user/update-profile",
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(userData),
        }
      );
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const result = await response.json();
      if (setUser) {
        setUser({
          ...user,
          email: result.Email,
          username: result.Username,
        });
      }
      setEditing(false);
      setPassword("");
      setNewPassword("");
      setErrorMessage("");
      message.success("Profile updated successfully");
    } catch (error) {
      console.error("Failed to fetch:", error);
      setErrorMessage("Failed to update profile: " + error.message);
      message.error("Failed to update profile: " + error.message);
    }
  };

  // Decide which avatar to use based on the user type
  const avatar =
    user && user.userType === "teacher" ? teacherAvatar : studentAvatar;

  return (
    <div className="profile">
      <img
        src={avatar}
        alt={`${
          user && user.userType === "teacher" ? "Teacher" : "Student"
        } Avatar`}
        className="student-avatar"
      />
      {!editing ? (
        <>
          <h1>Welcome back, {username}!</h1>
          <p>Email: {email}</p>
          <button onClick={handleEditToggle}>Edit Profile</button>
        </>
      ) : (
        <>
          <Text>Username:</Text>
          <Input
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            placeholder="Username"
          />
          <Text>Email:</Text>
          <Input
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
          />

          <Text>Current Password:</Text>
          <Input.Password
            className="fixed-size-input"
            value={currentPassword}
            onChange={(e) => setCurrentPassword(e.target.value)}
            autocomplete="new-password"
          />
          <Text>New Password:</Text>
          <Input.Password
            className="fixed-size-input"
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            autocomplete="new-password"
          />
          <div className="button-group">
            <button onClick={handleSave}>Save</button>
            <button onClick={handleEditToggle}>Cancel</button>
          </div>
        </>
      )}
      {errorMessage && <p className="error-message">{errorMessage}</p>}
    </div>
  );
};

export default Profile;
