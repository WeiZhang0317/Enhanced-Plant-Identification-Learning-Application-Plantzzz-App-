import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import Navigation from "../components/Navigation";
import { useUserContext } from "../contexts/UserContext";
import "../styles/LoginPage.css";
import { Input } from "antd";
function LoginPage() {
  const { login } = useUserContext(); // Using the custom hook to access the user context
  const navigate = useNavigate();
  const [loginData, setLoginData] = useState({
    email: "",
    password: "",
  });

  const [error, setError] = useState("");

  const [showPassword, setShowPassword] = useState(false);

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
      const response = await fetch("http://localhost:5000/user/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          email: loginData.email,
          password: loginData.password,
        }),
      });

      if (response.ok) {
        const data = await response.json();
        console.log(data);
        login(data);
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

  return (
    <div className="login-page">
      <Navigation />
      <div className="login-container">
        {error && <div className="login-error">{error}</div>}
        <form onSubmit={handleSubmit} className="login-form">
          <div className="login-form-field">
            <h1 className="login-title">Login</h1>
            <label htmlFor="email" className="login-label">
              Email:
            </label>
            <Input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              value={loginData.email}
              onChange={handleChange}
              className="login-input"
            />
          </div>
          <div className="login-form-field">
            <label htmlFor="password" className="login-label">
              Password:
            </label>
            {/* <div className="password-input-container"> */}
              <Input.Password
                id="password"
                name="password"
                className="login-input"
                onChange={handleChange}
                value={loginData.password}
                placeholder="Password"
              />
{/*               
            </div> */}
          </div>
          <button type="submit" className="login-button">
            Login
          </button>
          <div className="login-footer">
            <p>
              Don't have an account?{" "}
              <a href="/register" className="register-link">
                Register here
              </a>
            </p>
          </div>
        </form>
      </div>
    </div>
  );
}

export default LoginPage;
