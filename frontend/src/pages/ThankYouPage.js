import React from 'react';
import '../styles/ThankYouPage.css';

function ThankYouPage() {
  return (
    <div className="thank-you-container">
      <h1>Thank you for registering!</h1>
      <p>We have received your registration information.</p>
      <button onClick={() => window.location.href = '/'}>Return to home page</button>
    </div>
  );
}

export default ThankYouPage;
