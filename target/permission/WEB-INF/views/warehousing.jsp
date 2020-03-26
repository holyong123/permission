<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>审批-入库物品</title>
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
       购买入库
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            物品入库页面
        </small>
    </h1>
</div>

<div class="main-content-inner">

    <div class="col-sm-9">
        <div class="col-xs-12">
            <div class="table-header">
                入库列表&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-plus-circle orange bigger-130 approval-add"></i>
                </a>
<%--                <a class="red" href="#" style="margin-left:10px">--%>
<%--                    <i class="ace-icon fa fa-arrow-down orange bigger-130 "  onclick="beforeSubmit()"></i>--%>
<%--                </a>--%>

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
                            </div>
                        </div>
                    </div>
                    <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                           aria-describedby="dynamic-table_info" style="font-size:14px">
                        <thead>
                        <tr role="row">
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                物品名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                               用途
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                               性能参数
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                               数量
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                               使用时间
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                        </tr>
                        </thead>
                        <tbody id="approvalList"></tbody>
                    </table>
                    <div class="row" id="approvalPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dialog-approval-form" style="display: none;">
    <form id="approvalForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">

            <tr>
                <td><label for="approvalName">物品名称</label></td>
                <input type="hidden" name="id" id="approvalId"/>
                <td><input type="text" name="name" id="approvalName" value="" class="text ui-widget-content ui-corner-all" readonly="readonly"></td>
            </tr>

<%--            <tr>--%>
<%--                <td><label for="purpose">用途</label></td>--%>
<%--                <td><input type="text" name="purpose" id="purpose" value="" class="text ui-widget-content ui-corner-all"></td>--%>
<%--            </tr>--%>

<%--            <tr>--%>
<%--                <td><label for="performance">性能参数</label></td>--%>
<%--                <td><textarea name="performance" id="performance" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>--%>
<%--            </tr>--%>


            <tr>
                <td><label for="approvalStatus">操作</label></td>
                <td>
                    <select id="approvalStatus" name="status" data-placeholder="选择状态" style="width: 150px;">
                        <option value="3">购买</option>
                        <option value="0">已购买</option>
                        <option value="4">入库</option>
                    </select>
                </td>
            </tr>

<%--            <tr>--%>
<%--                <td><label for="count">数量</label></td>--%>
<%--                <td><input name="count" id="count" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></input></td>--%>
<%--            </tr>--%>

<%--            <tr>--%>
<%--                <td><label for="approvalTime">使用时间</label></td>--%>
<%--                <td><input type ="date" name="operateTime" id="approvalTime" value="" class="text ui-widget-content ui-corner-all"></td>--%>
<%--            </tr>--%>
            <tr>
                <td><label for="remark">备注</label></td>
                <td><textarea name="remark" id="remark" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>



        </table>
    </form>
</div>


<script id="approvalListTemplate" type="x-tmpl-mustache">
{{#approvalList}}
<tr role="row" class="approval-name odd" data-id="{{id}}"><!--even -->
    <td><a href="#" class="approval-edit" data-id="{{id}}">{{name}}</a></td>
    <td>{{purpose}}</td>
    <td>{{performance}}</td>
     <td>{{#bold}}{{showStatus}}{{/bold}}</td>
     <td>{{count}}</td>
    <td>{{operateTime}}</td>

    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green approval-edit" href="#" data-id="{{id}}" >
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            <a class="red approval-delete" href="#" data-id="{{id}}" data-name="{{name}}">
                 <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
        </div>
    </td>
</tr>
{{/approvalList}}
</script>





<script type="text/javascript">

    $(function(){

        var approvalMap = {}; // 存储map格式物品信息
        var approvalListTemplate = $("#approvalListTemplate").html();
        Mustache.parse(approvalListTemplate);

        loadApprovalList();

        function loadApprovalList(){
            var url = "/approval/listByCondition.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#approvalPage .pageNo").val() || 1;
            $.ajax({
                url: url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                type: 'GET',
                success: function (result) {
                    renderApprovalListAndPage(result,url);
                }
            });
        }

        function renderApprovalListAndPage(result,url){
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(approvalListTemplate, {
                        approvalList: result.data.data,
                        "showStatus": function() {
                            switch(this.status){
                                case 0 :
                                    //语句
                                    return '已购买'; //可选
                                case 2:
                                    //语句
                                    return '不同意'; //可选
                                case 3:
                                    //语句
                                    return  '购买'; //可选
                                case 4:
                                    //语句
                                    return '入库'; //可选
                                case 5:
                                    //语句
                                    return '返回修改'; //可选
                                default : //可选
                                    return '待审批'
                            }
                            // return this.status == 1 ? '审批中' : (this.status == 0 ? '审批通过' : '审批不通过');
                        },
                        "bold": function() {
                            return function(text, render) {
                                var status = render(text);
                                if (status == '待审批') {
                                    return "<span class='label label-sm label-info'>待审批</span>";
                                } else if(status == '已购买') {
                                    return "<span class='label label-sm label-success'>已购买</span>";
                                } else if(status == '购买') {
                                    return "<span class='label label-sm label-success'>购买</span>";
                                }
                                else if(status == '入库') {
                                    return "<span class='label label-sm label-success'>入库</span>";
                                }
                                else if(status == '返回修改') {
                                    return "<span class='label label-sm label-danger'>返回修改</span>";
                                }
                                else {
                                    return "<span class='label  label-danger'>不同意</span>";
                                }
                            }
                        },

                    });
                    $("#approvalList").html(rendered);

                    bindApprovalClick();

                    $.each(result.data.data, function(i, approval) {
                        approvalMap[approval.id] = approval;
                    })

                } else {
                    $("#approvalList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#approvalPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "approvalPage", renderApprovalListAndPage);
            } else {
                showMessage("获取审批列表", result.msg, false);
            }



        }

        $(".approval-add").click(function () {
            $("#dialog-approval-form").dialog({
                model: true,
                title: "添加需要审批物品",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    $("#approvalForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateApproval(true, function (data) {
                            $("#dialog-approval-form").dialog("close");
                        }, function (data) {
                            showMessage("添加审批物品", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-approval-form").dialog("close");
                    }
                }
            })
        });


        function bindApprovalClick(){
            $(".approval-edit").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var  approvalId = $(this).attr("data-id");
                $("#dialog-approval-form").dialog({
                    model: true,
                    title: "审批购买物品",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        $("#approvalForm")[0].reset();
                        $("#approvalId").val(approvalId);
                        var targetApproval = approvalMap[approvalId];
                        if (targetApproval) {
                            $("#approvalName").val(targetApproval.name);
                            // $("#purpose").val(targetApproval.purpose);
                            // $("#performance").val(targetApproval.performance);
                            // $("#count").val(targetApproval.count);
                            $("#approvalStatus").val(targetApproval.status);
                            // $("#approvalTime").val(targetApproval.operateTime);
                            $("#remark").val(targetApproval.remark);
                        }
                    },
                    buttons : {
                        "修改": function(e) {
                            e.preventDefault();
                            updateApproval(false, function (data) {
                                $("#dialog-approval-form").dialog("close");
                            }, function (data) {
                                showMessage("修改审批物品", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-approval-form").dialog("close");
                        }
                    }
                })
            });
            $(".approval-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var approvalId = $(this).attr("data-id");
                var approvalName = $(this).attr("data-name");
                if (confirm("确定要删除需要审批的物品   ["  + approvalName + "]   吗?")) {
                    $.ajax({
                        url: "/approval/delete.json",
                        data: {
                            id: approvalId
                        },
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除审批的物品  [" + approvalName + "] ", "操作成功", true);
                                loadApprovalList();
                            } else {
                                showMessage("删除该审批物品   [" + approvalName + "]", result.msg, false);
                            }
                        }
                    });
                }
            });


        }



        function updateApproval(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/approval/save.json" : "/approval/update.json",
                data: $("#approvalForm").serializeArray(),
                type: 'post',
                success: function(result) {
                    if (result.ret) {

                        loadApprovalList();
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

    })


</script>
</body>
</html>
