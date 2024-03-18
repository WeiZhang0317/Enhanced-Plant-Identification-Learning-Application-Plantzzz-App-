import React from 'react';
import { useNavigate } from 'react-router-dom';
import studentImage from './images/student.png';
import teacherImage from './images/teacher.png';
import homeIcon from './images/home.png'; 

function RegisterPage() {
  const navigate = useNavigate();

  const handleStudentRegister = () => {
    navigate('/register/student');
  };

  const handleTeacherRegister = () => {
    navigate('/register/teacher');
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

  const buttonStyle = {
    margin: '10px',
    padding: '20px',
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    border: '1px solid #ddd', 
    cursor: 'pointer',
    backgroundColor: '#FFF',
    borderRadius: '10px',
    transition: 'all 0.3s ease-in-out', 
  };

  return (
    <div style={{ backgroundColor: '#F0F2F5', minHeight: '100vh' }}>
      <nav style={navStyle}>
        <button onClick={handleGoHome} style={navButtonStyle} onMouseOver={e => e.currentTarget.style.backgroundColor = 'rgba(255,255,255,0.2)'} onMouseOut={e => e.currentTarget.style.backgroundColor = 'transparent'}>
          <img src={homeIcon} alt="Home" style={{ width: '20px', marginRight: '5px' }} />
          Home
        </button>
      </nav>
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginTop: '40px' }}>
        <div style={{ marginBottom: '40px' }}>
          <h1 style={{ color: '#4CAF50' }}>Register as...</h1>
        </div>
        <div style={{ display: 'flex' }}>
          <div onClick={handleStudentRegister} style={buttonStyle} onMouseOver={e => e.currentTarget.style.boxShadow = '0 8px 16px rgba(0,0,0,0.1)'} onMouseOut={e => e.currentTarget.style.boxShadow = 'none'}>
            <img src={studentImage} alt="Student" style={{ width: '100px', marginBottom: '10px' }} />
            <span>Student</span>
          </div>
          <div onClick={handleTeacherRegister} style={buttonStyle} onMouseOver={e => e.currentTarget.style.boxShadow = '0 8px 16px rgba(0,0,0,0.1)'} onMouseOut={e => e.currentTarget.style.boxShadow = 'none'}>
            <img src={teacherImage} alt="Teacher" style={{ width: '100px', marginBottom: '10px' }} />
            <span>Teacher</span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default RegisterPage;
