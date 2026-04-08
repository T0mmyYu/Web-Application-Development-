<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>${course.courseName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        .lecture-card {
            transition: transform 0.2s;
            text-decoration: none;
            color: inherit;
        }
        .lecture-card:hover {
            transform: translateY(-5px);
            color: inherit;
        }
        .add-dashed-card {
            border: 2px dashed #adb5bd;
            border-radius: var(--bs-card-inner-border-radius);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 120px;
            color: #6c757d;
            text-decoration: none;
            transition: all 0.3s;
        }
        .add-dashed-card:hover {
            border-color: #0d6efd;
            color: #0d6efd;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/'/>">All Courses</a></li>
                <li class="breadcrumb-item active">${course.courseCode}</li>
            </ol>
        </nav>

        <div class="row mb-4">
            <div class="col-12">
                <h1 class="display-5 fw-bold">${course.courseName}</h1>
                <p class="lead text-muted">${course.description}</p>
            </div>
        </div>

        <hr>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2><i class="bi bi-journal-bookmark-fill me-2"></i>Lectures</h2>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
            <c:forEach var="lecture" items="${course.lectures}">
                <div class="col">
                    <a href="<c:url value='/lecture/view?id=${lecture.id}'/>" class="card h-100 shadow-sm lecture-card">
                        <div class="card-body">
                            <h5 class="card-title text-primary">${lecture.title}</h5>
                            <p class="card-text text-truncate">${lecture.summary}</p>
                        </div>
                        <div class="card-footer bg-transparent border-top-0 text-end">
                            <small class="text-muted">View Materials <i class="bi bi-arrow-right"></i></small>
                        </div>
                    </a>
                </div>
            </c:forEach>

            <sec:authorize access="hasRole('LECTURER')">
                <div class="col">
                    <a href="<c:url value='/course/${course.id}/lecture/create'/>" class="add-dashed-card h-100">
                        <div class="text-center">
                            <i class="bi bi-plus-lg fs-2"></i>
                            <div class="fw-bold">Create New Lecture</div>
                        </div>
                    </a>
                </div>
            </sec:authorize>
        </div>

        <h2 class="mb-3"><i class="bi bi-bar-chart-fill me-2"></i>Active Polls</h2>
        <div class="list-group mb-5 shadow-sm">
            <c:forEach var="poll" items="${course.polls}">
                <a href="<c:url value='/poll/view?id=${poll.id}'/>" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-question-circle me-2"></i>${poll.question}</span>
                    <span class="badge bg-primary rounded-pill">Vote Now</span>
                </a>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>