import React from 'react';
import { FaRegCheckCircle } from 'react-icons/fa';

const CompletedQuizzes = ({ quizzes }) => {
  return (
    <div>
      <h2>Completed Quizzes</h2>
      {quizzes.completed.map((quiz) => (
        <div key={quiz.id}>
          <span>{quiz.title}</span>
          <FaRegCheckCircle title="Quiz Completed"/>
        </div>
      ))}
    </div>
  );
};

export default CompletedQuizzes;
