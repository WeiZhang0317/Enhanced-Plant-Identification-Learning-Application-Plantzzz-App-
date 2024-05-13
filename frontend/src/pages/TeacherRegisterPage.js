import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";

function TeacherRegisterPage() {
  const navigate = useNavigate();
  const [teacherData, setTeacherData] = useState({
    name: "",
    email: "",
    password: "",
    teacherId: "",
    title: "", 
  });

  const [title, setTitle] = useState(""); 
  const [error, setError] = useState("");

  const hintStyle = {
    fontSize: "0.75rem",
    color: "#6c757d",
    width: "100%",
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setTeacherData({ ...teacherData, [name]: value });
    setError(""); // Clear error message on new input
  };

  
  const handleTitleChange = (e) => {
    setTitle(e.target.value);
    setTeacherData({ ...teacherData, title: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (
      !teacherData.name ||
      !teacherData.email ||
      !teacherData.password ||
      !teacherData.teacherId ||
      !title 
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
      });
  };

  const errorMessageStyle = {
    color: "#721c24",
    backgroundColor: "#f8d7da",
    borderColor: "#f5c6cb",
    padding: "10px",
    borderRadius: "4px",
    margin: "10px 0 20px",
    border: "1px solid transparent",
    width: "100%",
    textAlign: "center",
    fontWeight: "600",
    boxShadow: "0 0 5px rgba(0,0,0,0.2)",
  };

  const formFieldStyle = {
    display: "flex",
    flexDirection: "column",
    alignItems: "flex-start",
    margin: "10px 0",
    width: "100%",
  };

  const labelStyle = {
    marginBottom: "8px",
    fontWeight: "bold",
    color: "#4CAF50",
  };

  const inputStyle = {
    padding: "12px",
    border: "1px solid #ccc",
    borderRadius: "5px",
    marginBottom: "8px",
    width: "100%",
  };

  return (
    <div style={{ backgroundColor: "#F0F2F5", minHeight: "100vh" }}>
      <Navigation />
      <div
        style={{
          padding: "20px",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <h1 style={{ color: "#4CAF50" }}>Teacher Registration</h1>
        {error && <div style={errorMessageStyle}>{error}</div>}
        <form
          onSubmit={handleSubmit}
          style={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            padding: "40px",
            marginTop: "20px",
            boxShadow: "0 4px 8px rgba(0,0,0,0.1)",
            borderRadius: "8px",
            backgroundColor: "white",
            width: "100%",
            maxWidth: "500px", // Adjusted for better layout
          }}
        >
          <div style={formFieldStyle}>
            <label htmlFor="name" style={labelStyle}>
              Name:
            </label>
            <input
              type="text"
              id="name"
              name="name"
              placeholder="Name"
              value={teacherData.name}
              onChange={handleChange}
              style={inputStyle}
            />
          </div>
          <div style={formFieldStyle}>
            <label htmlFor="email" style={labelStyle}>
              Email:
            </label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={teacherData.email}
              onChange={handleChange}
              style={inputStyle}
            />
          </div>
          <div style={formFieldStyle}>
            <label htmlFor="password" style={labelStyle}>
              Password:
            </label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              value={teacherData.password}
              onChange={handleChange}
              style={inputStyle}
              pattern="(?=.*\d)(?=.*[a-zA-Z]).{5,}"
              title="Password must be at least 5 characters long and include both letters and numbers"
            />
            <div style={hintStyle}>
              Include letters and numbers, at least 5 chars.
            </div>
          </div>

          <div style={formFieldStyle}>
            <label htmlFor="teacherId" style={labelStyle}>
              Teacher ID:
            </label>
            <input
              type="text" // Keep as text to allow leading zeros
              id="teacherId"
              name="teacherId"
              placeholder="Teacher ID"
              value={teacherData.teacherId}
              onChange={handleChange}
              style={inputStyle}
            />
          </div>

         
          <div style={formFieldStyle}>
            <label htmlFor="title" style={labelStyle}>
              Title: 
            </label>
            <select
              id="title"
              name="title" 
              value={title}
              onChange={handleTitleChange} 
              style={inputStyle}
            >
              <option value="">Select title</option> 
              <option value="tutor">Tutor</option>
              <option value="professor">Professor</option>
            </select>
          </div>

          <button
            type="submit"
            style={{
              width: "100%",
              padding: "10px",
              backgroundColor: "#4CAF50",
              color: "white",
              border: "none",
              borderRadius: "5px",
              cursor: "pointer",
              boxShadow: "0 4px 8px rgba(0,0,0,0.1)",
              marginTop: "10px",
            }}
          >
            Register
          </button>
        </form>
      </div>
    </div>
  );
}

export default TeacherRegisterPage;
