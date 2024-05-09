import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';

const EditQuiz = () => {
    const [quizDetails, setQuizDetails] = useState([]);
    const [loading, setLoading] = useState(true);
    const { quizId } = useParams(); // Destructure quizId from useParams
    const navigate = useNavigate();

    useEffect(() => {
        const fetchQuizDetails = async () => {
            setLoading(true);
            console.log(`Attempting to fetch quiz details for quiz ID: ${quizId}`);
            try {
                const response = await fetch(`http://localhost:5000/user/edit-quiz/${quizId}`);
                console.log(`Response status: ${response.status}`);
                if (!response.ok) {
                    throw new Error(`HTTP status ${response.status}`);
                }
                const data = await response.json();
                console.log('Quiz details received:', data);
                setQuizDetails(data);
            } catch (error) {
                console.error('Failed to fetch quiz details:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchQuizDetails();
    }, [quizId]);
    
    const handleSave = async () => {
        console.log('Preparing to save updated quiz data:', quizDetails);
        const updatedData = quizDetails.map(question => ({
            questionId: question.QuestionID,
            questionText: question.QuestionText,
            correctAnswer: question.CorrectAnswer,
            options: question.options,
        }));

        try {
            const response = await fetch(`http://localhost:5000/user/edit-quiz/${quizId}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({questions: updatedData})
            });
            console.log(`Save operation status: ${response.status}`);
            if (!response.ok) {
                throw new Error(`HTTP status ${response.status}`);
            }
            const result = await response.json();
            console.log('Save result:', result);
            alert(result.message);
            navigate('/path-to-go-after-saving'); // Redirect after saving
        } catch (error) {
            console.error('Failed to save updates:', error);
            alert('Failed to save updates');
        }
    };

    if (loading) return <div>Loading...</div>;
    if (!quizDetails.length) return <div>No quiz found!</div>;

    return (
        <div>
            <h1>Edit Quiz</h1>
            {quizDetails.map((question, index) => (
                <div key={question.QuestionID}>
                    <h2>Question: {question.QuestionText}</h2>
                    <input
                        type="text"
                        value={question.QuestionText}
                        onChange={e => {
                            console.log(`Updating text for question ${question.QuestionID}`);
                            const updatedQuestions = [...quizDetails];
                            updatedQuestions[index].QuestionText = e.target.value;
                            setQuizDetails(updatedQuestions);
                        }}
                    />
                    {question.options.map((option, optIndex) => (
                        <div key={option.OptionID}>
                            <input
                                type="text"
                                value={option.OptionText}
                                onChange={e => {
                                    console.log(`Updating text for option ${option.OptionID} of question ${question.QuestionID}`);
                                    const updatedOptions = [...question.options];
                                    updatedOptions[optIndex].OptionText = e.target.value;
                                    const updatedQuestions = [...quizDetails];
                                    updatedQuestions[index].options = updatedOptions;
                                    setQuizDetails(updatedQuestions);
                                }}
                            />
                            <label>
                                Correct:
                                <input
                                    type="checkbox"
                                    checked={option.IsCorrect}
                                    onChange={e => {
                                        console.log(`Changing correct status for option ${option.OptionID} of question ${question.QuestionID}`);
                                        const updatedOptions = [...question.options];
                                        updatedOptions[optIndex].IsCorrect = e.target.checked;
                                        const updatedQuestions = [...quizDetails];
                                        updatedQuestions[index].options = updatedOptions;
                                        setQuizDetails(updatedQuestions);
                                    }}
                                />
                            </label>
                        </div>
                    ))}
                </div>
            ))}
            <button onClick={handleSave}>Save Quiz</button>
        </div>
    );
};

export default EditQuiz;
