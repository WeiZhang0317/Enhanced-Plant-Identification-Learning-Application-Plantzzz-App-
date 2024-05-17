import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { UserProvider } from './contexts/UserContext';
import { QuizProvider } from './contexts/QuizContext'; 
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import StudentRegisterPage from './pages/StudentRegisterPage';
import TeacherRegisterPage from './pages/TeacherRegisterPage';
import ThankYouPage from './pages/ThankYouPage';
import TeacherDashboard from './pages/TeacherDashboard';
import StudentDashboard from './pages/StudentDashboard';
import Loader from './components/Loader'; 
import UserInfo from './components/UserInfo'; 
import './styles/App.css'; // Import global styles

function App() {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setLoading(false); // Hide loader after 2 seconds
    }, 2000);

    return () => clearTimeout(timer); // Cleanup the timer
  }, []);

  return (
    <UserProvider>
      <QuizProvider> 
        <Router>
          {loading && <Loader />} {/* Show loader if loading is true */}
          <div className={loading ? 'hidden' : ''}> {/* Hide content if loading is true */}
            <Routes>
              <Route path="/" element={<HomePage />} />
              <Route path="/login" element={<LoginPage />} />
              <Route path="/register" element={<RegisterPage />} />
              <Route path="/register/student" element={<StudentRegisterPage />} />
              <Route path="/register/teacher" element={<TeacherRegisterPage />} />
              <Route path="/thank-you" element={<ThankYouPage />} />
              <Route path="/teacher/dashboard/*" element={<TeacherDashboard />} />
              <Route path="/student/dashboard/*" element={<StudentDashboard />} />
              <Route path="/user-info" element={<UserInfo />} />
            </Routes>
          </div>
        </Router>
      </QuizProvider>
    </UserProvider>
  );
}

export default App;
