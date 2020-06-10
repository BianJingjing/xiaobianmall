<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%--未改--%>
<div class="payedDiv">
    <div class="payedTextDiv">
        <img src="img/paySuccess.png">
        <span>您已成功付款</span>

    </div>
    <div class="payedAddressInfo">
        <ul>
            <li>收货地址：${o.address} ${o.receiver} ${o.mobile }</li>
            <li>实付款：<span class="payedInfoPrice">
            ￥<fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/>
            </li>
            <li>预计XX月XX日送达    </li>
        </ul>

        <div class="paedCheckLinkDiv">
            您可以
            <a class="payedCheckLink" href="forebought">查看已买到的宝贝</a>
            <a class="payedCheckLink" href="forebought">查看交易详情 </a>
        </div>

    </div>

    <div class="payedSeperateLine">
    </div>



</div>
