import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles/StudentReview.css';

const StudentReview = () => {
    const [progressList, setProgressList] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    // Define fetchProgress outside useEffect to use it in handleDelete as well
    const fetchProgress = async () => {
        try {
            const response = await fetch('http://localhost:5000/user/progress-list');
            const data = await response.json();
            console.log(data);
            setProgressList(data);
        } catch (error) {
            console.error('Failed to fetch progress:', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchProgress();
    }, []);

    const handleDelete = async (progressId) => {
        if (window.confirm('Are you sure you want to delete this record?')) {
            try {
                const response = await fetch(`http://localhost:5000/user/delete-progress/${progressId}`, { method: 'DELETE' });
                const data = await response.json();
                alert(data.message);
                fetchProgress();  // Reload the progress list to reflect the deletion
            } catch (error) {
                console.error('Failed to delete progress:', error);
            }
        }
    };

    if (loading) {
        return <div>Loading...</div>;
    }

    if (progressList.length === 0) {
        return <div>No quiz progress found.</div>;
    }

    return (
        <div className="student-review">
            <h2>Quiz Mistake Summary</h2>
            <ul className="progress-list">
                {progressList.map((progress) => (
                    <li key={progress.progressId} className="progress-item">
                        <h2>{progress.quizName}</h2>
                        <p>Started on: {new Date(progress.startTimestamp).toLocaleString()}</p>
                        <button onClick={() => navigate(`incorrect-answers/${progress.progressId}`)}>
                            Review Quiz Mistakes
                        </button>
                        <button className="button-delete" onClick={() => handleDelete(progress.progressId)}>
                            Delete This Record
                        </button>

                    </li>
                ))}
            </ul>
        </div>
    );
};

export default StudentReview;
