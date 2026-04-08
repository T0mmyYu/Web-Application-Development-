<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <form action="<c:url value='/lecture/create'/>" method="post">
        <input type="hidden" name="courseId" value="${course.id}">

        <div class="mb-3">
            <label>Lecture Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Summary</label>
            <textarea name="summary" class="form-control"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Create Card</button>
    </form>
</head>
<body>

</body>
</html>
