import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";

function StudentRegisterPage() {
  const navigate = useNavigate();
  const currentYear = new Date().getFullYear();
  const [studentData, setStudentData] = useState({
    name: "",
    email: "",
    password: "",
    enrollmentYear: `${currentYear}`,
    studentId: "",
  });

  const [error, setError] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setStudentData({ ...studentData, [name]: value });
    setError(""); // Clear error message on new input
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (
      !studentData.name ||
      !studentData.email ||
      !studentData.password ||
      !studentData.enrollmentYear ||
      !studentData.studentId
    ) {
      setError("All fields must be filled out");
      return;
    }
  
    
    fetch('http://localhost:5000/student/register/student', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(studentData),
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
  const hintStyle = {
    fontSize: "0.75rem",
    color: "#6c757d",
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
        <h1 style={{ color: "#4CAF50" }}>Student Registration</h1>
        {error && <p style={{ color: "red" }}>{error}</p>}
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
              value={studentData.name}
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
              value={studentData.email}
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
              value={studentData.password}
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
            <label htmlFor="studentId" style={labelStyle}>
              Student ID:
            </label>
            <input
              type="text" // Keep as text to allow leading zeros
              id="studentId"
              name="studentId"
              placeholder="Student ID"
              value={studentData.studentId}
              onChange={handleChange}
              style={inputStyle}
              pattern="\d*" // Pattern to match a string of digits
              title="Student ID must be a number" // Tooltip for pattern mismatch
            />
          </div>
          <div style={formFieldStyle}>
            <label htmlFor="enrollmentYear" style={labelStyle}>
              Year:
            </label>
            <select
              id="enrollmentYear"
              name="enrollmentYear"
              value={studentData.enrollmentYear}
              onChange={handleChange}
              style={inputStyle}
            >
              {Array.from(
                { length: currentYear - 1999 },
                (_, index) => 2000 + index
              ).map((year) => (
                <option key={year} value={year}>
                  {year}
                </option>
              ))}
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

export default StudentRegisterPage;
