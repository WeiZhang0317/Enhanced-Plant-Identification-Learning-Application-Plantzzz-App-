import React, { useEffect } from 'react';
import '../styles/ThankYouPage.css';
import Navigation from "../components/Navigation";
import confetti from 'canvas-confetti';

function ThankYouPage() {
  useEffect(() => {
    const duration = 5 * 1000;
    const animationEnd = Date.now() + duration;
    const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 0 };

    function randomInRange(min, max) {
      return Math.random() * (max - min) + min;
    }

    const interval = setInterval(() => {
      const timeLeft = animationEnd - Date.now();

      if (timeLeft <= 0) {
        return clearInterval(interval);
      }

      const particleCount = 50 * (timeLeft / duration);
      confetti(Object.assign({}, defaults, { 
        particleCount, 
        origin: { x: randomInRange(0.1, 0.3), y: Math.random() - 0.2 } 
      }));
      confetti(Object.assign({}, defaults, { 
        particleCount, 
        origin: { x: randomInRange(0.7, 0.9), y: Math.random() - 0.2 } 
      }));
    }, 250);
  }, []);

  return (
    <>
      <Navigation />
      <div className="thank-you-container">
        <h1>Thank you for registering!</h1>
        <p>We have received your registration information.</p>
        <button onClick={() => window.location.href = '/'}>Return to home page</button>
      </div>
    </>
  );
}


export default ThankYouPage;
