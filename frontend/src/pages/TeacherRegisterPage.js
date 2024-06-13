import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";
import "../styles/TeacherRegisterPage.css"; // Import the CSS file
import { Input, Select, message } from 'antd';

function TeacherRegisterPage() {
  const navigate = useNavigate();
  const [teacherData, setTeacherData] = useState({
    name: "",
    email: "",
    password: "",
    teacherId: "",
    title: "", 
  });

  const [error, setError] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setTeacherData({ ...teacherData, [name]: value });
    setError(""); // Clear error message on new input
  };

  const handleTitleChange = (value) => {
    setTeacherData({ ...teacherData, title: value });
    setError(""); // Clear error message on new input
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (
      !teacherData.name ||
      !teacherData.email ||
      !teacherData.password ||
      !teacherData.teacherId ||
      !teacherData.title 
    ) {
      setError("All fields must be filled out");
      return;
    }

    fetch('http://localhost:5000/teacher/register/teacher', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(teacherData), 
    })
      .then(response => {
        if (!response.ok) {
          if (response.status === 409) {
            return response.json().then(data => {
              throw new Error(data.message || 'There is a conflict with the existing data.');
            });
          } else {
            throw new Error('Failed to register. Please try again later.');
          }
        }
        return response.json();
      })
      .then(data => {
        console.log(data);
        navigate("/thank-you");
      })
      .catch(error => {
        console.error('Error:', error);
        setError(error.message);
        message.error(error.message);
      });
  };

  return (
    <div className="teacher-register-page">
      <Navigation />
      <div className="teacher-register-container">
        <h1 className="teacher-register-title">Teacher Registration</h1>
        {error && <div className="teacher-register-error-message">{error}</div>}
        <form onSubmit={handleSubmit} className="teacher-register-form">
          <div className="teacher-register-form-field">
            <label htmlFor="name" className="teacher-register-form-label">
              Name:
            </label>
            <Input
              type="text"
              id="name"
              name="name"
              placeholder="Name"
              value={teacherData.name}
              onChange={handleChange}
              className="teacher-register-form-input"
            />
          </div>
          <div className="teacher-register-form-field">
            <label htmlFor="email" className="teacher-register-form-label">
              Email:
            </label>
            <Input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={teacherData.email}
              onChange={handleChange}
              className="teacher-register-form-input"
              autoComplete="off"
            />
          </div>
          <div className="teacher-register-form-field">
            <label htmlFor="password" className="teacher-register-form-label">
              Password:
            </label>
            <Input.Password
              id="password"
              name="password"
              placeholder="Password"
              value={teacherData.password}
              onChange={handleChange}
              autoComplete="new-password"
              className="teacher-register-form-input"
              pattern="(?=.*\d)(?=.*[a-zA-Z]).{5,}"
              title="Password must be at least 5 characters long and include both letters and numbers"
            />
            <div className="teacher-register-form-hint">
              Include letters and numbers, at least 5 chars.
            </div>
          </div>

          <div className="teacher-register-form-field">
            <label htmlFor="teacherId" className="teacher-register-form-label">
              Teacher ID:
            </label>
            <Input
              type="text" // Keep as text to allow leading zeros
              id="teacherId"
              name="teacherId"
              placeholder="Teacher ID"
              value={teacherData.teacherId}
              onChange={handleChange}
              className="teacher-register-form-input"
            />
          </div>
         
          <div className="teacher-register-form-field">
            <label htmlFor="title" className="teacher-register-form-label">
              Title: 
            </label>
            <Input
              type="text"
              id="title"
              name="title"
              placeholder="Title"
              value={teacherData.title}
              onChange={handleChange}
              className="teacher-register-form-input"
              maxLength={255}
            />
          </div>

          <button type="submit" className="teacher-register-submit-button">
            Register
          </button>
        </form>
      </div>
    </div>
  );
}

export default TeacherRegisterPage;
