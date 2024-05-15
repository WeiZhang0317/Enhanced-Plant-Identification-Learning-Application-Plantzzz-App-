import React from "react";
import { useNavigate } from "react-router-dom";
import { useUserContext } from '../contexts/UserContext';
import arrowIcon from "../images/arrow.png";
import userIcon from "../images/user.png";
import logoutIcon from "../images/logout.png";

function Navigation() {
  const navigate = useNavigate();
  const { user, logout } = useUserContext();

  const handleGoBack = () => {
    navigate(-1);
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

  const iconStyle = {
    width: "20px",
    marginRight: "5px",
  };

  return (
    <nav style={navStyle}>
      <button onClick={handleGoBack} style={navButtonStyle}>
        <img src={arrowIcon} alt="Back" style={iconStyle} />
        Back
      </button>
      {user && (
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <img src={userIcon} alt="User" style={iconStyle} />
          <span style={{ color: 'white', marginRight: '20px' }}>{user.username}</span>
          <button onClick={handleLogout} style={navButtonStyle}>
            <img src={logoutIcon} alt="Logout" style={iconStyle} />
            Logout
          </button>
        </div>
      )}
    </nav>
  );
}

export default Navigation;
