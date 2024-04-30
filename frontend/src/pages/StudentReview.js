import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/StudentReview.css'; // 确保有相应的CSS文件和样式

const StudentReview = () => {
    const [progressList, setProgressList] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        const fetchProgress = async () => {
            try {
                const response = await fetch('http://localhost:5000/user/progress-list'); // 确保后端提供这个API
                const data = await response.json();
                console.log(data); 
                setProgressList(data);
            } catch (error) {
                console.error('Failed to fetch progress:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchProgress();
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    if (progressList.length === 0) {
        return <div>No quiz progress found.</div>;
    }

    return (
        <div className="student-review">
            <h1>Quiz Progress Overview</h1>
            <ul className="progress-list">
                {progressList.map((progress) => (
                    <li key={progress.progressId} className="progress-item">
                        <h2>{progress.quizName}</h2>
                        <p>Started on: {new Date(progress.startTimestamp).toLocaleString()}</p>
                        <button onClick={() => navigate(`/quiz-review/${progress.progressId}`)}>
                            Review Quiz
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default StudentReview;
