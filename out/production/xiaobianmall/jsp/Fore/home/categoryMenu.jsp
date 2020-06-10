<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/27
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<div class="categoryMenu">
    <c:forEach items="${cs}" var="c">
        <div cid="${c.id}" class="eachCategory" style="padding-top:20px;vertical-align: center;height: 73px;vertical-align: center">
            <span class="glyphicon glyphicon-link"></span>
            <a href="forecategory?cid=${c.id}" style="font-size: 17px">
                    ${c.name}
            </a>
        </div>
    </c:forEach>
</div>
