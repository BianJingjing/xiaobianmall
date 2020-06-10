<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<div class="buyPageDiv">
    <form action="forecreateOrder" method="post">
        <div class="buyflow">
            <img src="img/buyflow.png" style="align:center">
        </div>
        <div class="address">
            <div class="addressTip">输入收货地址</div>
            <div>
                <table class="addressTable">
                    <tbody>
                    <tr>
                        <td class="firstColumn">详细地址<span class="redStar">*</span></td>
                        <td><textarea placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息" name="address"></textarea></td>
                    </tr>
                    <tr>
                        <td>邮政编码</td>
                        <td><input type="text" placeholder="如果您不清楚邮递区号，请填写000000" name="post"></td>
                    </tr>
                    <tr>
                        <td>收货人姓名<span class="redStar">*</span></td>
                        <td><input type="text" placeholder="长度不超过25个字符" name="receiver"></td>
                    </tr>
                    <tr>
                        <td>手机号码 <span class="redStar">*</span></td>
                        <td><input type="text" placeholder="请输入11位手机号码" name="mobile"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="productList">
            <div class="productListTip">
                确认订单消息
            </div>
            <table class="productListTable">
                <thead>
                <tr>
                    <th class="productListTableFirstColumn" colspan="2">
                        <a href="#nowhere" class="marketLink">小边商城</a>
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>

                </thead>
                <tbody class="productListTableTbody">
                <c:forEach items="${ois}" var="oi" varStatus="st" >
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD">
                            <img src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" class="orderItemImg">
                        </td>
                        <td class="orderItemProductInfo">
                            <a class="orderItemProductLink" href="foreproduct?pid=${oi.product.id}">
                                    ${oi.product.name}
                            </a>
                        </td>
                        <td>
                            <span class="orderItemProductPrice">
                                ￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/>
                            </span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${oi.number}</span>
                        </td>
                        <td>
                            <span class="orderItemUnitSum">
                                ￥<fmt:formatNumber type="number" value="${oi.number*oi.product.price}" minFractionDigits="2"/>
                            </span>
                        </td>
                        <c:if test="${st.count==1}">
                            <td class="orderItemLastTD" rowspan="5">
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" checked="checked" value="">
                                    普通配送
                                </label>
                                <select class="orderItemDeliverySelect">
                                    <option>快递 免邮费</option>
                                </select>
                            </td>
                        </c:if>
                    </tr>

                </c:forEach>
                </tbody>
            </table>
            <div class="orderItemSumDiv">
                <span class="pull-right">合计: ￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
            </div>

        </div>
        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/></span>
            </div>
        </div>
        <div class="submitOrderDiv">
            <button class="submitOrderButton" type="submit">提交订单</button>
        </div>
    </form>

</div>