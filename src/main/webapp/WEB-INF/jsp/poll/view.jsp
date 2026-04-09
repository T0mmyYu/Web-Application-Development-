<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Poll - ${poll.question}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .poll-container {
            max-width: 800px;
            margin: 30px auto;
        }
        .poll-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 25px;
        }
        .option-item {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            transition: all 0.2s;
        }
        .option-item:hover {
            background-color: #e9ecef;
        }
        .option-text {
            font-size: 1.1rem;
            font-weight: 500;
        }
        .vote-count {
            font-size: 0.9rem;
            color: #666;
        }
        .progress {
            height: 25px;
            border-radius: 10px;
            margin-top: 8px;
        }
        .vote-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }
        .vote-btn:hover {
            background-color: #218838;
        }
        .already-voted {
            background-color: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .edit-btn {
            background-color: #ffc107;
            color: #333;
            padding: 5px 12px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.85rem;
        }
        .edit-btn:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <%@ include file="../header.jsp" %>

    <div class="container poll-container">
        <!-- Poll Header -->
        <div class="poll-header">
            <h1 class="display-6 fw-bold">${poll.question}</h1>
            <div class="mt-2">
                <span class="badge bg-light text-dark">
                    Total votes: ${poll.count1 + poll.count2 + poll.count3 + poll.count4 + poll.count5}
                </span>
            </div>

            <sec:authorize access="hasRole('TEACHER')">
                <div class="mt-3">
                    <a href="<c:url value='/poll/edit?id=${poll.id}'/>" class="edit-btn">
                        <i class="bi bi-pencil"></i> Edit Poll
                    </a>
                </div>
            </sec:authorize>
        </div>

        <!-- Already Voted Message -->
        <c:if test="${hasVoted}">
            <div class="already-voted">
                <i class="bi bi-check-circle-fill text-success"></i>
                You have already voted. You can change your vote by selecting a different option below.
            </div>
        </c:if>

        <!-- Poll Options -->
        <h3><i class="bi bi-bar-chart"></i> Vote Now</h3>

        <c:set var="totalVotes" value="${poll.count1 + poll.count2 + poll.count3 + poll.count4 + poll.count5}" />

        <form action="<c:url value='/poll/vote'/>" method="post">
            <input type="hidden" name="pollId" value="${poll.id}">

            <!-- Option 1 -->
            <div class="option-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="option-text">
                        <input type="radio" name="optionNumber" value="1" ${userVotedOption == 1 ? 'checked' : ''}>
                        <span class="ms-2">${poll.option1}</span>
                    </div>
                    <div class="vote-count">
                        ${poll.count1} votes (${totalVotes > 0 ? (poll.count1 / totalVotes * 100) : 0}%)
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-primary"
                         style="width: ${totalVotes > 0 ? (poll.count1 / totalVotes * 100) : 0}%">
                    </div>
                </div>
            </div>

            <!-- Option 2 -->
            <div class="option-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="option-text">
                        <input type="radio" name="optionNumber" value="2" ${userVotedOption == 2 ? 'checked' : ''}>
                        <span class="ms-2">${poll.option2}</span>
                    </div>
                    <div class="vote-count">
                        ${poll.count2} votes (${totalVotes > 0 ? (poll.count2 / totalVotes * 100) : 0}%)
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-primary"
                         style="width: ${totalVotes > 0 ? (poll.count2 / totalVotes * 100) : 0}%">
                    </div>
                </div>
            </div>

            <!-- Option 3 -->
            <div class="option-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="option-text">
                        <input type="radio" name="optionNumber" value="3" ${userVotedOption == 3 ? 'checked' : ''}>
                        <span class="ms-2">${poll.option3}</span>
                    </div>
                    <div class="vote-count">
                        ${poll.count3} votes (${totalVotes > 0 ? (poll.count3 / totalVotes * 100) : 0}%)
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-primary"
                         style="width: ${totalVotes > 0 ? (poll.count3 / totalVotes * 100) : 0}%">
                    </div>
                </div>
            </div>

            <!-- Option 4 -->
            <div class="option-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="option-text">
                        <input type="radio" name="optionNumber" value="4" ${userVotedOption == 4 ? 'checked' : ''}>
                        <span class="ms-2">${poll.option4}</span>
                    </div>
                    <div class="vote-count">
                        ${poll.count4} votes (${totalVotes > 0 ? (poll.count4 / totalVotes * 100) : 0}%)
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-primary"
                         style="width: ${totalVotes > 0 ? (poll.count4 / totalVotes * 100) : 0}%">
                    </div>
                </div>
            </div>

            <!-- Option 5 -->
            <div class="option-item">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="option-text">
                        <input type="radio" name="optionNumber" value="5" ${userVotedOption == 5 ? 'checked' : ''}>
                        <span class="ms-2">${poll.option5}</span>
                    </div>
                    <div class="vote-count">
                        ${poll.count5} votes (${totalVotes > 0 ? (poll.count5 / totalVotes * 100) : 0}%)
                    </div>
                </div>
                <div class="progress">
                    <div class="progress-bar bg-primary"
                         style="width: ${totalVotes > 0 ? (poll.count5 / totalVotes * 100) : 0}%">
                    </div>
                </div>
            </div>

            <button type="submit" class="vote-btn mt-3">
                <i class="bi bi-check-lg"></i> ${hasVoted ? 'Change Vote' : 'Submit Vote'}
            </button>
        </form>

        <!-- Back Button -->
        <div class="mt-4 text-center">
            <a href="<c:url value='/home'/>" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Back to Home
            </a>
        </div>
    </div>
    <!-- Comments Section -->
    <div class="mt-4">
        <h3><i class="bi bi-chat-dots me-2"></i>Comments (${fn:length(comments)})</h3>

        <!-- Add Comment Form -->
        <sec:authorize access="isAuthenticated()">
            <form action="<c:url value='/comment/add'/>" method="post" class="mb-4">
                <input type="hidden" name="pollId" value="${poll.id}">
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
                            <input type="hidden" name="pollId" value="${poll.id}">
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