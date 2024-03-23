import React from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation"; // Import Navigation component
import studentImage from "../images/student.png";
import teacherImage from "../images/teacher.png";

function RegisterPage() {
  const navigate = useNavigate();

  const handleStudentRegister = () => {
    navigate("/register/student");
  };

  const handleTeacherRegister = () => {
    navigate("/register/teacher");
  };

  const buttonStyle = {
    margin: "10px",
    padding: "20px",
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    border: "1px solid #ddd",
    cursor: "pointer",
    backgroundColor: "#FFF",
    borderRadius: "10px",
    transition: "all 0.3s ease-in-out",
  };

  return (
    <div style={{ backgroundColor: "#F0F2F5", minHeight: "100vh" }}>
      <Navigation /> {/* Use the Navigation component */}
      <div
        style={{
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          marginTop: "40px",
        }}
      >
        <div style={{ marginBottom: "40px" }}>
          <h1 style={{ color: "#4CAF50" }}>Register as...</h1>
        </div>
        <div style={{ display: "flex" }}>
          <div
            onClick={handleStudentRegister}
            style={buttonStyle}
            onMouseOver={(e) =>
              (e.currentTarget.style.boxShadow = "0 8px 16px rgba(0,0,0,0.1)")
            }
            onMouseOut={(e) => (e.currentTarget.style.boxShadow = "none")}
          >
            <img
              src={studentImage}
              alt="Student"
              style={{ width: "100px", marginBottom: "10px" }}
            />
            <span>Student</span>
          </div>
          <div
            onClick={handleTeacherRegister}
            style={buttonStyle}
            onMouseOver={(e) =>
              (e.currentTarget.style.boxShadow = "0 8px 16px rgba(0,0,0,0.1)")
            }
            onMouseOut={(e) => (e.currentTarget.style.boxShadow = "none")}
          >
            <img
              src={teacherImage}
              alt="Teacher"
              style={{ width: "100px", marginBottom: "10px" }}
            />
            <span>Teacher</span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RegisterPage;
