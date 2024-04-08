import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { UserProvider } from './contexts/UserContext';
import HomePage from './pages/HomePage';
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import StudentRegisterPage from './pages/StudentRegisterPage';
import TeacherRegisterPage from './pages/TeacherRegisterPage';
import ThankYouPage from './pages/ThankYouPage';
import TeacherDashboard from './pages/TeacherDashboard';
import StudentDashboard from './pages/StudentDashboard';
// 引入MUI的ThemeProvider和createTheme
import { ThemeProvider, createTheme } from '@mui/material/styles';

// 创建你的MUI主题
const theme = createTheme({
  // 在这里可以自定义主题，或者直接使用默认主题
});

function App() {
  return (
    <UserProvider>
      <ThemeProvider theme={theme}> {/* 在这里使用ThemeProvider包裹应用 */}
        <Router>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/register" element={<RegisterPage />} />
            <Route path="/register/student" element={<StudentRegisterPage />} />
            <Route path="/register/teacher" element={<TeacherRegisterPage />} />
            <Route path="/thank-you" element={<ThankYouPage />} />
            <Route path="/teacher/dashboard" element={<TeacherDashboard />} />
            <Route path="/student/dashboard" element={<StudentDashboard />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </UserProvider>
  );
}

export default App;
