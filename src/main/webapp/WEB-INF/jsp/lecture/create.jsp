<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create New Lecture - ${course.courseName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Add New Lecture to: ${course.courseName}</h4>
                </div>
                <div class="card-body">

                    <form action="<c:url value='/lecture/create'/>" method="post">

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <input type="hidden" name="courseId" value="${course.id}">

                        <div class="mb-3">
                            <label class="form-label fw-bold">Lecture Title</label>
                            <input type="text" name="title" class="form-control"
                                   placeholder="e.g. Week 1: Getting Started" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Summary / Description</label>
                            <textarea name="summary" class="form-control" rows="5"
                                      placeholder="What will be covered in this session?"></textarea>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="javascript:history.back()" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary px-4">Save Lecture</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>