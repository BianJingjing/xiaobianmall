<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 19:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="confirmPayPageDiv">
    <div class="confirmPayImageDiv">
        <img src="../img/confirmPayFlow.png">
        <div class="confirmPayTime1">
            <fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </div>
        <div class="confirmPayTime2">
            <fmt:formatDate value="${o.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </div>
        <div class="confirmPayTime3">
            yyyy-MM-dd HH:mm:ss
        </div>
    </div>
    <div class="confirmPayOrderInfoDiv">
        <div class="confirmPayOrderInfoText">我已收到货</div>
    </div>
    <div class="confirmPayOrderItemDiv">
        <div class="confirmPayOrderItemText">订单信息</div>
        <table class="confirmPayOrderItemTable">
            <thead>
            <tr><th colspan="2">宝贝</th>
                <th width="120px">单价</th>
                <th width="120px">数量</th>
                <th width="120px">商品总价 </th>
                <th width="120px">运费</th>
            </tr>
            </thead>
            <c:forEach items="${o.orderItems}" var="oi">
                <tr>
                    <td><img width="50px" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
                    <td class="confirmPayOrderItemProductLink">
                        <a href="#nowhere">${oi.product.name}</a>
                    </td>
                    <td>￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/></td>
                    <td>1</td>
                    <td><span class="conformPayProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/></span></td>
                    <td><span>快递 ： 0.00 </span></td>
                </tr>
            </c:forEach>
            </table>
        <div class="confirmPayOrderItemText pull-right">
            实付款： <span class="confirmPayOrderItemSumPrice">￥<fmt:formatNumber type="number" value="${o.total}" minFractionDigits="2"/></span>
        </div>
    </div>
    <div class="confirmPayOrderDetailDiv">
        <table class="confirmPayOrderDetailTable">
            <tbody><tr>
                <td>订单编号：</td>
                <td>${o.orderCode} </td>
            </tr>
            <tr>
                <td>收货信息： </td>
                <td>${o.address}，${o.receiver}， ${o.mobile}，${o.post} </td>
            </tr>
            <tr>
                <td>成交时间：</td>
                <td><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
            </tbody></table>
    </div>
    <div class="confirmPayButtonDiv">
        <div class="confirmPayWarning">请收到货后，再确认收货！</div>
        <a href="foreorderConfirmed?oid=${o.id}"><button class="confirmPayButton">确认支付</button></a>
    </div>
</div>

