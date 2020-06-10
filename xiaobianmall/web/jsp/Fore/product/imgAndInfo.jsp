<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2020/5/28
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<script>

    $(function(){
        var stock = ${p.stock};
        $(".productNumberSetting").keyup(function(){
            var num= $(".productNumberSetting").val();
            num = parseInt(num);
            if(isNaN(num))
                num= 1;
            if(num<=0)
                num = 1;
            if(num>stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });

        $(".increaseNumber").click(function(){
            var num= $(".productNumberSetting").val();
            num++;
            if(num>stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });
        $(".decreaseNumber").click(function(){
            var num= $(".productNumberSetting").val();
            --num;
            if(num<=0)
                num=1;
            $(".productNumberSetting").val(num);
        });

        $(".addCartLink").click(function(){
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){
                    if("success"==result){
                        var pid = ${p.id};
                        var num= $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        $.get(
                            addCartpage,
                            {"pid":pid,"num":num},
                            function(result){
                                if("success"==result){
                                    $(".addCartButton").html("已加入购物车");
                                    $(".addCartButton").attr("disabled","disabled");
                                    $(".addCartButton").css("background-color","lightgray")
                                    $(".addCartButton").css("border-color","lightgray")
                                    $(".addCartButton").css("color","black")

                                }
                                else{

                                }
                            }
                        );
                    }
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });
        $(".buyLink").click(function(){
            var page = "forecheckLogin";
            $.get(
                page,
                function(result){
                    if("success"==result){
                        var num = $(".productNumberSetting").val();
                        location.href= $(".buyLink").attr("href")+"&num="+num;
                    }
                    else{
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });

        $("button.loginSubmitButton").click(function(){
            var name = $("#name").val();
            var password = $("#password").val();

            if(0==name.length||0==password.length){
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }

            var page = "foreloginAjax";
            $.get(
                page,
                {"name":name,"password":password},
                function(result){
                    if("success"==result){
                        location.reload();
                    }
                    else{
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );

            return true;
        });

        $("img.smallImage").mouseenter(function(){
            var bigImageURL = $(this).attr("bigImageURL");
            $("img.bigImg").attr("src",bigImageURL);
        });

        $("img.bigImg").load(
            function(){
                $("img.smallImage").each(function(){
                    var bigImageURL = $(this).attr("bigImageURL");
                    img = new Image();
                    img.src = bigImageURL;

                    img.onload = function(){
                        console.log(bigImageURL);
                        $("div.img4load").append($(img));
                    };
                });
            }
        );
    });

</script>
<style>
    div.imgAndInfo {
        margin: 40px 40px;
    }

    div.img {
        width: 350px;
        float: left;
    }

    div.img img.bigImg {
        width: 300px;
        height: 300px;
        padding: 20px;
        border: 1px solid #F2F2F2;
    }

    div.info {
        padding: 0px 50px;
        overflow: hidden;
    }

    div.info div.productTitle {
        color: black;
        font-size: 16px;
        font-weight: bold;
        margin: 0px 10px;
    }

    div.priceAndNumber {
        background-image: url(img/priceBackground.png);
    }

    div.info div.productPrice {
        margin-top: 10px;
        height: 10px;
        padding: 10px;
        color: #666666;
    }

    div.info span.PriceDesc {
        color: #999999;
        display: inline-block;
        width: 68px;
    }

    div.info div.productNumber {
        color: #999999;
        padding: 10px;
    }

    div.productNumber span.productNumberSettingSpan {
        border: 1px solid #999;
        display: inline-block;
        width: 43px;
        height: 28px;
        padding-top: 7px;
    }

    div.productNumber input.productNumberSetting {
        border: 0px;
        height: 80%;
        width: 80%;
        background-color: transparent
    }

    div.productNumber span.updown img {
        display: inline-block;
        vertical-align: top;
    }

    div.productNumber span.updown {
        border: 1px solid #999;
        display: block;
        width: 20px;
        height: 12px;
        text-align: center;
        padding-top: 4px;
    }

    div.productNumber span.updownMiddle {
        height: 4px;
        display: block;
    }

    div.productNumber span.arrow {
        display: inline-block;
        width: 22px;
        height: 32px;
        vertical-align: top;
    }

    div.info div.buyDiv {
        margin: 20px auto;
        text-align: center;
    }

    div.buyDiv button {
        display: inline-block;
        margin: 0px 10px;
        width: 180px;
        height: 40px;
    }

    button.buyButton {
        border: 1px solid #C40000;
        background-color: #FFEDED;
        text-align: center;
        line-height: 40px;
        font-size: 16px;
        color: #C40000;
        font-family: arial;
    }

    button.addCartButton {
        border: 1px solid #C40000;
        background-color: #C40000;
        text-align: center;
        line-height: 40px;
        font-size: 16px;
        color: white;
        font-family: arial;
    }

    button.addCartButton span.glyphicon {
        font-size: 12px;
        margin-right: 8px;
    }
</style>

<%--改--%>
<div class="imgAndInfo">
    <div class="img">
        <img class="bigImg" src="img/productSingle/${p.firstProductImage.id}.jpg">
    </div>
    <div class="info">
        <div class="productTitle">
            ${p.name}
        </div>
        <div class="priceAndNumber">
            <div class="productPrice">
                <span class="PriceDesc">价格</span>
                <span class="PriceYuan">¥</span>
                <span class="Price"><fmt:formatNumber type="number" value="${p.price}" minFractionDigits="2"/></span>
            </div>
            <div class="productNumber">
                <span>数量</span>
                <span>
                    <span class="productNumberSettingSpan">
                        <input type="text" value="1" class="productNumberSetting">
                    </span>
                    <span class="arrow">
                        <a class="increaseNumber" href="#nowhere">
                            <span class="updown">
                                <img src="../img/increase.png">
                            </span>
                        </a>
                        <span class="updownMiddle"> </span>
                        <a class="decreaseNumber" href="#nowhere">
                            <span class="updown">
                                <img src="../img/decrease.png">
                            </span>
                        </a>
                    </span>
                    件
                </span>
                <span>库存${p.stock}件</span>
            </div>
        </div>

        <div class="buyDiv">
            <a href="forebuyone?pid=${p.id}" class="buyLink">
                <button class="buyButton">立即购买</button>
            </a>
            <a class="addCartLink" href="#nowhere">
                <button class="addCartButton">
                    <span class="glyphicon glyphicon-shopping-cart"></span>加入购物车
                </button>
            </a>
        </div>
    </div>
</div>
<div style="height: 100px">
</div>
