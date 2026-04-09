<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Online Learning Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .course-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .polls-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        body {
            background-color: #f8f9fa;
            margin: 0;
        }
        .section-title {
            font-size: 1.8rem;
            margin: 30px 0 20px 20px;
            padding-left: 20px;
            border-left: 5px solid #667eea;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <!-- Courses Section -->
    <h2 class="section-title"><i class="bi bi-book"></i> My Courses</h2>
    <div class="course-container">
        <c:forEach var="course" items="${courses}">
            <%@ include file="courseCard.jsp" %>
        </c:forEach>
    </div>

    <c:if test="${empty courses}">
        <div style="text-align: center; margin-top: 50px; color: #888;">
            <p>No courses found in your account.</p>
            <p style="font-size: 0.8rem;">(Please check if the Database has data and the connection is correct.)</p>
        </div>
    </c:if>

    <!-- Polls Section -->
    <h2 class="section-title"><i class="bi bi-bar-chart"></i> Active Polls</h2>
    <div class="polls-container">
        <c:forEach var="poll" items="${polls}">
            <%@ include file="pollCard.jsp" %>
        </c:forEach>
    </div>

    <c:if test="${empty polls}">
        <div style="text-align: center; margin-top: 20px; margin-bottom: 30px; color: #888;">
            <p>No polls availa  ble at the moment.</p>
        </div>
    </c:if>

    <!-- Teacher Create Poll Button -->
    <sec:authorize access="hasRole('LECTURER')">
        <div class="text-center mt-3 mb-5">
            <a href="<c:url value='/poll/create'/>" class="btn btn-success btn-lg">
                <i class="bi bi-plus-circle"></i> Create New Poll
            </a>
        </div>
    </sec:authorize>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>