import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import '../styles/EditQuiz.css'; // Import the CSS file


const EditQuiz = () => {
    const [quizDetails, setQuizDetails] = useState([]);
    const [loading, setLoading] = useState(true);
    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const { quizId } = useParams();
    const navigate = useNavigate();


    useEffect(() => {
        const fetchQuizDetails = async () => {
            setLoading(true);
            try {
                const response = await fetch(`http://localhost:5000/user/edit-quiz/${quizId}`);
                if (!response.ok) {
                    throw new Error(`HTTP status ${response.status}`);
                }
                const data = await response.json();
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
        const updatedData = quizDetails.map(question => ({
            questionId: question.QuestionID,
            questionText: question.QuestionText,
            correctAnswer: question.options.find(option => option.IsCorrect)?.OptionText,
            questionType: question.QuestionType,
            options: question.options.map(option => ({
                optionId: option.OptionID,
                optionText: option.OptionText,
                isCorrect: option.IsCorrect,
            })),
        }));

        try {
            const response = await fetch(`http://localhost:5000/user/edit-quiz/${quizId}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    quizName: quizDetails[0].QuizName,
                    quizImageURL: quizDetails[0].QuizImageURL,
                    questions: updatedData,
                }),
            });
            if (!response.ok) {
                throw new Error(`HTTP status ${response.status}`);
            }
            const result = await response.json();
            alert(result.message);
            
        } catch (error) {
            console.error('Failed to save updates:', error);
            alert('Failed to save updates');
        }
    };

    const handleOptionChange = (questionIndex, optionIndex) => {
        const updatedOptions = quizDetails[questionIndex].options.map((option, idx) => ({
            ...option,
            IsCorrect: idx === optionIndex
        }));

        const updatedQuizDetails = quizDetails.map((question, idx) => {
            if (idx === questionIndex) {
                return { ...question, options: updatedOptions };
            }
            return question;
        });

        setQuizDetails(updatedQuizDetails);
    };

    const handleQuestionChange = (index) => {
        setCurrentQuestionIndex(index);
    };

    const timestamp = new Date().getTime();
    
    const handleFileUpload = async (event) => {
        const file = event.target.files[0];
        if (file) {
            const formData = new FormData();
            formData.append('image', file);
    
            try {
                const response = await fetch(`http://localhost:5000/user/upload-image/${quizDetails[currentQuestionIndex].QuestionID}`, {
                    method: 'POST',
                    body: formData,
                });
    
                if (!response.ok) {
                    throw new Error('Failed to upload image.');
                }
    
                const result = await response.json();
                // 创建一个新数组来确保React检测到状态变化
                const updatedQuizDetails = quizDetails.map((question, index) =>
                    index === currentQuestionIndex ? { ...question, ImageURL: result.imageUrl } : question
                );
    
                setQuizDetails(updatedQuizDetails);
    
                alert('Image uploaded successfully!');
            } catch (error) {
                console.error('Error uploading image:', error);
                alert('Failed to upload image.');
            }
        }
    };
    
    
    const moveToNext = () => {
        if (currentQuestionIndex < quizDetails.length - 1) {
            setCurrentQuestionIndex(currentQuestionIndex + 1);
        }
    };

    const moveToPrevious = () => {
        if (currentQuestionIndex > 0) {
            setCurrentQuestionIndex(currentQuestionIndex - 1);
        }
    };

    const moveToFirst = () => {
        setCurrentQuestionIndex(0);
    };

    const moveToLast = () => {
        setCurrentQuestionIndex(quizDetails.length - 1);
    };
     
    
    if (loading) return <div>Loading...</div>;
    if (!quizDetails.length) return <div>No quiz found!</div>;

    const currentQuestion = quizDetails[currentQuestionIndex];
    const baseUrl = 'http://localhost:5000/';   
        
    return (
        <div className="edit-quiz-container">
            <h1>Edit Quiz: {quizDetails[0].QuizName}</h1>
            <div className="question-pagination">
                <button onClick={moveToFirst} disabled={currentQuestionIndex === 0}>First</button>
                <button onClick={moveToPrevious} disabled={currentQuestionIndex === 0}>Previous</button>
                <span>Question {currentQuestionIndex + 1} of {quizDetails.length}</span>
                <button onClick={moveToNext} disabled={currentQuestionIndex === quizDetails.length - 1}>Next</button>
                <button onClick={moveToLast} disabled={currentQuestionIndex === quizDetails.length - 1}>Last</button>
            </div>
            <div className="question-details">
            <h2>Question {currentQuestionIndex + 1}: {currentQuestion.QuestionText}</h2>
            {currentQuestion.ImageURL && (
                <img
                    src={`${baseUrl}${currentQuestion.ImageURL}?${timestamp}`}  // 使用时间戳避免缓存问题
                    alt="Question Image"
                    className="question-image"
                />
                )}
                <input type="file" onChange={handleFileUpload} />
                <input
                    type="text"
                    value={currentQuestion.QuestionText}
                    onChange={e => {
                        const updatedQuestions = [...quizDetails];
                        updatedQuestions[currentQuestionIndex].QuestionText = e.target.value;
                        setQuizDetails(updatedQuestions);
                    }}
                    disabled={currentQuestion.QuestionType === 'true_false'}
                />
                {currentQuestion.options.map((option, optIndex) => (
                    <div key={option.OptionID} className="option-item">
                        <input
                            type="text"
                            value={option.OptionText}
                            onChange={e => {
                                const updatedOptions = [...currentQuestion.options];
                                updatedOptions[optIndex].OptionText = e.target.value;
                                const updatedQuestions = [...quizDetails];
                                updatedQuestions[currentQuestionIndex].options = updatedOptions;
                                setQuizDetails(updatedQuestions);
                            }}
                            disabled={currentQuestion.QuestionType === 'true_false'}
                        />
                        <label>
                            {option.OptionLabel ? `${option.OptionLabel}: ` : ''}
                            Correct:
                            <input
                                type="radio"
                                name={`correct-option-${currentQuestion.QuestionID}`}
                                checked={option.IsCorrect}
                                onChange={() => handleOptionChange(currentQuestionIndex, optIndex)}
                            />
                        </label>
                    </div>
                ))}
            </div>
            <button onClick={handleSave} className="save-button">Save Quiz</button>
        </div>
    );
};

export default EditQuiz;
