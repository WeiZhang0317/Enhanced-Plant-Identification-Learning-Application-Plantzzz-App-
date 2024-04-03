import React from "react";
import { useNavigate } from "react-router-dom";
import { useUserContext } from '../contexts/UserContext';
import homeIcon from "../images/home.png";

function Navigation() {
  const navigate = useNavigate();
  const { user, logout } = useUserContext();

  const handleGoHome = () => {
    navigate(user ? '/dashboard' : '/');
  };

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  const navStyle = {
    backgroundColor: "#4CAF50",
    padding: "10px 0",
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    paddingLeft: "20px",
    paddingRight: "20px",
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
        <img src={homeIcon} alt="Home" style={{ width: "20px", marginRight: "5px" }} />
        Home
      </button>
      {user && (
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <span style={{ color: 'white', marginRight: '20px' }}>{user.username}</span>
          <button onClick={handleLogout} style={navButtonStyle}>Logout</button>
        </div>
      )}
    </nav>
  );
}

export default Navigation;


