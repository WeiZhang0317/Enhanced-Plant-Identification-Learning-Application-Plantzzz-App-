import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import RegisterPage from './pages/RegisterPage';
import StudentRegisterPage from './pages/StudentRegisterPage';
import ThankYouPage from './pages/ThankYouPage'; // Import the new component

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/register/student" element={<StudentRegisterPage />} />
        <Route path="/thank-you" element={<ThankYouPage />} /> {/* New route for the Thank You page */}
      </Routes>
    </Router>
  );
}

export default App;
