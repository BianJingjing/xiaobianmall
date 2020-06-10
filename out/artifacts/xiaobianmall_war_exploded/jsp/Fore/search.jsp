<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/27
  Time: 11:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<form action="foresearch" method="post" >
    <div class="searchDiv">
        <input name="keyword" type="text" value="${param.keyword}" placeholder="三体 ">
        <button  type="submit" class="searchButton">搜索</button>
        <div class="searchBelow">
            <c:forEach items="${cs}" var="c" varStatus="st">
                <c:if test="${st.count>=5 and st.count<=7}">
						<span>
							<a href="forecategory?cid=${c.id}">
                                    ${c.name}
                            </a>
							<c:if test="${st.count!=7}">
                                <span>|</span>
                            </c:if>
						</span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</form>
