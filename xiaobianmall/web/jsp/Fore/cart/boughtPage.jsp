<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<script>
    var deleteOrder = false;
    var deleteOrderid = 0;

    $(function(){
        $("a[orderStatus]").click(function(){
            var orderStatus = $(this).attr("orderStatus");
            if('all'==orderStatus){
                $("table[orderStatus]").show();
            }
            else{
                $("table[orderStatus]").hide();
                $("table[orderStatus="+orderStatus+"]").show();
            }

            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });

        $("a.deleteOrderLink").click(function(){
            deleteOrderid = $(this).attr("oid");
            deleteOrder = false;
            $("#deleteConfirmModal").modal("show");
        });

        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrder){
                var page="foredeleteOrder";
                $.post(
                    page,
                    {"oid":deleteOrderid},
                    function(result){
                        if("success"==result){
                            $("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
                        }
                        else{
                            location.href="login.jsp";
                        }
                    }
                );

            }
        })

        $(".ask2delivery").click(function(){
            var link = $(this).attr("link");
            $(this).hide();
            page = link;
            $.ajax({
                url: page,
                success: function(result){
                    alert("卖家已秒发，刷新当前页面，即可进行确认收货")
                }
            });

        });
    });

</script>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType">
            <a href="#nowhere" orderStatus="all">所有订单</a>
        </div>
        <div>
            <a href="#nowhere" orderStatus="waitPay">待付款</a>
        </div>
        <div>
            <a href="#nowhere" orderStatus="waitDelivery">待发货</a>
        </div>
        <div>
            <a href="#nowhere" orderStatus="waitConfirm">待收货</a>
        </div>
<%--        <div>--%>
<%--            <a class="noRightborder" href="#nowhere" orderStatus="waitReview">待评价</a>--%>
<%--        </div>--%>
        <div class="orderTypeLastOne"><a class="noRightborder">&nbsp;</a></div>
    </div>
    <div style="clear: both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tbody>
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="orderListItem">
        <c:forEach items="${os}" var="o">
            <table oid="${o.id}" orderStatus="${o.status}" class="orderListItemTable">
                <tbody>
                <tr class="orderListItemFirstTR">
                    <td colspan="5">
                        <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>&nbsp;&nbsp;&nbsp;&nbsp;
                        <span>订单号: ${o.orderCode} </span>
                    </td>
                    <td class="orderItemDeleteTD">
                        <a href="#nowhere" oid="${o.id}" class="deleteOrderLink">
                            <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>
                <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD">
                            <img src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" width="80" height="80">
                        </td>
                        <td class="orderItemProductInfoPartTD" style="text-align: left">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                            </div>
                        </td>
                        <td class="orderItemProductInfoPartTD" width="100px">
                            <div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.price}" minFractionDigits="2"/></div>
                        </td>
                        <c:if test="${st.count==1}">
                            <td width="100px" rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD">
                                <span class="orderListItemNumber">${o.totalNumber}</span>
                            </td>
                            <td width="120px" rowspan="${fn:length(o.orderItems)}" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" rowspan="1">
                                <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/></div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td width="100px" rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" rowspan="1">
                                <c:if test="${o.status=='waitConfirm' }">
                                    <a href="foreconfirmPay?oid=${o.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                <c:if test="${o.status=='waitPay' }">
                                    <a href="forealipay?oid=${o.id}&total=${o.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>

                                <c:if test="${o.status=='waitDelivery' }">
                                    <span>待发货</span>
                                    <%-- <button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催卖家发货</button> --%>

                                </c:if>

                                <c:if test="${o.status=='waitReview' }">
                                    <a href="forereview?oid=${o.id}">
                                        <button  class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>

                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </c:forEach>

    </div>
</div>
<div style="height: 50px"></div>
