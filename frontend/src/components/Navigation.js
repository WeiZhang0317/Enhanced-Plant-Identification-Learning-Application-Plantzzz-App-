// Navigation.js
import React from "react";
import { useNavigate } from "react-router-dom";
import homeIcon from "../images/home.png";

function Navigation() {
  const navigate = useNavigate();

  const handleGoHome = () => {
    navigate("/");
  };

  const navStyle = {
    backgroundColor: "#4CAF50",
    padding: "10px 0",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  };

  const navButtonStyle = {
    display: "flex",
    alignItems: "center",
    margin: "0 20px",
    backgroundColor: "transparent",
    border: "none",
    color: "white",
    padding: "10px 20px",
    borderRadius: "5px",
    cursor: "pointer",
    transition: "background-color 0.3s",
  };

  return (
    <nav style={navStyle}>
      <button onClick={handleGoHome} style={navButtonStyle}>
        <img
          src={homeIcon}
          alt="Home"
          style={{ width: "20px", marginRight: "5px" }}
        />
        Home
      </button>
    </nav>
  );
}

export default Navigation;
