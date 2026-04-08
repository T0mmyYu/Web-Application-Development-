<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style>
    .main-header {
        background-color: #ffffff;
        padding: 0 20px;
        height: 60px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .header-logo {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none !important;
        color: #333333 !important;

        font-weight: 600;
        font-size: 1.4rem;
        font-family: 'Segoe UI', sans-serif;
    }

    .logo-img {
        height: 35px;
        width: auto;
        display: block;
    }

    .header-logo:hover, .header-logo:visited {
        color: #333333 !important;
        text-decoration: none !important;
    }

    .nav-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        align-items: center;
    }

    .nav-item {
        margin-left: 20px;
    }

    .nav-link {
        color: #000000;
        text-decoration: none;
        font-size: 0.95rem;
        transition: color 0.3s;
    }

    .nav-link:hover {
        color: white;
        text-underline-offset: 5px;
        text-decoration: underline;
    }

    .logout-btn {
        background-color: #d9534f;
        color: white;
        padding: 6px 12px;
        border-radius: 4px;
        text-decoration: none;
        font-size: 0.85rem;
    }

    .logout-btn:hover {
        background-color: #c9302c;
    }
    .logout-form {
            margin: 0;
            display: inline;
        }
        .logout-btn-submit {
            background-color: #d9534f;
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.85rem;
            font-family: inherit;
        }
        .logout-btn-submit:hover {
            background-color: #c9302c;
        }
        .header-logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            gap: 10px;
            color: inherit;
        }

        .logo-img {
            height: 40px;
            width: auto;
            object-fit: contain;
        }

    </style>

<header class="main-header">
    <a href="${pageContext.request.contextPath}/home" class="header-logo">
        <img src="<c:url value='/images/logo.png'/>" alt="Logo" class="logo-img">
        Online Learning Platform
    </a>

    <nav>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/home" class="nav-link">Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/courses" class="nav-link">My Courses</a>
            </li>

            <li class="nav-item">
                <span style="color: #666; font-size: 0.9rem; margin-right: 10px;">
                    Hello, <strong style="color: #333;"><sec:authentication property="principal.username" /></strong>

                    <sec:authorize access="hasRole('TEACHER')">
                        <span style="background: #e3f2fd; color: #1976d2; padding: 2px 8px; border-radius: 10px; font-size: 0.8rem;">Teacher</span>
                    </sec:authorize>
                    <sec:authorize access="hasRole('STUDENT')">
                        <span style="background: #f1f8e9; color: #388e3c; padding: 2px 8px; border-radius: 10px; font-size: 0.8rem;">Student</span>
                    </sec:authorize>
                </span>
            </li>

            <li class="nav-item">
                <form action="${pageContext.request.contextPath}/logout" method="post" class="logout-form">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="logout-btn-submit">Logout</button>
                </form>
            </li>
        </ul>
    </nav>
</header>