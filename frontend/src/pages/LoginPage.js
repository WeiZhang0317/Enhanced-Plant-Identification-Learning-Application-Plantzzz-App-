

import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";
import { useUserContext } from '../contexts/UserContext';


import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEye, faEyeSlash } from '@fortawesome/free-solid-svg-icons';

function LoginPage() {
  const { login } = useUserContext(); // Using the custom hook to access the user context
  const navigate = useNavigate();
  const [loginData, setLoginData] = useState({
    email: "",
    password: "",
  });

  const [error, setError] = useState("");
  const [isPasswordVisible, setIsPasswordVisible] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setLoginData({ ...loginData, [name]: value });
    setError(""); // Clear error message on new input
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!loginData.email || !loginData.password) {
      setError("All fields must be filled out");
      return;
    }
  
    try {
      const response = await fetch('http://localhost:5000/user/login', { 
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: loginData.email,
          password: loginData.password,
        }),
      });
  
      if (response.ok) {
        const data = await response.json();
        console.log(data); 
        login(data)
        if (data.userType === "teacher") {
          navigate("/teacher/dashboard");
        } else if (data.userType === "student") {
          navigate("/student/dashboard", { state: { userId: data.userId } });
        } else {
          setError("Invalid user type");
        }
      } else {
        setError("Invalid email or password");
      }
    } catch (error) {
      console.error("Login error:", error);
      setError("Failed to login. Please try again later.");
    }
  };
  
 
  const togglePasswordVisibility = () => {
    setIsPasswordVisible(!isPasswordVisible);
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

  const toggleVisibilityButtonStyle = {
    position: 'absolute',
    right: '10px',
    top: '50%',
    transform: 'translateY(-50%)',
    border: 'none',
    background: 'none',
    cursor: 'pointer',
    color: '#4CAF50',
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
        <h1 style={{ color: "#4CAF50" }}>Login</h1>
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
            maxWidth: "500px",
          }}
        >
          <div style={formFieldStyle}>
            <label htmlFor="email" style={labelStyle}>
              Email:
            </label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={loginData.email}
              onChange={handleChange}
              style={inputStyle}
            />
          </div>
          <div style={{ ...formFieldStyle, position: 'relative' }}>
            <label htmlFor="password" style={labelStyle}>
              Password:
            </label>
            <input
              type={isPasswordVisible ? "text" : "password"}
              id="password"
              name="password"
              placeholder="Password"
              value={loginData.password}
              onChange={handleChange}
              style={inputStyle}
            />
            <button onClick={togglePasswordVisibility} type="button" style={toggleVisibilityButtonStyle}>
              <FontAwesomeIcon icon={isPasswordVisible ? faEyeSlash : faEye} />
            </button>
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
              marginTop: "10px",
            }}
          >
            Login
          </button>
        </form>
      </div>
    </div>
  );
}

export default LoginPage;
