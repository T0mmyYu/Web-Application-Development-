<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>${lecture.title} - ${course.courseName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .material-card {
            transition: transform 0.2s;
            cursor: pointer;
        }
        .material-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .lecture-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }
        .content-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<c:url value='/'/>">Home</a></li>
                <li class="breadcrumb-item"><a href="<c:url value='/course/details?id=${course.id}'/>">${course.courseName}</a></li>
                <li class="breadcrumb-item active">${lecture.title}</li>
            </ol>
        </nav>

        <!-- Lecture Header -->
        <div class="lecture-header">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <h1 class="display-5 fw-bold">${lecture.title}</h1>
                    <p class="lead mt-2">${course.courseCode} - ${course.courseName}</p>
                </div>
                <sec:authorize access="hasRole('LECTURER')">
                    <a href="<c:url value='/lecture/edit?id=${lecture.id}'/>" class="btn btn-light">
                        <i class="bi bi-pencil-square"></i> Edit Lecture
                    </a>
                </sec:authorize>
            </div>
        </div>

        <!-- Summary Section -->
        <div class="content-section">
            <h3><i class="bi bi-info-circle-fill me-2"></i>Summary</h3>
            <p class="lead">${lecture.summary}</p>
        </div>

        <!-- Materials Section -->
        <div class="row mb-4">
            <div class="col-12">
                <h3><i class="bi bi-files me-2"></i>Materials</h3>
                <hr>
            </div>
        </div>

        <div class="row">
            <!-- Notes Card -->
            <div class="col-md-6 mb-4">
                <div class="card material-card h-100" onclick="window.open('${lecture.notesUrl}', '_blank')">
                    <div class="card-body text-center">
                        <i class="bi bi-file-text-fill" style="font-size: 3rem; color: #0d6efd;"></i>
                        <h4 class="card-title mt-3">Lecture Notes</h4>
                        <p class="card-text text-muted">
                            <c:choose>
                                <c:when test="${not empty lecture.notesUrl}">
                                    Click to view/download notes
                                </c:when>
                                <c:otherwise>
                                    No notes available yet
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${not empty lecture.notesUrl}">
                            <span class="badge bg-primary">Available</span>
                        </c:if>
                        <c:if test="${empty lecture.notesUrl}">
                            <span class="badge bg-secondary">Coming Soon</span>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Video Card (Optional - can be added later) -->
            <div class="col-md-6 mb-4">
                <div class="card material-card h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-camera-reels-fill" style="font-size: 3rem; color: #dc3545;"></i>
                        <h4 class="card-title mt-3">Video Recording</h4>
                        <p class="card-text text-muted">Video content will be added soon</p>
                        <span class="badge bg-secondary">Coming Soon</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Resources -->
        <div class="content-section mt-3">
            <h3><i class="bi bi-link-45deg me-2"></i>Additional Resources</h3>
            <p class="text-muted">Check back for supplementary materials, code samples, and exercises.</p>
            <div class="alert alert-info mt-3">
                <i class="bi bi-info-circle"></i>
                <strong>Note:</strong> All materials are for educational purposes only.
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="d-flex justify-content-between mt-4 mb-5">
            <a href="<c:url value='/course/details?id=${course.id}'/>" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> Back to Course
            </a>
            <c:if test="${not empty nextLecture}">
                <a href="<c:url value='/lecture/view?id=${nextLecture.id}'/>" class="btn btn-primary">
                    Next Lecture <i class="bi bi-arrow-right"></i>
                </a>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>