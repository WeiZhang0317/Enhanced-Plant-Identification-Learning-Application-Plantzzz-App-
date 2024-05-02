import React, { useState, useEffect } from 'react';
import goldMedal from "../images/medal1.png";
import silverMedal from "../images/medal2.png";
import bronzeMedal from "../images/medal3.png";
import '../styles/ScoreRanking.css';

const ScoreRanking = () => {
    const [rankings, setRankings] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchRankings = async () => {
            try {
                const response = await fetch('http://localhost:5000/user/score-rankings');
                const data = await response.json();
                setRankings(data.map(item => ({
                    username: item.Username,
                    score: item.Score,
                    timeTaken: item.TimeTaken
                })));
                setLoading(false);
            } catch (error) {
                console.error('Failed to fetch rankings:', error);
                setLoading(false);
            }
        };

        fetchRankings();
    }, []);

    if (loading) {
        return <div className="loading">Loading rankings...</div>;
    }

    if (!rankings.length) {
        return <div className="no-rankings">No rankings found.</div>;
    }

    return (
        <div className="score-ranking-container">
            <h1>Student Score Rankings</h1>
            <p>This ranking is based on the total score and time taken to complete the quizzes.</p>
            <table className="score-ranking-table">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Score</th>
                        <th>Time Taken (seconds)</th>
                        <th>Medal</th>
                    </tr>
                </thead>
                <tbody>
                    {rankings.map((ranking, index) => (
                        <tr key={index} className={`table-row ${index < 3 ? 'top-three' : ''}`}>
                            <td>{ranking.username}</td>
                            <td>{ranking.score !== undefined ? ranking.score.toString() : 'N/A'}</td>
                            <td>{ranking.timeTaken}</td>
                            <td>
                                {index === 0 && <img src={goldMedal} alt="Gold Medal" className="medal-img" />}
                                {index === 1 && <img src={silverMedal} alt="Silver Medal" className="medal-img" />}
                                {index === 2 && <img src={bronzeMedal} alt="Bronze Medal" className="medal-img" />}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default ScoreRanking;
