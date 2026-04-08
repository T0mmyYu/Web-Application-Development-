<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Online Learning Platform</title>
    <style>
        .course-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        body {
            background-color: #f8f9fa;
            margin: 0;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

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
</body>
</html>