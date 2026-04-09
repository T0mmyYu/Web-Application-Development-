<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    .poll-card {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        padding: 15px;
        margin-bottom: 15px;
        transition: transform 0.2s;
        border-left: 4px solid #667eea;
    }
    .poll-card:hover {
        transform: translateX(5px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    }
    .poll-question {
        font-size: 1rem;
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
    }
    .poll-stats {
        font-size: 0.8rem;
        color: #666;
        margin-bottom: 10px;
    }
    .poll-vote-btn {
        background-color: #667eea;
        color: white;
        padding: 5px 12px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 0.8rem;
    }
    .poll-vote-btn:hover {
        background-color: #5a67d8;
        color: white;
    }
</style>

<div class="poll-card">
    <div class="poll-question">📊 ${poll.question}</div>
    <div class="poll-stats">
        <i class="bi bi-bar-chart"></i> Total votes: ${poll.count1 + poll.count2 + poll.count3 + poll.count4 + poll.count5}
    </div>
    <div>
        <sec:authorize access="isAuthenticated()">
            <a href="<c:url value='/poll/view?id=${poll.id}'/>" class="poll-vote-btn">
                <i class="bi bi-check-circle"></i> View & Vote
            </a>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <a href="<c:url value='/login'/>" class="poll-vote-btn">
                <i class="bi bi-box-arrow-in-right"></i> Login to Vote
            </a>
        </sec:authorize>
    </div>
</div>