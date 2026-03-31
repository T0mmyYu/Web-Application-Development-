<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Header 主體排版 */
    .main-header {
        background-color: #ffffff;
        color: white;
        padding: 0 20px;
        height: 60px;
        display: flex;
        justify-content: space-between; /* 將 Logo 同 Nav 分開兩邊 */
        align-items: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Logo 部分 */
    .header-logo {
        font-weight: lighter;
        font-size: 1.5rem;
        text-decoration: none;
        color: #C0C0C0;
    }

    /* 導航連結 */
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
        color: #e0e0e0;
        text-decoration: none;
        font-size: 0.95rem;
        transition: color 0.3s;
    }

    .nav-link:hover {
        color: white;
        text-underline-offset: 5px;
        text-decoration: underline;
    }

    /* 用戶登出按鈕樣式 */
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
</style>

<header class="main-header">
    <a href="/home" class="header-logo">
        Online Learning Platform
    </a>

    <nav>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="/home" class="nav-link">Dashboard</a>
            </li>
            <li class="nav-item">
                <a href="/courses" class="nav-link">My Courses</a>
            </li>

            <li class="nav-item">
                <span style="color: #ffcc00; font-size: 0.9rem;">
                    Hello, ${sessionScope.username != null ? sessionScope.username : 'Guest'}
                </span>
            </li>

            <li class="nav-item">
                <a href="/logout" class="logout-btn">Logout</a>
            </li>
        </ul>
    </nav>
</header>