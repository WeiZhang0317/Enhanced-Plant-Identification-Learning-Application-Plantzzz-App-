import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Modal, message } from "antd";
import "../styles/StudentReview.css";
import { useUserContext } from "../contexts/UserContext";

const StudentReview = () => {
  const [progressList, setProgressList] = useState([]);
  const [loading, setLoading] = useState(true);
  const { user } = useUserContext(); // 获取当前登录用户信息
  const navigate = useNavigate();

  const fetchProgress = async () => {
    try {
      const studentId = user.studentId;
      console.log("Sending studentId:", studentId); // 打印 studentId 以进行调试
      const response = await fetch(
        `http://localhost:5000/user/progress-list?studentId=${studentId}`,
        {
          method: "GET",
        }
      );
      const data = await response.json();
      console.log("Response data:", data); // 打印响应数据以进行调试
      if (Array.isArray(data)) {
        setProgressList(data);
      } else {
        setProgressList([]);
      }
    } catch (error) {
      console.error("Failed to fetch progress:", error);
      message.error("Failed to fetch progress");
      setProgressList([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (user) {
      fetchProgress();
    }
  }, [user]);

  const handleDelete = async (progressId) => {
    Modal.confirm({
      title: "Are you sure you want to delete this record?",
      onOk: async () => {
        try {
          const response = await fetch(
            `http://localhost:5000/user/delete-progress/${progressId}`,
            {
              method: "DELETE",
            }
          );
          const data = await response.json();
          message.success(data.message);
          fetchProgress(); // Reload the progress list to reflect the deletion
        } catch (error) {
          console.error("Failed to delete progress:", error);
          message.error("Failed to delete progress");
        }
      },
      onCancel() {
        message.info("Deletion cancelled");
      },
    });
  };

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (progressList.length === 0) {
    return <div className="no-rankings">No quiz progress found.</div>;
  }

  return (
    <div className="student-review">
      <h2 className="student-review-title">Quiz Mistake Summary</h2>
      <ul className="progress-list">
        {progressList.map((progress) => (
          <li key={progress.progressId} className="progress-item">
            <h2>{progress.quizName}</h2>
            <p>
              Started on: {new Date(progress.startTimestamp).toLocaleString()}
            </p>
            <button
              onClick={() =>
                navigate(`incorrect-answers/${progress.progressId}`)
              }
            >
              Review Quiz Mistakes
            </button>
            <button
              className="button-delete"
              onClick={() => handleDelete(progress.progressId)}
            >
              Delete This Record
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default StudentReview;
