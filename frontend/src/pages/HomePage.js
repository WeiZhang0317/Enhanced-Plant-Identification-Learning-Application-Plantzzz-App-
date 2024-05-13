import React from "react";
import logo from "../images/logo.png";
import { useNavigate } from "react-router-dom";
import '../styles/HomePage.css'; // Importing the CSS file with specific selectors

function HomePage() {
  const navigate = useNavigate();

  const handleLoginClick = () => {
    navigate("/login"); 
  };

  const handleRegisterClick = () => {
    navigate("/register");
  };

  return (
    <div className="homepage">
      <img src={logo} alt="Plantzzz Logo" className="homepage-logo"/>
      <button
        onMouseOver={(e) => e.currentTarget.classList.add('homepage-button-hovered')}
        onMouseOut={(e) => e.currentTarget.classList.remove('homepage-button-hovered')}
        onClick={handleLoginClick}
        className="homepage-button"
      >
        Login
      </button>
      <button
        onMouseOver={(e) => e.currentTarget.classList.add('homepage-button-hovered')}
        onMouseOut={(e) => e.currentTarget.classList.remove('homepage-button-hovered')}
        onClick={handleRegisterClick}
        className="homepage-button"
      >
        Register
      </button>
    </div>
  );
}

export default HomePage;
