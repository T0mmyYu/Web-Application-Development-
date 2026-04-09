<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Edit Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="../header.jsp" %>

    <div class="container" style="max-width: 700px; margin: 40px auto;">
        <div class="card">
            <div class="card-header bg-warning">
                <h3><i class="bi bi-pencil-square"></i> Edit Poll</h3>
            </div>
            <div class="card-body">
                <form action="<c:url value='/poll/edit'/>" method="post">
                    <input type="hidden" name="id" value="${poll.id}">

                    <div class="mb-3">
                        <label for="question" class="form-label">Poll Question *</label>
                        <input type="text" class="form-control" id="question" name="question"
                               value="${poll.question}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 1</label>
                        <input type="text" class="form-control" name="option1" value="${poll.option1}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 2</label>
                        <input type="text" class="form-control" name="option2" value="${poll.option2}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 3</label>
                        <input type="text" class="form-control" name="option3" value="${poll.option3}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 4</label>
                        <input type="text" class="form-control" name="option4" value="${poll.option4}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Option 5</label>
                        <input type="text" class="form-control" name="option5" value="${poll.option5}" required>
                    </div>

                    <div class="mb-3">
                        <label for="courseId" class="form-label">Course</label>
                        <select class="form-control" id="courseId" name="courseId">
                            <option value="">No Course (General Poll)</option>
                            <c:forEach items="${courses}" var="course">
                                <option value="${course.id}" ${poll.course.id == course.id ? 'selected' : ''}>
                                    ${course.courseName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="alert alert-warning">
                        <i class="bi bi-exclamation-triangle"></i>
                        Note: Vote counts cannot be edited. Only question and options can be changed.
                    </div>

                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-save"></i> Update Poll
                    </button>
                    <a href="<c:url value='/poll/view?id=${poll.id}'/>" class="btn btn-info">
                        <i class="bi bi-eye"></i> View Poll
                    </a>
                    <a href="<c:url value='/home'/>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Back
                    </a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>