<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/27
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div >
<%--    <a href="${contextPath}">--%>
<%--        <img id="simpleLogo" class="simpleLogo" src="img/site/simpleLogo.png">--%>
<%--    </a>--%>

    <form action="foresearch" method="post" >
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="三体" name="keyword">
            <button class="searchButton" type="submit">搜索</button>
            <div class="searchBelow">
                <c:forEach items="${cs}" var="c" varStatus="st">
                    <c:if test="${st.count>=1 and st.count<=3}">
                    <span>
                        <a href="forecategory?cid=${c.id}">
                                ${c.name}
                        </a>
                        <c:if test="${st.count!=3}">
                            <span>|</span>
                        </c:if>
                    </span>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>
