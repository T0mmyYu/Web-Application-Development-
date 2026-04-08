<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:forEach var="poll" items="${course.polls}">
        <div class="poll-item">
            <a href="<c:url value='/poll/view?id=${poll.id}'/>">${poll.question}</a>
        </div>
    </c:forEach>
</head>
<body>

</body>
</html>
