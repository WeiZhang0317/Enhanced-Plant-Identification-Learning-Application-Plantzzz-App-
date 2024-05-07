import React from 'react';
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
import UserInfo from './components/UserInfo'; // 导入 UserInfo 组件

function App() {
  return (
 
      <UserProvider>
        <QuizProvider> 
        <Router>
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
        </Router>
        </QuizProvider>
      </UserProvider>

  );
}

export default App;
