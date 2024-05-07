import React, { useState } from 'react';

function EditQuiz() {
    // State to hold the quiz data
    const [quiz, setQuiz] = useState({
        title: '',
        questions: [
            {
                questionText: '',
                options: ['', '', '', ''],
                correctOptionIndex: 0
            }
        ]
    });

    // Handle changes to quiz title
    const handleTitleChange = (event) => {
        setQuiz({ ...quiz, title: event.target.value });
    };

    // Handle changes to question text
    const handleQuestionTextChange = (index, event) => {
        const newQuestions = [...quiz.questions];
        newQuestions[index].questionText = event.target.value;
        setQuiz({ ...quiz, questions: newQuestions });
    };

    // Handle changes to options
    const handleOptionChange = (questionIndex, optionIndex, event) => {
        const newQuestions = [...quiz.questions];
        newQuestions[questionIndex].options[optionIndex] = event.target.value;
        setQuiz({ ...quiz, questions: newQuestions });
    };

    // Submit the updated quiz
    const handleSubmit = (event) => {
        event.preventDefault();
        console.log('Submitting quiz:', quiz);
        // Here you would typically send the quiz data to the backend
    };

    return (
        <div>
            <h1>Edit Quiz</h1>
            <form onSubmit={handleSubmit}>
                <div>
                    <label>Quiz Title:</label>
                    <input
                        type="text"
                        value={quiz.title}
                        onChange={handleTitleChange}
                    />
                </div>
                {quiz.questions.map((question, index) => (
                    <div key={index}>
                        <label>Question {index + 1}:</label>
                        <input
                            type="text"
                            value={question.questionText}
                            onChange={(event) => handleQuestionTextChange(index, event)}
                        />
                        {question.options.map((option, optionIndex) => (
                            <div key={optionIndex}>
                                <label>Option {optionIndex + 1}:</label>
                                <input
                                    type="text"
                                    value={option}
                                    onChange={(event) => handleOptionChange(index, optionIndex, event)}
                                />
                            </div>
                        ))}
                    </div>
                ))}
                <button type="submit">Save Changes</button>
            </form>
        </div>
    );
}

export default EditQuiz;
