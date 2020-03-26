<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>故障-故障填写单</title>
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
        故障填写
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            故障填写页面
        </small>
    </h1>
</div>

<div class="main-content-inner">

    <div class="col-sm-12">
        <div class="col-xs-12">
            <div class="table-header">
                故障填写列表&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-plus-circle orange bigger-130 fault-add"></i>
                </a>

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
                                故障标题
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                请求类型
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                业务系统
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                故障现象
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                故障处理人
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                故障出现时间
                            </th>

                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                        </tr>
                        </thead>
                        <tbody id="faultList"></tbody>
                    </table>
                    <div class="row" id="faultPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--display: none;--%>
<div id="dialog-fault-form" style="display: none;height: auto;width: auto">
    <form id="faultForm" style="width: auto;">
        <table class="table table-striped table-bordered table-hover dataTable no-footer " style="width: auto" >
            <tr>
                <td><label for="faultTitle" id="tilte" >故障标题</label></td>
                <input type="hidden" name="id" id="id" />
                <td><input type="text" name="faultTitle" id="faultTitle" class="text ui-widget-content ui-corner-all"  style="outline: none;"> </input></td>
            </tr>

            <tr>
                <td><label for="requestType">请求类型</label></td>
                <td>
                    <select id="requestType" name="requestType" data-placeholder="选择状态" style="width: 150px;">
                        <option value="1">故障</option>
                        <option value="2">业务变动</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="faultType">业务系统</label></td>
                <td>
                    <select id="faultType" name="faultType"  data-placeholder="选择状态"  style="width: 150px;">
                        <option value="">请选择</option>
                        <option value="1">系统</option>
                        <option value="2">网络</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="faultPhenomenon">故障现象</label></td>
                <td><textarea name="faultPhenomenon" id="faultPhenomenon" maxlength="200" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>

            <tr>
                <td><label for="status">状态</label></td>
                <td>
                    <select id="status" name="status" data-placeholder="选择状态" style="width: 150px;">
                        <option value="0">待处理</option>
                        <option value="1">处理中</option>
                    </select>
                </td>
            </tr>


            <tr>
                <td><label for="dealingPeople">处理人故障</label></td>
                <td>
                    <select   name="dealingPeople" id="dealingPeople" data-placeholder="选择状态" style="width: 150px;" >
<%--                        <option value="">请选择</option>--%>

                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="faultTime">故障出现时间</label></td>
                <td><input type ="date" name="faultTime" id="faultTime" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>


        </table>
    </form>
</div>


<script id="faultListTemplate" type="x-tmpl-mustache">
{{#faultList}}
<tr role="row" class="fault-name odd" data-id="{{id}}"><!--even -->
    <td><a href="#" class="fault-edit" data-id="{{id}}">{{faultTitle}}</a></td>
    <td>{{showRequestType}}</td>
    <td>{{showFaultType}}</td>
    <td>{{faultPhenomenon}}</td>
    <td>{{#bold}}{{showStatus}}{{/bold}}</td>
    <td>{{dealingPeople}}</td>
    <td>{{faultTime}}</td>

    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green fault-edit" href="#" data-id="{{id}}" >
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            <a class="red fault-delete" href="#" data-id="{{id}}" data-name="{{faultTitle}}">
                 <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
        </div>
    </td>
</tr>
{{/faultList}}
</script>


<script type="text/javascript">

    $(function(){

        var faultMap = {}; // 存储map格式故障信息
        var faultListTemplate = $("#faultListTemplate").html();
        Mustache.parse(faultListTemplate);

        loadfaultList();
        // loadSearchName();
        selectionRequestType();

        function selectionRequestType(){
            var url = "/faultUser/selectionRequestType.json";
            $.ajax({
                url: url,
                type: 'GET',
                success: function (result) {
                    $(function(){
                        //页面加载完毕后开始执行的事件
                        var jsonTo = result.data;
                        // var people=eval('('+  jsonTo +')');

                        $("#faultType").change(function(){
                            var now_faultType = $(this).val();
                            $("#dealingPeople").html('<option value="">请选择</option>');
                            for(var k in jsonTo[now_faultType])
                            {
                                var now_people=jsonTo[now_faultType][k];
                                $("#dealingPeople").append('<option value="'+now_people+'">'+now_people+'</option>');
                            }
                        });
                    });

                }
            });
        }



        function loadfaultList(){
            var url = "/fault/faultWriteList.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#faultPage .pageNo").val() || 1;
            $.ajax({
                url: url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                type: 'GET',
                success: function (result) {
                    renderFaultListAndPage(result,url);
                }
            });
        }

        function renderFaultListAndPage(result,url){
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(faultListTemplate, {
                        faultList: result.data.data,
                        "showRequestType": function() {
                            return this.requestType == 1 ? "故障": "业务变动";
                            // return this.type == 1 ? "故障" : (this.type == 2 ? "业务变动" : "未知");
                        },
                        "showFaultType": function() {
                            // return this.faultType == 1 ? "系统": "网络";
                            return this.faultType == 1 ? "系统" : (this.faultType == 2 ? "网络" : "请选择");
                        },
                        "showStatus": function() {
                            switch(this.status){
                                case 1:
                                    //语句
                                    return '处理中'; //可选
                                case 2:
                                    //语句
                                    return  '已处理'; //可选
                                default : //可选
                                    return '待处理'
                            }
                            // return this.status == 1 ? '审批中' : (this.status == 0 ? '审批通过' : '审批不通过');
                        },
                        "bold": function() {
                            return function(text, render) {
                                var status = render(text);
                                if (status == '待处理') {
                                    return "<span class='label label-sm label-info'>待处理</span>";
                                } else if(status == '处理中') {
                                    return "<span class='label label-sm label-success'>处理中</span>";
                                } else {
                                    return "<span class='label  label-success'>已处理</span>";
                                }
                            }
                        }

                    });
                    $("#faultList").html(rendered);

                    bindFaultClick();
                    $.each(result.data.data, function(i, fault) {
                        faultMap[fault.id] = fault;
                    })

                } else {
                    $("#faultList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#faultPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "faultPage", renderFaultListAndPage);
            } else {
                showMessage("获取审批列表", result.msg, false);
            }



        }

        $(".fault-add").on('click',function () {
            $("#dialog-fault-form").dialog({
                model: true,
                title: "故障添加单",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    $("input[type='text']").blur();
                    $("#faultForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateFault(true, function (data) {
                            $("#dialog-fault-form").dialog("close");
                        }, function (data) {
                            showMessage("添加故障单", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-fault-form").dialog("close");
                    }
                }
            })
        });


        function bindFaultClick(){
            $(".fault-edit").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var  faultId = $(this).attr("data-id");
                var  people ;
                $("#dialog-fault-form").dialog({
                    model: true,
                    title: "故障填写单",

                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        $("#faultForm")[0].reset();
                        $("input[type='text']").blur();
                        $("#id").val(faultId);


                        var targetFault = faultMap[faultId];
                        if (targetFault) {
                            $("#faultTitle").val(targetFault.faultTitle);
                            $("#requestType").val(targetFault.requestType);
                            $("#faultType").val(targetFault.faultType);
                            $("#faultPhenomenon").val(targetFault.faultPhenomenon);
                            $("#status").val(targetFault.status);
                            $("#dealingPeople").val(targetFault.dealingPeople);
                            $("#faultTime").val(targetFault.faultTime);

                        }
                        $.ajax({
                            url: '/fault/dealing.json',
                            data: {
                                id: faultId,
                                faultType: targetFault.faultType
                            },
                            type: 'GET',
                            success: function (result) {
                                // $("#dealingPeople").val(result);
                                people = result.data;
                                $("#dealingPeople").empty();//清空下拉框
                                $("#dealingPeople").append('<option value="'+ result.data +'">'+result.data+'</option>');
                                // $("#dealingPeople").empty();//清空下拉框

                            }
                        });


                    },
                    buttons : {
                        "修改": function(e) {
                            e.preventDefault();
                            updateFault(false, function (data) {
                                $("#dialog-fault-form").dialog("close");
                            }, function (data) {
                                showMessage("修改故障单", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-fault-form").dialog("close");
                        }
                    }
                })
            });
            $(".fault-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var faultId = $(this).attr("data-id");
                var title = $(this).attr("data-name");
                if (confirm("确定要删除标题为   ["  + title + "]  的故障吗?")) {
                    $.ajax({
                        url: "/fault/delete.json",
                        data: {
                            id: faultId
                        },
                        type: 'POST',
                        success: function (result) {
                            if (result.ret) {
                                showMessage("确定要删除标题为  [" + title + "] 的故障", "操作成功", true);
                                loadfaultList();
                            } else {
                                showMessage("确定要删除标题为   [" + title + "] 的故障", result.msg, false);
                            }
                        }
                    });
                }
            });


        }



        function updateFault(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/fault/save.json" : "/fault/update.json",
                data: $("#faultForm").serializeArray(),
                type: 'post',
                success: function(result) {
                    if (result.ret) {
                        loadfaultList();
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
