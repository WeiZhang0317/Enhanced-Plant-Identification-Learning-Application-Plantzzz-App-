import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Upload, Button, message, Input, Radio, Modal } from "antd";
import { UploadOutlined } from "@ant-design/icons";
import "../styles/EditQuiz.css"; // Import the CSS file

const EditQuiz = () => {
  const [quizDetails, setQuizDetails] = useState([]);
  const [loading, setLoading] = useState(true);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const { quizId } = useParams();
  const navigate = useNavigate();
  const [inputQuestionIndex, setInputQuestionIndex] = useState(currentQuestionIndex + 1);

  useEffect(() => {
    const fetchQuizDetails = async () => {
      setLoading(true);
      try {
        const response = await fetch(
          `http://localhost:5000/user/edit-quiz/${quizId}`
        );
        if (!response.ok) {
          throw new Error(`HTTP status ${response.status}`);
        }
        const data = await response.json();
        setQuizDetails(data);
      } catch (error) {
        message.error("Failed to fetch quiz details");
        console.error("Failed to fetch quiz details:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchQuizDetails();
  }, [quizId]);

  useEffect(() => {
    if (quizDetails.length > 0 && currentQuestionIndex < quizDetails.length) {
      const currentQuestion = quizDetails[currentQuestionIndex];
      console.log("Current Question:", currentQuestion);
      console.log("Base URL:", "http://localhost:5000/");
    }
  }, [quizDetails, currentQuestionIndex]);

  const handleSave = async () => {
    const updatedData = quizDetails.map((question) => ({
      questionId: question.QuestionID,
      questionText: question.QuestionText,
      correctAnswer: question.options.find((option) => option.IsCorrect)
        ?.OptionText,
      questionType: question.QuestionType,
      options: question.options.map((option) => ({
        optionId: option.OptionID,
        optionText: option.OptionText,
        isCorrect: option.IsCorrect,
      })),
    }));

    try {
      const response = await fetch(
        `http://localhost:5000/user/edit-quiz/${quizId}`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            quizName: quizDetails[0].QuizName,
            quizImageURL: quizDetails[0].QuizImageURL,
            questions: updatedData,
          }),
        }
      );
      if (!response.ok) {
        throw new Error(`HTTP status ${response.status}`);
      }
      const result = await response.json();
      message.success(result.message);
    } catch (error) {
      message.error("Failed to save updates");
      console.error("Failed to save updates:", error);
    }
  };

  const handleOptionChange = (questionIndex, optionIndex) => {
    const updatedOptions = quizDetails[questionIndex].options.map(
      (option, idx) => ({
        ...option,
        IsCorrect: idx === optionIndex,
      })
    );

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

  const handleFileUpload = async ({ file }) => {
    const formData = new FormData();
    formData.append("image", file);

    try {
      const response = await fetch(
        `http://localhost:5000/user/upload-image/${quizDetails[currentQuestionIndex].QuestionID}`,
        {
          method: "POST",
          body: formData,
        }
      );

      if (!response.ok) {
        throw new Error("Failed to upload image.");
      }

      const result = await response.json();

      const updatedQuizDetails = quizDetails.map((question, index) =>
        index === currentQuestionIndex
          ? { ...question, ImageURL: result.imageUrl }
          : question
      );

      setQuizDetails(updatedQuizDetails);

      message.success("Image uploaded successfully!");
    } catch (error) {
      message.error("Failed to upload image");
      console.error("Error uploading image:", error);
    }
  };

  const moveToNext = () => {
    if (currentQuestionIndex < quizDetails.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setInputQuestionIndex(currentQuestionIndex + 2); // Update the input field as well
    }
  };

  const guid = () => {
    function S4() {
      return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }
    return (
      S4() +
      S4() +
      "-" +
      S4() +
      "-" +
      S4() +
      "-" +
      S4() +
      "-" +
      S4() +
      S4() +
      S4()
    );
  };
  const moveToPrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(currentQuestionIndex - 1);
      setInputQuestionIndex(currentQuestionIndex); // Update the input field as well
    }
  };

  const moveToFirst = () => {
    setCurrentQuestionIndex(0);
    setInputQuestionIndex(1); // Update the input field as well
  };

  const moveToLast = () => {
    setCurrentQuestionIndex(quizDetails.length - 1);
    setInputQuestionIndex(quizDetails.length); // Update the input field as well
  };

  if (loading) return <div>Loading...</div>;
  if (!quizDetails.length) return <div>No quiz found!</div>;

  const currentQuestion = quizDetails[currentQuestionIndex];
  const baseUrl = "http://localhost:5000/";

  return (
    <div className="edit-quiz-container">
      <h1>Edit Quiz: {quizDetails[0].QuizName}</h1>

      <div className="navigation-buttons">
        <button onClick={moveToFirst} disabled={currentQuestionIndex === 0}>
          First
        </button>
        <button onClick={moveToPrevious} disabled={currentQuestionIndex === 0}>
          Previous
        </button>
        <span className="question-navigation">
          Question{" "}
          <input
            className="small-input"
            type="number"
            value={inputQuestionIndex}
            onChange={(e) => setInputQuestionIndex(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Enter') {
                const questionIndex = parseInt(inputQuestionIndex, 10) - 1;
                if (
                  !isNaN(questionIndex) &&
                  questionIndex >= 0 &&
                  questionIndex < quizDetails.length
                ) {
                  handleQuestionChange(questionIndex);
                } else {
                  message.error("Invalid question number");
                }
              }
            }}
          />{" "}
          of {quizDetails.length}
        </span>
        <button
          onClick={moveToNext}
          disabled={currentQuestionIndex === quizDetails.length - 1}
        >
          Next
        </button>
        <button
          onClick={moveToLast}
          disabled={currentQuestionIndex === quizDetails.length - 1}
        >
          Last
        </button>
      </div>

      <div className="question-details">
        <h2>
          Question {currentQuestionIndex + 1}: {currentQuestion.QuestionText}
        </h2>
        <Input
          value={currentQuestion.QuestionText}
          onChange={(e) => {
            const updatedQuestions = [...quizDetails];
            updatedQuestions[currentQuestionIndex].QuestionText =
              e.target.value;
            setQuizDetails(updatedQuestions);
          }}
        />
        <div className="image-upload-section">
          {currentQuestion.ImageURL && (
            <img
              src={`${baseUrl}${currentQuestion.ImageURL}?${timestamp}`}
              alt="Question Image"
              className="question-image"
            />
          )}
          <Upload
            customRequest={handleFileUpload}
            showUploadList={false}
            accept="image/*"
          >
            <Button icon={<UploadOutlined />} className="custom-upload-button">
              Click to Upload
            </Button>
          </Upload>
        </div>
        {currentQuestion.options.map((option, optIndex) => (
          <div key={guid()} className="option-item">
            <label className="option-item-label">
              {option.OptionLabel ? `${option.OptionLabel}: ` : ""}
            </label>
            <Radio
              checked={option.IsCorrect}
              onChange={() =>
                handleOptionChange(currentQuestionIndex, optIndex)
              }
            />
            <Input
              value={option.OptionText}
              onChange={(e) => {
                const updatedOptions = [...currentQuestion.options];
                updatedOptions[optIndex].OptionText = e.target.value;
                const updatedQuestions = [...quizDetails];
                updatedQuestions[currentQuestionIndex].options = updatedOptions;
                setQuizDetails(updatedQuestions);
              }}
              disabled={currentQuestion.QuestionType === "true_false"}
            />
          </div>
        ))}
      </div>

      <button onClick={handleSave} className="save-button">

      Save Quiz

      </button>
    </div>
  );
};

export default EditQuiz;
