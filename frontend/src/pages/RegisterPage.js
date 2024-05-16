import React from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation"; // Import Navigation component
import studentImage from "../images/student.png";
import teacherImage from "../images/teacher.png";
import '../styles/RegisterPage.css'; // Import the CSS file

function RegisterPage() {
  const navigate = useNavigate();

  const handleStudentRegister = () => {
    navigate("/register/student");
  };

  const handleTeacherRegister = () => {
    navigate("/register/teacher");
  };

  return (
    <div className="register-page">
      <Navigation />
      <div className="register-container">
      <div className="register-content">
        <div className="register-title">
          <h1>Register as...</h1>
        </div>
        <div className="register-buttons">
          <div
            onClick={handleStudentRegister}
            className="register-button"
            onMouseOver={(e) =>
              (e.currentTarget.style.boxShadow = "0 8px 16px rgba(0,0,0,0.1)")
            }
            onMouseOut={(e) => (e.currentTarget.style.boxShadow = "none")}
          >
            <img
              src={studentImage}
              alt="Student"
              className="register-image"
            />
            <span>Student</span>
          </div>
          <div
            onClick={handleTeacherRegister}
            className="register-button"
            onMouseOver={(e) =>
              (e.currentTarget.style.boxShadow = "0 8px 16px rgba(0,0,0,0.1)")
            }
            onMouseOut={(e) => (e.currentTarget.style.boxShadow = "none")}
          >
            <img
              src={teacherImage}
              alt="Teacher"
              className="register-image"
            />
            <span>Teacher</span>
          </div>
        </div>
      </div>
    </div>
    </div>
  );
}

export default RegisterPage;
