import React, { useState, useEffect } from "react";
import { useUserContext } from "../contexts/UserContext";
import { message, Input, Typography, Select } from "antd";
import "../styles/Profile.css";
import studentAvatar from "../images/student.png";
import teacherAvatar from "../images/teacher.png";

const { Text } = Typography;

const Profile = () => {
  const { user, setUser } = useUserContext();
  const [editing, setEditing] = useState(false);
  const currentYear = new Date().getFullYear();
  const [profileData, setProfileData] = useState({
    username: user ? user.username : "",
    email: user ? user.email : "",
    newPassword: "",
    enrollmentYear: user && user.enrollmentYear ? user.enrollmentYear : `${currentYear}`,
    title: user && user.title ? user.title : "",
  });

  useEffect(() => {
    setProfileData({
      username: user ? user.username : "",
      email: user ? user.email : "",
      newPassword: "",
      enrollmentYear: user && user.enrollmentYear ? user.enrollmentYear : `${currentYear}`,
      title: user && user.title ? user.title : "",
    });
  }, [user]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setProfileData({ ...profileData, [name]: value });
    message.destroy(); // Clear message on new input
  };

  const handleSelectChange = (name, value) => {
    setProfileData({ ...profileData, [name]: value });
    message.destroy(); // Clear message on new input
  };

  const handleSave = async (e) => {
    e.preventDefault();
    if (!profileData.username || !profileData.email) {
      message.error("Username and email cannot be empty");
      return;
    }

    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(profileData.email)) {
      message.error("Invalid email format");
      return;
    }

    if (profileData.newPassword && !/(?=.*\d)(?=.*[a-zA-Z]).{5,}/.test(profileData.newPassword)) {
      message.error("Password must be at least 5 characters long and include both letters and numbers");
      return;
    }

    try {
      const userData = {
        username: profileData.username,
        email: profileData.email,
        newPassword: profileData.newPassword,
        userId: user.userId,
      };
      const response = await fetch("http://localhost:5000/user/update-profile", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(userData),
      });
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const result = await response.json();
      const updatedUser = {
        ...user,
        email: result.Email,
        username: result.Username,
        enrollmentYear: result.EnrollmentYear,
        title: result.Title,
      };
      setUser(updatedUser);
      localStorage.setItem('user', JSON.stringify(updatedUser));
      setEditing(false);
      setProfileData({ ...profileData, newPassword: "" });
      message.success("Profile updated successfully");
    } catch (error) {
      console.error("Failed to fetch:", error);
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
          <h1>Welcome back, {profileData.username}!</h1>
          <p>Email: {profileData.email}</p>
          
          <button onClick={() => setEditing(true)}>Edit Profile</button>
        </>
      ) : (
        <>
          <form onSubmit={handleSave} className="profile-form">
            <div className="profile-form-field">
              <Text>Username (required):</Text>
              <Input
                value={profileData.username}
                onChange={handleChange}
                placeholder="Username"
                name="username"
              />
            </div>
            <div className="profile-form-field">
              <Text>Email (required):</Text>
              <Input
                value={profileData.email}
                onChange={handleChange}
                placeholder="Email"
                name="email"
                type="email"
                autoComplete="off"
              />
            </div>
            <div className="profile-form-field">
              <Text>New Password (optional):</Text>
              <Input.Password
                value={profileData.newPassword}
                onChange={handleChange}
                placeholder="New Password"
                name="newPassword"
                className="fixed-size-input"
                autoComplete="new-password"
              />
              <div className="profile-form-hint">
                Include letters and numbers, at least 5 chars.
              </div>
            </div>
            
            <div className="button-group">
              <button type="submit" className="profile-save-button">
                Save
              </button>
              <button
                type="button"
                onClick={() => setEditing(false)}
                className="profile-cancel-button"
              >
                Cancel
              </button>
            </div>
          </form>
        </>
      )}
    </div>
  );
};

export default Profile;
