import React, { useState, useEffect } from 'react';

const ScoreRanking = () => {
    const [rankings, setRankings] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchRankings = async () => {
            try {
                const response = await fetch('http://localhost:5000/user/score-rankings');
                const data = await response.json();
                setRankings(data.map(item => ({
                    username: item.Username, // Assuming the backend returns 'Username'
                    score: item.Score,       // Assuming 'Score' is returned as a number or string that needs no conversion
                    timeTaken: item.TimeTaken // Assuming 'TimeTaken' is returned correctly
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
        return <div>Loading rankings...</div>;
    }

    if (!rankings.length) {
        return <div>No rankings found.</div>;
    }

    return (
        <div>
            <h1>Student Score Rankings</h1>
            <p>This ranking is based on the total score and time taken to complete the quizzes.</p>
            <table>
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Score</th>
                        <th>Time Taken (seconds)</th>
                    </tr>
                </thead>
                <tbody>
                    {rankings.map((ranking, index) => (
                        <tr key={index}>
                            <td>{ranking.username}</td>
                            <td>{ranking.score !== undefined ? ranking.score.toString() : 'N/A'}</td>
                            <td>{ranking.timeTaken}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default ScoreRanking;
