<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Create New Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="../header.jsp" %>

    <div class="container" style="max-width: 700px; margin: 40px auto;">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h3><i class="bi bi-plus-circle"></i> Create New Poll</h3>
                <c:if test="${not empty course}">
                    <small>for Course: ${course.courseName}</small>
                </c:if>
            </div>
            <div class="card-body">
                <form action="<c:url value='/poll/create'/>" method="post">
                    <input type="hidden" name="courseId" value="${course.id}">

                    <div class="mb-3">
                        <label for="question" class="form-label">Poll Question *</label>
                        <input type="text" class="form-control" id="question" name="question"
                               placeholder="e.g., Which topic should be introduced in the next class?" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 1 *</label>
                        <input type="text" class="form-control" name="option1" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 2 *</label>
                        <input type="text" class="form-control" name="option2" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 3 *</label>
                        <input type="text" class="form-control" name="option3" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 4 *</label>
                        <input type="text" class="form-control" name="option4" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 5 *</label>
                        <input type="text" class="form-control" name="option5" required>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> Create Poll
                    </button>
                    <a href="<c:url value='/course/details?id=${course.id}'/>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Back to Course
                    </a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>