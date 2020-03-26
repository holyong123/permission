<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>物品</title>
    <jsp:include page="/common/backend_common.jsp" />
    <jsp:include page="/common/page.jsp"/>
    <link rel="stylesheet" href="/ztree/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" href="/assets/css/bootstrap-duallistbox.min.css" type="text/css">
    <script type="text/javascript" src="/ztree/jquery.ztree.all.min.js"></script>
    <script type="text/javascript" src="/assets/js/jquery.bootstrap-duallistbox.min.js"></script>
    <style type="text/css">
        .bootstrap-duallistbox-container .moveall, .bootstrap-duallistbox-container .removeall {
            width: 50%;
        }
        .bootstrap-duallistbox-container .move, .bootstrap-duallistbox-container .remove {
            width: 49%;
        }

    </style>

    <style>
        input[type=date]::-webkit-inner-spin-button { visibility: hidden; }
    </style>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>
<div class="page-header">
    <h1>
        物品管理
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            物品管理页面
        </small>
    </h1>
</div>

<div class="main-content-inner">

    <div class="col-sm-9">
        <div class="col-xs-12">
            <div class="table-header">
                已购买物品列表&nbsp;&nbsp;
                <label> &nbsp;&nbsp;&nbsp;</label>
                物品名称: <label> &nbsp;&nbsp;&nbsp;</label><input class="findName"  type="text"  placeholder="请输入物品名称" value="" style="width: 130px; height:23px" />
                <label> &nbsp;&nbsp;&nbsp;</label>
                领用人: <label> &nbsp;&nbsp;&nbsp;</label><input class="findApplicant"  type="text"  placeholder="请输入领用人名称" value=""  style="width: 130px;height:23px"/>
                <label> &nbsp;&nbsp;&nbsp;</label>
                状态:  <label> &nbsp;&nbsp;&nbsp;</label><select class="findStatus" name="status" data-placeholder="选择状态"  style="width: 110px;height:24px;vertical-align:middle;padding-top: 0px">
                <option value ="-1">请选择</option>
                <option value="1">存在</option>
                <option value="0">借出</option>
                <option value="2">不存在</option>
            </select>
                <label> &nbsp;&nbsp;&nbsp;</label>
                归还时间:  <label> &nbsp;&nbsp;&nbsp;</label><input class="backTime"  type="date"  placeholder="请选择查询时间" value="" style="width: 130px;height:23px" />

                <a class="coral" href="#" style="font-size: 10px">
                    <i class="ace-icon fa fa-search white bigger-130 find-search" style="font-size: 15px;color: #0f0f0f;margin-left: 30px">查询</i>
                </a>

                <label> &nbsp;&nbsp;</label>


            </div>
            <div>
                <div id="dynamic-table_wrapper" class="dataTables_wrapper form-inline no-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="dataTables_length" id="dynamic-table_length"><label>
                                展示
                                <select id="pageSize" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                    <option value="10">10</option>
                                </select> 条记录 </label>
                                <a class="red" href="#" style="margin-left:10px">
                                    <i class="ace-icon fa fa-arrow-down white bigger-130 " style="font-size: 15px;color: black;margin-left: 30px;vertical-align:middle;"  onclick="beforeSubmit()">down</i>
                                </a>
                            </div>

                        </div>
                    </div>
                    <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                           aria-describedby="dynamic-table_info" style="font-size:14px">
                        <thead>
                        <tr role="row">
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                物品编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                领用人
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                归还时间
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                使用地点
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label="">

                            </th>

                        </tr>
                        </thead>
                        <tbody id="goodsList"></tbody>
                    </table>
                    <div class="row" id="goodsPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dialog-goods-form" style="display: none;">
    <form id="goodsForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">

            <tr>
                <td><label for="goodsName">物品名称</label></td>
                <input type="hidden" name="id" id="goodsId"/>
                <td><input type="text" name="name" id="goodsName" value="" class="text ui-widget-content ui-corner-all" readonly="readonly"></td>
            </tr>

            <tr>
                <td><label for="assetName">物品编号</label></td>
                <td><input type="text" name="assetId" id="assetName" value="" class="text ui-widget-content ui-corner-all" readonly="readonly"></td>
            </tr>

            <tr>
                <td><label for="GoodUserList">领用人</label></td>
                <td>
<%--                    <input type="text" name="applicant" id="applicantName" value="" class="text ui-widget-content ui-corner-all">--%>
                    <select   name="applicant" id="GoodUserList" data-placeholder="选择状态" style="width: 150px;" >
                        <option value="">请选择</option>

                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="goodsStatus">操作</label></td>
                <td>
                    <select id="goodsStatus" name="status" data-placeholder="选择状态" style="width: 150px;">
                        <option value="1">存在</option>
                        <option value="0">借出</option>
                        <option value="2">不存在</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="operateTime">归还时间</label></td>
                <td><input type ="date" name="operateTime" id="operateTime" value="" class="text ui-widget-content ui-corner-all" ></td>
            </tr>

            <tr>
                <td><label for="usePlaceName">使用地点</label></td>
                <td><input type="text" name="usePlace" id="usePlaceName" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="remark">备注</label></td>
                <td><textarea name="remark" id="remark" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>

        </table>
    </form>
</div>

<div id="dialog-goodsIn-form" style="display: none;">
    <form id="goodsInForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">

            <tr>
                <td><label for="name">物品名称</label></td>
                <td><input type="text" name="name" id="name" value="" class="text ui-widget-content ui-corner-all" readonly="readonly"></td>
            </tr>

            <tr>
                <td><label for="wareHouse">存放地点</label></td>
                <td><input type="text" name="wareHouse" id="wareHouse" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="count">数量</label></td>
                <td><input type="text" name="count" id="count" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="remarkIn">备注</label></td>
                <td><textarea name="remark" id="remarkIn" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>

        </table>
    </form>
</div>


<div id="dialog-excel-form" style="display: none;">
    <form id="excelForm" action="/excel/export.json" method="post">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">

        </table>
    </form>
</div>



<script id="goodsListTemplate" type="x-tmpl-mustache">
{{#goodsList}}
<tr role="row" class="goods-name odd" data-id="{{id}}"><!--even -->
    <td><a href="#" class="goods-edit" data-id="{{id}}">{{name}}</a></td>
    <td>{{assetId}}</td>
    <td>{{applicant}}</td>
    <td>{{#bold}}{{showStatus}}{{/bold}}</td>
    <td>{{operateTime}}</td>
    <td>{{usePlace}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green goods-edit" href="#" data-id="{{id}}" >
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            <a class="red goods-delete" href="#" data-id="{{id}}" data-name="{{name}}">
                 <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
        </div>
    </td>
</tr>
{{/goodsList}}
</script>



<!-- 下拉框模板 -->
<script  id="templateSelect" type="text/x-template" >
    {{#option}}
    <option value="{{value}}">{{text}}</option>
    {{/option}}
</script>


<script type="text/javascript">
    var excelForm = document.getElementById('excelForm');
    function beforeSubmit(){
        excelForm.submit();
    }


    $(function () {
        // var goodsList;
        var goodsMap = {}; // 存储map格式物品信息
        var hasMultiSelect = false;

        var goodsListTemplate = $("#goodsListTemplate").html();
        Mustache.parse(goodsListTemplate);
        var selectedUsersTemplate = $("#selectedUsersTemplate").html();
        Mustache.parse(selectedUsersTemplate);

        var templateSelect = $("#templateSelect").html();
        Mustache.parse(templateSelect);

        loadGoodsList();
        loadRoleUser();

        function loadRoleUser() {
            var url = "/goods/user.json";
            $.ajax({
                url: url,
                type: 'GET',
                success: function (result) {
                    if (result.ret) {
                        $("#GoodUserList").empty();
                        var arrList =result.data;
                        $("#GoodUserList").append("<option value=\"\">请选择</option>");
                        $.each(arrList,function(key,value){
                            var sysUser_html = "<option value='" + value.username +"'> "+value.username +"</option>";
                            $("#GoodUserList").append(sysUser_html);
                        });
                    } else {
                        showMessage("加载角色用户数据", result.msg, false);
                    }
                }
            });
        }

        function loadGoodsList() {
            var url = "/goods/list.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#goodsPage .pageNo").val() || 1;
            $.ajax({
                url: url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                type: 'GET',
                success: function (result) {
                    // goodsList =result.data;
                    renderGoodsListAndPage(result,url);
                }
            });
        }

        function renderGoodsListAndPage(result, url) {
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(goodsListTemplate, {
                        goodsList: result.data.data,
                        // "assetId": function() {
                        //     return goodsMap[this.id].name;
                        // },
                        "showStatus": function() {
                            return this.status == 1 ? '存在' : (this.status == 0 ? '借出' : '不存在');
                        },
                        "bold": function() {
                            return function(text, render) {
                                var status = render(text);
                                if (status == '存在') {
                                    return "<span class='label label-sm label-success'>存在</span>";
                                } else if(status == '借出') {
                                    return "<span class='label label-sm label-warning'>借出</span>";
                                } else {
                                    return "<span class='label'>不存在</span>";
                                }
                            }
                        },



                    });
                    $("#goodsList").html(rendered);
                    bindGoodClick();
                    $.each(result.data.data, function(i, goods) {
                        goodsMap[goods.id] = goods;
                    })
                } else {
                    $("#goodsList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#goodsPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "goodsPage", renderGoodsListAndPage);
            } else {
                showMessage("获取物品列表", result.msg, false);
            }
        }

        $(".goods-add").click(function () {
            $("#dialog-goodsIn-form").dialog({
                model: true,
                title: "新增物品",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    recursiveRenderGoodsSelect(goodsList);
                    $("#goodsInForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        saveGoods(true, function (data) {
                            $("#dialog-goodsIn-form").dialog("close");
                        }, function (data) {
                            showMessage("新增物品", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-goodsIn-form").dialog("close");
                    }
                }
            })
        });



        $(".find-search").click(function(){
            var data ={};
            var url = "/goods/listLikeByCondition.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#approvalPage .pageNo").val() || 1;
            data.pageSize = pageSize;
            data.pageNo = pageNo;


            var findName =  $(".findName").val();
            if(findName!="" && findName !=undefined){
                data.name = findName;
            }
            var findApplicant =   $(".findApplicant").val();
            if(findApplicant!="" && findApplicant !=undefined){
                data.applicant = findApplicant;
            }
            var findStatus = $(".findStatus").val();
            if(findStatus!="" && findStatus !=undefined && findStatus != "-1"){
                data.status = findStatus;
            }
            var backTime = $(".backTime").val();
            if(backTime!="" && backTime !=undefined){
                data.operateTime = backTime;
            }

            $.ajax({
                url: url,
                data: data,
                type: 'GET',
                success: function (result) {
                    renderGoodsListAndPage(result,url);
                }
            });



        })






        function recursiveRenderGoodsSelect(goodsList) {
            if (goodsList && goodsList.length > 0) {
                $(goodsList).each(function (i, goods) {
                    goodsMap[goods.id] = goods;
                });
            }
        }

        function bindGoodClick() {
            $(".goods-edit").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var goodsId = $(this).attr("data-id");
                $("#dialog-goods-form").dialog({
                    model: true,
                    title: "修改物品",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        recursiveRenderGoodsSelect(goodsList);
                        $("#goodsForm")[0].reset();
                        $("#goodsId").val(goodsId);
                        var targetGoods = goodsMap[goodsId];

                        if (targetGoods) {
                            $("#goodsName").val(targetGoods.name);
                            $("#assetName").val(targetGoods.assetId);
                            $("#roleUserList").val();
                            $("#goodsStatus").val(targetGoods.status);
                            $("#operateTime").val(targetGoods.operateTime);
                            $("#usePlaceName").val(targetGoods.usePlace);
                            $("#remark").val(targetGoods.remark);
                        }
                    },
                    buttons : {
                        "修改": function(e) {
                            e.preventDefault();
                            updateGoods(false, function (data) {
                                $("#dialog-goods-form").dialog("close");
                            }, function (data) {
                                showMessage("修改物品", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-goods-form").dialog("close");
                        }
                    }
                })
            });
            $(".goods-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var goodsId = $(this).attr("data-id");
                var goodsName = $(this).attr("data-name");
                console.log("id" +  goodsId + "goodsName" ,goodsName);
                if (confirm("确定要删除物品   ["  + goodsName + "]   吗?")) {
                    $.ajax({
                        url: "/goods/delete.json",
                        data: {
                            id: goodsId
                        },
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除物品  [" + goodsName + "] ", "操作成功", true);
                                loadGoodsList();
                            } else {
                                showMessage("删除该物品块   [" + goodsName + "]", result.msg, false);
                            }
                        }
                    });
                }
            });

        }

        function updateGoods(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/goods/save.json" : "/goods/update.json",
                data: $("#goodsForm").serializeArray(),
                type: 'post',
                success: function(result) {
                    if (result.ret) {
                        loadGoodsList();
                        if (successCallback) {
                            successCallback(result);
                        }
                    } else {
                        if (failCallback) {
                            failCallback(result);
                        }
                    }
                }
            })
        }


        function saveGoods(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/goods/save.json" : "/goods/save.json",
                data: $("#goodsInForm").serializeArray(),
                type: 'post',
                success: function(result) {
                    if (result.ret) {
                        loadGoodsList();
                        if (successCallback) {
                            successCallback(result);
                        }
                    } else {
                        if (failCallback) {
                            failCallback(result);
                        }
                    }
                }
            })
        }





    });
</script>
</body>
</html>
