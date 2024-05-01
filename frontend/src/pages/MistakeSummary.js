import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import '../styles/MistakeSummary.css'; 

const MistakeSummary = () => {
  const { progressId } = useParams();
  const [incorrectAnswers, setIncorrectAnswers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchIncorrectAnswers = async () => {
      try {
        const response = await fetch(`http://localhost:5000/user/incorrect-answers/${progressId}`);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const data = await response.json();
        setIncorrectAnswers(data);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching incorrect answers:', error);
        setLoading(false);
      }
    };

    fetchIncorrectAnswers();
  }, [progressId]);

  if (loading) {
    return <div>Loading...</div>;
  }

  // Check if the incorrect answers array is empty
  if (incorrectAnswers.length === 0) {
    return (
      <div className="mistake-summary">
        <h2>Review Incorrect Answers</h2>
        <p>Well done! There are no incorrect answers for this exercise.</p>
      </div>
    );
  }

  return (
    <div className="mistake-summary">
      <h2>Review Incorrect Answers</h2>
      <table>
        <thead>
          <tr>
            <th>Question</th>
            <th>Your Answer</th>
            <th>Correct Answer</th>
            <th>Latin Name</th>
            <th>Common Name</th>
          </tr>
        </thead>
        <tbody>
          {incorrectAnswers.map((answer, index) => (
            <tr key={index}>
              <td>{answer.questionText}</td>
              <td>{answer.selectedOption}</td>
              <td>{answer.correctAnswer}</td>
              <td className="latin-name">{answer.latinName}</td>
              <td className="common-name">{answer.commonName}</td>

            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MistakeSummary;
