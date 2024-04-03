import React from "react";
import Navigation from "../components/Navigation";

function StudentDashboard() {
  // 假设 state 包含了 quiz 信息，您可能会从后端 API 获取这些数据
  const quizzes = {
    ongoing: [
      { id: 1, title: "Chapter 1: Introduction to Programming" },
      // 其他进行中的 quiz
    ],
    completed: [
      { id: 2, title: "Chapter 2: Data Structures" },
      // 其他已完成的 quiz
    ],
  };

  return (
    <div style={{ backgroundColor: "#F0F2F5", minHeight: "100vh" }}>
      <Navigation />
      <div
        style={{
          padding: "20px",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
        }}
      >
        <h1 style={{ color: "#4CAF50" }}>Student Dashboard</h1>
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            padding: "40px",
            marginTop: "20px",
            boxShadow: "0 4px 8px rgba(0,0,0,0.1)",
            borderRadius: "8px",
            backgroundColor: "white",
            width: "100%",
            maxWidth: "900px",
          }}
        >
          <div
            style={{
              width: "100%",
              marginBottom: "30px",
            }}
          >
            <h2 style={{ borderBottom: "1px solid #ccc", paddingBottom: "10px" }}>
              Ongoing Quizzes
            </h2>
            {quizzes.ongoing.map((quiz) => (
              <div key={quiz.id} style={{ padding: "10px", borderBottom: "1px solid #eee" }}>
                {quiz.title}
              </div>
            ))}
          </div>

          <div
            style={{
              width: "100%",
            }}
          >
            <h2 style={{ borderBottom: "1px solid #ccc", paddingBottom: "10px" }}>
              Completed Quizzes
            </h2>
            {quizzes.completed.map((quiz) => (
              <div key={quiz.id} style={{ padding: "10px", borderBottom: "1px solid #eee" }}>
                {quiz.title}
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default StudentDashboard;
