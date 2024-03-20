import React from 'react';
import logo from '../images/logo.png'; 
import { useNavigate } from 'react-router-dom';


function HomePage() {
  const navigate = useNavigate();

  const handleLoginClick = () => {
    alert('Login');
  };

  const handleRegisterClick = () => {
    navigate('/register'); 
  };

  // Container style for centering everything
  const containerStyle = {
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
    height: '100vh', // Make the container fill the height of the viewport
    marginTop: '-50px', 
  };

  // Button style
  const buttonStyle = {
    width: '200px',
    padding: '10px',
    margin: '10px 0', // Vertical margin
    border: 'none',
    borderRadius: '5px',
    background: '#4CAF50',
    color: 'white',
    cursor: 'pointer',
    outline: 'none',
    boxShadow: '0 2px #999',
    transition: 'all 0.3s ease', // Apply the transition to all properties
  };

  // Function to apply hover effects
  const applyHoverEffect = (e, hover) => {
    e.currentTarget.style.backgroundColor = hover ? '#45a049' : '#4CAF50';
    e.currentTarget.style.boxShadow = hover ? '0 4px #666' : '0 2px #999';
    e.currentTarget.style.transform = hover ? 'translateY(-2px)' : 'translateY(0)';
  };

  return (
    <div style={containerStyle}>
      <img src={logo} alt="Plantzzz Logo" style={{ maxWidth: '400px', marginBottom: '20px' }} />
      <button
        onMouseOver={(e) => applyHoverEffect(e, true)}
        onMouseOut={(e) => applyHoverEffect(e, false)}
        onClick={handleLoginClick}
        style={buttonStyle}
      >
        Login
      </button>
      <button
        onMouseOver={(e) => applyHoverEffect(e, true)}
        onMouseOut={(e) => applyHoverEffect(e, false)}
        onClick={handleRegisterClick}
        style={buttonStyle}
      >
        Register
      </button>
    </div>
  );
}

export default HomePage;
