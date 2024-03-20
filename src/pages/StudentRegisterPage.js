import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import homeIcon from '../images/home.png'; // Ensure the path is correct for your project structure

function StudentRegisterPage() {
  const navigate = useNavigate();
  const [studentData, setStudentData] = useState({
    name: '',
    email: '',
    password: '',
  });

  // This function updates the state with the user's input
  const handleChange = (e) => {
    const { name, value } = e.target;
    setStudentData({ ...studentData, [name]: value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Here, you can add the logic to submit the form data, for example, sending data to a server
    console.log(studentData);
    // After submitting, navigate to a thank-you page or a dashboard
    navigate('/thank-you'); // Ensure you have a route and a component for '/thank-you'
  };

  const handleGoHome = () => {
    navigate('/');
  };

  const navStyle = {
    backgroundColor: '#4CAF50', 
    padding: '10px 0',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  };

  const navButtonStyle = {
    display: 'flex',
    alignItems: 'center',
    margin: '0 20px',
    backgroundColor: 'transparent',
    border: 'none',
    color: 'white',
    padding: '10px 20px',
    borderRadius: '5px',
    cursor: 'pointer',
    transition: 'background-color 0.3s',
  };

  return (
    <div style={{ backgroundColor: '#F0F2F5', minHeight: '100vh' }}>
      <nav style={navStyle}>
        <button onClick={handleGoHome} style={navButtonStyle} onMouseOver={e => e.currentTarget.style.backgroundColor = 'rgba(255,255,255,0.2)'} onMouseOut={e => e.currentTarget.style.backgroundColor = 'transparent'}>
          <img src={homeIcon} alt="Home" style={{ width: '20px', marginRight: '5px' }} />
          Home
        </button>
      </nav>
      <div style={{ padding: '20px', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <h1>Student Registration</h1>
        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', width: '300px' }}>
          <label htmlFor="name" style={{ marginBottom: '10px' }}>
            Name:
            <input type="text" id="name" name="name" value={studentData.name} onChange={handleChange} required style={{ marginLeft: '10px' }} />
          </label>
          <label htmlFor="email" style={{ marginBottom: '10px' }}>
            Email:
            <input type="email" id="email" name="email" value={studentData.email} onChange={handleChange} required style={{ marginLeft: '10px' }} />
          </label>
          <label htmlFor="password" style={{ marginBottom: '10px' }}>
            Password:
            <input type="password" id="password" name="password" value={studentData.password} onChange={handleChange} required style={{ marginLeft: '10px' }} />
          </label>
          <button type="submit" style={{ marginTop: '20px', cursor: 'pointer', padding: '10px', backgroundColor: '#4CAF50', color: 'white', border: 'none', borderRadius: '5px' }}>
            Register
          </button>
        </form>
      </div>
    </div>
  );
}

export default StudentRegisterPage;
