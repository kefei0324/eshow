<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8"
         contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<head>
    <title>财务汇总</title>
    <%@ include file="/common/style/validate.jsp" %>
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/chosen.css">
    <link rel="stylesheet" href="${dll}/manage/styles/jquery.cxcalendar.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/simditor.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/style.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/layer.css">
    <link rel="stylesheet" type="text/css" href="${dll}/manage/styles/select2.css">
</head>
<body>
<div class="home_wrapper ">
    <%@ include file="/include/financialleft.jsp" %>
    <div class="home_content">
        <div class="home_list" >
            <ul class="home_navbar clearfix ">
                <li><a href="">财务中心</a></li>
                <li><span>></span></li>
                <li><a href="">财务汇总</a></li>
                <li><span>></span></li>
                <li>财务汇总</li>
            </ul>
        </div>
        <div class="home_block clearfix">
            <div class="financeView">
                <div class="thisType">
                    <span>订单状态</span><span class="label-success label">成功</span>
                </div>

                <table class="table table-striped">
                    <tbody>
                    <tr>
                        <td>交易时间</td>
                        <td>类型</td>
                        <td>流水号</td>
                        <td>订单号</td>
                        <td>实付金额</td>
                        <td>优惠</td>
                        <td>服务费</td>
                        <td>总金额</td>
                    </tr>
                    <tr>
                        <td>2017-03-21<br>18:12:33</td>
                        <td>购物</td>
                        <td>123334</td>
                        <td>99877623663</td>
                        <td>4.12</td>
                        <td>+1.3</td>
                        <td>+2.1</td>
                        <td>212.5</td>
                    </tr>

                    <tr>
                        <td>交易账户</td>
                        <td colspan="7">交易方式</td>
                    </tr>
                    <tr>
                        <td>18737237333</td>
                        <td colspan="7">银行卡</td>
                    </tr>

                    <tr>
                        <td>创建时间</td>
                        <td>付款时间</td>
                        <td colspan="6">完成时间</td>
                    </tr>
                    <tr>
                        <td>2017-03-21<br>18:12:33</td>
                        <td>2017-03-21<br>18:12:33</td>
                        <td colspan="6">2017-03-21<br>18:12:33</td>
                    </tr>


                    <tr>
                        <td>退款编号</td>
                        <td>申请退款时间</td>
                        <td>退款理由</td>
                        <td>退款金额(元)</td>
                        <td>退款状态</td>
                        <td colspan="3">其他信息</td>
                    </tr>
                    <tr>
                        <td>0000012</td>
                        <td>2017-03-21<br>18:12:33</td>
                        <td>就是这么任性</td>
                        <td>199.22</td>
                        <td><span class="label label-success">成功</span> </td>
                        <td colspan="3">无</td>
                    </tr>
                    <tr>
                        <td colspan="10">备注</td>
                    </tr>
                    <tr>

                        <td colspan="10">无</td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>


    </div>

</div>
<%@ include file="/common/scripts.jsp" %>
<script type="text/javascript" src="${dll}/manage/scripts/js.js"></script>
<script type="text/javascript" src="${dll}/layer/layer.js"></script>
<%@ include file="/common/script/validate.jsp" %>
<script type="text/javascript" src="${dll}/manage/scripts/select2.full.min.js"></script>
<script type="text/javascript">
//    getTxt(".promoter_select_down .down_li_active", ".classic", "categoryId");
//    getTxt(".public_select_down .down_li_active", ".input_public", "userId");
$(document).ready(function() {
//            $(".js-example-basic-single").select2();
    $("#categoryId").select2({
        ajax: {
            type:'GET',
            url: "${ctx}/category!page.action?query.website=${website}",
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term 请求参数
                    page: params.page
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data.beans,//itemList
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        },
        placeholder:'请选择',//默认文字提示
        language: "zh-CN",
        tags: true,//允许手动添加
        allowClear: true,//允许清空
        escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
        minimumInputLength: 1,//最少输入多少个字符后开始查询
        templateResult: formatRepo,
        formatResult: function formatRepo(repo){return repo;}, // 函数用来渲染结果
        formatSelection: function formatRepoSelection(repo){
            $("#categoryName").val(repo.text);
            return repo.text;
        } // 函数用于呈现当前的选择
    });

    $("#userId").select2({
        ajax: {
            type:'GET',
            url: "${ctx}/user!page.action?query.website=${website}",
            dataType: 'json',
            delay: 250,
            data: function (params) {
                return {
                    q: params.term, // search term 请求参数
                    page: params.page
                };
            },
            processResults: function (data, params) {
                params.page = params.page || 1;
                return {
                    results: data.beans,//itemList
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        },
        placeholder:'请选择',//默认文字提示
        language: "zh-CN",
        tags: true,//允许手动添加
        allowClear: true,//允许清空
        escapeMarkup: function (markup) { return markup; }, // 自定义格式化防止xss注入
        minimumInputLength: 1,//最少输入多少个字符后开始查询
        templateResult: formatRepo,
        formatResult: function formatRepo(repo){return repo;}, // 函数用来渲染结果
        formatSelection: function formatRepoSelection(repo){
            $("#userNickname").val(repo.text);
            return repo.text;
        } // 函数用于呈现当前的选择
    });
});

/* 这里2个函数是用于查询到内容后，显示在select2的下拉框里面 */
function formatRepo (repo) {
    if (repo.loading) return repo.text;
    var markup = '<div class="clearfix">' +
            '<div class="col-sm-20">' + repo.text + '</div>' +
            '</div>';

    return markup;
}
</script>
</body>

