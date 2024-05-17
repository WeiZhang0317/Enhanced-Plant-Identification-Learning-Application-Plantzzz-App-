import React from 'react';
import '../styles/Loader.css'; // Import the CSS file for the loader

function Loader() {
  return (
    <div className="loader-container">
      <div className="loader"></div>
      <div className="loader-text">Loading...</div> {/* Add loading text */}
    </div>
  );
}

export default Loader;
