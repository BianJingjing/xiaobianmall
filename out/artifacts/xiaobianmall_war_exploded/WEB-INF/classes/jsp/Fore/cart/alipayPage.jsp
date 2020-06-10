<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<div class="aliPayPageDiv">
<%--    <div class="aliPayPageLogo">--%>
<%--        <img class="pull-left" src="img/simpleLogo.png" style="height: 100px">--%>
<%--        <div style="clear:both"></div>--%>
<%--    </div>--%>
    <div style="height: 50px"></div>

    <div>
        <span class="confirmMoneyText">扫一扫付款（元）</span>
        <span class="confirmMoney">
        ￥<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/></span>

    </div>
    <div>
        <img class="aliPayImg" src="img/aliPay.jpg" style="height: 350px">
    </div>

    <div>
        <a href="forepayed?oid=${param.oid}&total=${param.total}">
            <button class="confirmPay">确认支付</button>
        </a>
    </div>

</div>
