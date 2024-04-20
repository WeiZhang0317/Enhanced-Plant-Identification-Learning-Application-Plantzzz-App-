import React, { createContext, useContext, useState } from 'react';

const QuizContext = createContext();

export const useQuiz = () => useContext(QuizContext);

export const QuizProvider = ({ children }) => {
  const [responses, setResponses] = useState([]);

  const saveResponse = (response) => {
        setResponses(prev => {
            const updatedResponses = [...prev, response];
            console.log('Saving response:', response);
            console.log('Updated responses:', updatedResponses);
            return updatedResponses;
        });
    };
  return (
    <QuizContext.Provider value={{ responses, saveResponse }}>
      {children}
    </QuizContext.Provider>
  );
};