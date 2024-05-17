import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";
import "../styles/StudentRegisterPage.css"; // Import the CSS file

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

  return (
    <div className="student-register-page">
      <Navigation />
      <div className="student-register-container">
        <h1 className="student-register-title">Student Registration</h1>
        {error && <div className="student-register-error-message">{error}</div>}
        <form onSubmit={handleSubmit} className="student-register-form">
          <div className="student-register-form-field">
            <label htmlFor="name" className="student-register-form-label">
              Name:
            </label>
            <input
              type="text"
              id="name"
              name="name"
              placeholder="Name"
              value={studentData.name}
              onChange={handleChange}
              className="student-register-form-input"
            />
          </div>
          <div className="student-register-form-field">
            <label htmlFor="email" className="student-register-form-label">
              Email:
            </label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={studentData.email}
              onChange={handleChange}
              className="student-register-form-input"
            />
          </div>
          <div className="student-register-form-field">
            <label htmlFor="password" className="student-register-form-label">
              Password:
            </label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              value={studentData.password}
              onChange={handleChange}
              className="student-register-form-input"
              pattern="(?=.*\d)(?=.*[a-zA-Z]).{5,}"
              title="Password must be at least 5 characters long and include both letters and numbers"
            />
            <div className="student-register-form-hint">
              Include letters and numbers, at least 5 chars.
            </div>
          </div>

          <div className="student-register-form-field">
            <label htmlFor="studentId" className="student-register-form-label">
              Student ID:
            </label>
            <input
              type="text"
              id="studentId"
              name="studentId"
              placeholder="Student ID"
              value={studentData.studentId}
              onChange={handleChange}
              className="student-register-form-input"
              pattern="\d*"
              title="Student ID must be a number"
            />
          </div>
          <div className="student-register-form-field">
            <label htmlFor="enrollmentYear" className="student-register-form-label">
              Year:
            </label>
            <select
              id="enrollmentYear"
              name="enrollmentYear"
              value={studentData.enrollmentYear}
              onChange={handleChange}
              className="student-register-form-input"
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

          <button type="submit" className="student-register-submit-button">
            Register
          </button>
        </form>
      </div>
    </div>
  );
}

export default StudentRegisterPage;
