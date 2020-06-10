<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/27
  Time: 0:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="top ">
    <a href="${contextPath}">
        <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-home redColor"></span>
        小边书城首页
    </a>

    <span>欢迎来到小边书城</span>

    <c:if test="${!empty user}">
        <a href="login.jsp">${user.name}</a>
        <a href="forelogout">退出</a>
    </c:if>

    <c:if test="${empty user}">
        <a href="login.jsp">请登录</a>
        <a href="register.jsp">免费注册</a>
    </c:if>

    <span class="pull-right">

                <a href="forebought">我的订单</a>
                <a href="forecart">
                <span style="color:#C40000;margin:0px"class=" glyphicon glyphicon-shopping-cart redColor" ></span>
                购物车<strong>${cartTotalItemNumber}</strong>件</a>
    </span>

</nav>