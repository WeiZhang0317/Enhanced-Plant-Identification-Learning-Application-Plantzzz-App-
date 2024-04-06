import React from 'react';
import { FaPlayCircle } from 'react-icons/fa';
import '../styles/OngoingQuizzes.css';

const OngoingQuizzes = ({ quizzes }) => {
  return (
    <div>
      <h2>Ongoing Quizzes</h2>
      {quizzes.ongoing.map((quiz) => (
        <div key={quiz.id}>
          <span>{quiz.title}</span>
          <FaPlayCircle title="Continue Quiz"/>
        </div>
      ))}
    </div>
  );
};

export default OngoingQuizzes;
