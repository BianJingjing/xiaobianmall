<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/29
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%--未改--%>
<script>
    var deleteOrderItem = false;
    var deleteOrderItemid = 0;
    $(function(){

        $("a.deleteOrderItem").click(function(){
            deleteOrderItem = false;
            var oiid = $(this).attr("oiid")
            deleteOrderItemid = oiid;
            $("#deleteConfirmModal").modal('show');
        });
        $("button.deleteConfirmButton").click(function(){
            deleteOrderItem = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrderItem){
                var page="foredeleteOrderItem";
                $.post(
                    page,
                    {"oiid":deleteOrderItemid},
                    function(result){
                        if("success"==result){
                            $("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").hide();
                        }
                        else{
                            location.href="login.jsp";
                        }
                    }
                );

            }
        })

        $("img.cartProductItemIfSelected").click(function () {
            var selectit = $(this).attr("selectit");
            if ("selectit" == selectit) {
                $(this).attr("src", "../img/cartNotSelected.png");
                $(this).attr("selectit", "false");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
            } else {
                $(this).attr("src", "../img/cartSelected.png");
                $(this).attr("selectit", "selectit")
                $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
            }
            syncSelect();
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();
        });
        $("img.selectAllItem").click(function () {
            var selectit = $(this).attr("selectit")
            if ("selectit" == selectit) {
                $("img.selectAllItem").attr("src", "../img/cartNotSelected.png");
                $("img.selectAllItem").attr("selectit", "false")
                $(".cartProductItemIfSelected").each(function () {
                    $(this).attr("src", "../img/cartNotSelected.png");
                    $(this).attr("selectit", "false");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
                });
            } else {
                $("img.selectAllItem").attr("src", "../img/cartSelected.png");
                $("img.selectAllItem").attr("selectit", "selectit")
                $(".cartProductItemIfSelected").each(function () {
                    $(this).attr("src", "../img/cartSelected.png");
                    $(this).attr("selectit", "selectit");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
                });
            }
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();
        });
        $(".numberPlus").click(function () {
            var pid = $(this).attr("pid");
            var stock = $("span.orderItemStock[pid=" + pid + "]").text();
            var price = $("span.orderItemOriginalPrice[pid=" + pid + "]").text();
            var num = $(".orderItemNumberSetting[pid=" + pid + "]").val();
            num = parseInt(num);
            num++;
            if (num > stock)
                num = stock;
            syncPrice(pid, num, price);
        });
        $(".numberMinus").click(function () {
            var pid = $(this).attr("pid");
            var stock = $("span.orderItemStock[pid=" + pid + "]").text();
            var price = $("span.orderItemOriginalPrice[pid=" + pid + "]").text();
            var num = $(".orderItemNumberSetting[pid=" + pid + "]").val();
            num = parseInt(num);
            --num;
            if (num <= 0)
                num = 1;
            syncPrice(pid, num, price);
        });

        $(".orderItemNumberSetting").keyup(function () {
            var pid = $(this).attr("pid");
            var stock = $("span.orderItemStock[pid=" + pid + "]").text();
            var price = $("span.orderItemOriginalPrice[pid=" + pid + "]").text();
            var num = $(".orderItemNumberSetting[pid=" + pid + "]").val();
            num = parseInt(num);
            if (isNaN(num))
                num = 1;
            if (num <= 0)
                num = 1;
            if (num > stock)
                num = stock;
            syncPrice(pid, num, price);
        });

        $("button.createOrderButton").click(function(){
            var params = "";
            $(".cartProductItemIfSelected").each(function(){
                if("selectit"==$(this).attr("selectit")){
                    var oiid = $(this).attr("oiid");
                    params += "&oiid="+oiid;
                }
            });
            params = params.substring(1);
            location.href="forebuy?"+params;
        });

    })

    function syncCreateOrderButton(){
        var selectAny=false;
        $(".cartProductItemIfSelected").each(function(){
            if ("selectit"==$(this).attr("selectit")){
                selectAny=true;
            }
        });
        if(selectAny){
            $("button.createOrderButton").css("background-color","#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        }
        else{
            $("button.createOrderButton").css("background-color","#AAAAAA");
            $("button.createOrderButton").attr("disabled","disabled");
        }
    }
    function syncSelect(){
        var selectAll=true;
        $(".cartProductItemIfSelected").each(function(){
            if("false"==$(this).attr("selectit")){
                selectAll=false;
            }
        });
        if(selectAll){
            $("img.selectAllItem").attr("src","../img/cartSelected.png");
        }
        else{
            $("img.selectAllItem").attr("src","../img/cartNotSelected.png");
        }
    }
    function calcCartSumPriceAndNumber(){
        var sum=0;
        var totalNumber=0;
        $("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
            var oiid=$(this).attr("oiid");
            var price=$(".cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
            price=price.replace(/,/g,"");
            price=price.replace(/￥/g,"");
            sum+=new Number(price);

            var num=$(".orderItemNumberSetting[oiid="+oiid+"]").val();
            totalNumber+=new Number(num);
        });
        $("span.cartSumPrice").html("￥"+formatMoney(sum));
        $("span.cartTitlePrice").html("￥"+formatMoney(sum));
        $("span.cartSumNumber").html(totalNumber);
    }

    function syncPrice(pid,num,price){
        $(".orderItemNumberSetting[pid="+pid+"]").val(num);
        var cartProductItemSmallSumPrice = formatMoney(num*price);
        $(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
        calcCartSumPriceAndNumber();
    }

</script>


<title>购物车</title>
<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span>已选商品（不含运费）</span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" style="background-color: rgb(170,170,170)" disabled="disabled">结算</button>
    </div>
    <div class="cartProductList" >
        <table class="cartProductTable">
            <thread>
                <tr>
                    <th class="selectAndImage">
                        <img src="img/cartNotSelected.png" class="selectAllItem" selectit="false">
                        全选
                    </th>
                    <th>商品信息</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th width="120px">金额</th>
                    <th class="operation">操作</th>
                </tr>
            </thread>
            <tbody>
                <c:forEach items="${ois }" var="oi">
                    <tr class="cartProductItemTR" oiid="${oi.id}">
                        <td>
                            <img src="img/cartNotSelected.png" class="cartProductItemIfSelected" oiid="${oi.id}" selectit="false">
                            <a href="#nowhere" style="display:none">
                                <img src="img/cartSelected.png">
                            </a>
                            <img width="40px" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" class="cartProductImg">
                        </td>
                        <td>
                            <div class="cartProductLinkOutDiv">
                                <a class="cartProductLink" href="foreproduct?pid=${oi.product.id}">
                                        ${oi.product.name}
                                </a>
                            </div>
                        </td>
                        <td>
                            <span class="cartProductItemOriginalPrice">￥${oi.product.price}</span>
                        </td>
                        <td>
                            <div class="cartProductChangeNumberDiv">
                                <span pid="${oi.product.id}" class="hidden orderItemStock ">${oi.product.stock}</span>
                                <span pid="${oi.product.id}" class="hidden orderItemOriginalPrice " >${oi.product.price}</span>
                                <a href="#nowhere" class="numberMinus" pid="${oi.product.id}">-</a>
                                <input value="${oi.number}" autocomplete="off" class="orderItemNumberSetting" oiid="${oi.id}" pid="${oi.product.id}">
                                <a href="#nowhere" class="numberPlus" pid="${oi.product.id}" stock="${oi.product.stock}">+</a>
                            </div>
                        </td>
                        <td>
                            <span pid="${oi.product.id}" oiid="${oi.id}" class="cartProductItemSmallSumPrice">￥<fmt:formatNumber type="number" value="${oi.product.price*oi.number}" minFractionDigits="2"/></span>
                        </td>
                        </td>
                        <td>
                            <a href="#nowhere" oiid="${oi.id}" class="deleteOrderItem">删除</a>
                        </td>
                    </tr>
                </c:forEach>


            </tbody>
        </table>
    </div>
    <div class="cartFoot">
        <img src="img/cartNotSelected.png" class="selectAllItem" selectit="false">
        <span>全选</span>
        <div class="pull-right">
            <span>已选商品 <span class="cartSumNumber">0</span> 件</span>
            <span>合计 (不含运费): </span>
            <span class="cartSumPrice">￥0.00</span>
            <button class="createOrderButton" style="background-color: rgb(170, 170, 170);" disabled="disabled">结  算</button>
        </div>
    </div>
</div>
