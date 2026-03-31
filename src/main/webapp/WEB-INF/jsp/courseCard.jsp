<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .course-card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        padding: 20px;
        transition: transform 0.2s, box-shadow 0.2s;
        border: 1px solid #eee;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: 180px;
    }


    .course-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        border-color: #003d7c;
    }

    .course-title {
        color: #003d7c;
        font-size: 1.25rem;
        margin: 0 0 10px 0;
        font-weight: bold;
    }

    .course-info {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 15px;
    }

    .view-btn {
        align-self: flex-start;
        background-color: #00b050; /* HKMU 綠色風格 */
        color: white;
        padding: 8px 15px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 0.85rem;
        font-weight: bold;
    }

    .view-btn:hover {
        background-color: #008c40;
    }
</style>

<div class="course-card">
    <div>
        <h3 class="course-title">${course.name}</h3>
        <p class="course-info">
            <strong>ID:</strong> ${course.id}<br>
            <strong>Instructor:</strong> ${course.instructor != null ? course.instructor : 'TBA'}
        </p>
    </div>

    <a href="/course/details?id=${course.id}" class="view-btn">Enter Course</a>
</div>