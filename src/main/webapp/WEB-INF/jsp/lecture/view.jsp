<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            background: linear-gradient(135deg, #fbfbfb 0%, #ffffff 100%);
            color: #000000;
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
        .file-info {
            background-color: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 10px 15px;
            margin-top: 10px;
            border-radius: 5px;
        }
        .file-name {
            font-family: monospace;
            background-color: #f5f5f5;
            padding: 8px 12px;
            border-radius: 5px;
            word-break: break-all;
        }
        .resource-item {
            transition: background-color 0.2s;
        }
        .resource-item:hover {
            background-color: #e9ecef;
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
                <c:choose>
                    <c:when test="${not empty lecture.notesUrl}">
                        <div class="card material-card h-100" onclick="openNotes()">
                            <div class="card-body text-center">
                                <i class="bi bi-file-text-fill" style="font-size: 3rem; color: #0d6efd;"></i>
                                <h4 class="card-title mt-3">Lecture Notes</h4>

                                <!-- 顯示檔案名 -->
                                <div class="file-info mt-2">
                                    <i class="bi bi-paperclip"></i>
                                    <strong>File Name:</strong><br>
                                    <span class="file-name">
                                        <c:choose>
                                            <c:when test="${lecture.notesUrl.startsWith('/uploads/')}">
                                                ${fn:substringAfter(lecture.notesUrl, '/uploads/lectures/')}
                                            </c:when>
                                            <c:otherwise>
                                                ${lecture.notesUrl}
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <p class="card-text text-muted mt-3">Click to view/download notes</p>
                                <span class="badge bg-primary">Available</span>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card material-card h-100" style="opacity: 0.7; cursor: not-allowed;">
                            <div class="card-body text-center">
                                <i class="bi bi-file-text-fill" style="font-size: 3rem; color: #6c757d;"></i>
                                <h4 class="card-title mt-3">Lecture Notes</h4>
                                <p class="card-text text-muted">No notes available yet</p>
                                <span class="badge bg-secondary">Coming Soon</span>
                                <sec:authorize access="hasRole('LECTURER')">
                                    <div class="mt-3">
                                        <a href="<c:url value='/lecture/edit?id=${lecture.id}'/>" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-plus-circle"></i> Add Notes
                                        </a>
                                    </div>
                                </sec:authorize>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Video Card (Optional - can be added later) -->
            <div class="col-md-6 mb-4">
                <div class="card material-card h-100" style="cursor: not-allowed; opacity: 0.7;">
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
            <h3><i class="bi bi-paperclip me-2"></i>Additional Resources</h3>

            <c:choose>
                <c:when test="${not empty lecture.additionalFiles}">
                    <div class="list-group">
                        <c:forEach items="${lecture.additionalFiles}" var="file">
                            <a href="${file}" target="_blank" class="list-group-item list-group-item-action resource-item">
                                <div class="d-flex align-items-center">
                                    <i class="bi bi-file-earmark-text-fill fs-3 me-3 text-primary"></i>
                                    <div>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${file.startsWith('/uploads/')}">
                                                    ${fn:substringAfter(file, '/uploads/lectures/additional/')}
                                                </c:when>
                                                <c:otherwise>
                                                    ${file}
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                        <br>
                                        <small class="text-muted">
                                            <i class="bi bi-download"></i> Click to download
                                        </small>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">No additional resources available yet.</p>
                </c:otherwise>
            </c:choose>

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

    <script>
        function openNotes() {
            var notesUrl = '${lecture.notesUrl}';
            if (notesUrl && notesUrl.trim() !== '') {
                window.open(notesUrl, '_blank');
            } else {
                alert('No lecture notes available yet.');
            }
        }
    </script>
    <!-- Comments Section -->
    <div class="content-section mt-3">
        <h3><i class="bi bi-chat-dots me-2"></i>Comments (${fn:length(comments)})</h3>

        <!-- Add Comment Form -->
        <sec:authorize access="isAuthenticated()">
            <form action="<c:url value='/comment/add'/>" method="post" class="mb-4">
                <input type="hidden" name="lectureId" value="${lecture.id}">
                <div class="mb-2">
                    <textarea class="form-control" name="content" rows="2"
                              placeholder="Write your comment..." required></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-sm">
                    <i class="bi bi-send"></i> Post Comment
                </button>
            </form>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <div class="alert alert-info">
                <a href="<c:url value='/login'/>">Login</a> to leave a comment.
            </div>
        </sec:authorize>

        <!-- Comments List -->
        <c:forEach items="${comments}" var="comment">
            <div class="card mb-2">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold">
                            <i class="bi bi-person-circle"></i> ${comment.username}
                        </span>
                        <span class="text-muted small">${comment.createTime}</span>
                    </div>
                    <p class="mt-2 mb-0">${comment.content}</p>
                    <sec:authorize access="hasRole('LECTURER') or (isAuthenticated() and principal.username == comment.username)">
                        <form action="<c:url value='/comment/delete'/>" method="post" class="mt-2">
                            <input type="hidden" name="commentId" value="${comment.id}">
                            <input type="hidden" name="lectureId" value="${lecture.id}">
                            <button type="submit" class="btn btn-danger btn-sm">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </sec:authorize>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty comments}">
            <p class="text-muted">No comments yet. Be the first to comment!</p>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>