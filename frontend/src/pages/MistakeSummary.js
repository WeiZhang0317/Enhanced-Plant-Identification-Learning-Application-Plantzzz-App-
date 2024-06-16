import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import "../styles/MistakeSummary.css";

const MistakeSummary = () => {
  const { progressId } = useParams();
  const [incorrectAnswers, setIncorrectAnswers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchIncorrectAnswers = async () => {
      try {
        const response = await fetch(
          `http://localhost:5000/user/incorrect-answers/${progressId}`
        );
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        const data = await response.json();
        setIncorrectAnswers(data);
        setLoading(false);
      } catch (error) {
        console.error("Error fetching incorrect answers:", error);
        setLoading(false);
      }
    };

    fetchIncorrectAnswers();
  }, [progressId]);

  const handleNameClick = (latinName, commonName) => {
    const query = latinName || commonName; // Prefer Latin name if available, otherwise use common name
    const url = `https://en.wikipedia.org/wiki/Special:Search?search=${encodeURIComponent(
      query
    )}`;
    window.open(url, "_blank"); // Opens the search in a new tab
  };

  if (loading) {
    return <div>Loading...</div>;
  }

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
      <p>Click on bold plant name to learn more about it on Wikipedia.</p>{" "}
      {/* Instructional text */}
      <table>
        <thead>
          <tr>
            <th>Question</th>

            <th>Latin Name</th>
            <th>Common Name</th>
          </tr>
        </thead>
        <tbody>
          {incorrectAnswers.map((answer, index) => (
            <tr key={index}>
              <td>{answer.questionText}</td>

              <td
                className="latin-name"
                onClick={() =>
                  handleNameClick(answer.latinName, answer.commonName)
                }
              >
                <span className="icon-leaf"></span>
                {answer.latinName}
              </td>
              <td
                className="common-name"
                onClick={() =>
                  handleNameClick(answer.latinName, answer.commonName)
                }
              >
                <span className="icon-leaf"></span>
                {answer.commonName}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MistakeSummary;
