<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>故障-人员分配名单</title>
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
        人员分配
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            人员分配页面
        </small>
    </h1>
</div>

<div class="main-content-inner">

    <div class="col-sm-12">
        <div class="col-xs-12">
            <div class="table-header">
                人员分配列表&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-plus-circle orange bigger-130 fault-add letter-spacing: -8px"></i>
                </a>
                <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <label>业务系统  </label>
               <select class="faultTypeId" name="faultTypeId" data-placeholder="选择状态"  style="width: 110px;height:24px;vertical-align:middle;padding-top: 0px">
                    <option value="1">系统</option>
                    <option value="2">网络</option>
                </select>
                <label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                <label>用户名  </label>
                <select class="userId" name="userId" id="UserLists" data-placeholder="选择状态" style="width: 110px;height:24px;vertical-align:middle;padding-top: 0px" >
                    <option value="">请选择</option>
                </select>


                <a class="coral" href="#" style="font-size: 10px">
                    <i class="ace-icon fa fa-search white bigger-130 find-search" style="font-size: 15px;color: #0f0f0f;margin-left: 30px">查询</i>
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
                                ID
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                系统类型
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                用户名
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label="">
                                操作
                            </th>
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
            <input type="hidden" name="typeId" id="typeId" />

            <tr>
                <td><label for="faultType">业务系统</label></td>
                <td>
                    <select id="faultType" name="faultTypeId" data-placeholder="选择状态" style="width: 150px;">
                        <option value="1">系统</option>
                        <option value="2">网络</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td><label for="UserList">人员</label></td>
                <td>
                    <select   name="userId" id="UserList" data-placeholder="选择状态" style="width: 150px;" >
                        <option value="">请选择</option>
                    </select>
                </td>
            </tr>

        </table>
    </form>
</div>


<script id="faultListTemplate" type="x-tmpl-mustache">
{{#faultList}}
<tr role="row" class="fault-name odd" data-id="{{typeId}}"><!--even -->
    <td><a href="#" class="fault-edit" data-id="{{typeId}}">{{typeId}}</a></td>
    <td>{{showFaultType}}</td>
    <td>{{username}}</td>

    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="red fault-delete" href="#" data-id="{{typeId}}" data-name="{{faultTypeId}}">
                 <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
        </div>
    </td>
</tr>
{{/faultList}}
</script>



<!-- 下拉框模板 -->
<script  id="templateSelect" type="text/x-template" >
    {{#option}}
    <option value="{{value}}">{{text}}</option>
    {{/option}}
</script>



<script type="text/javascript">

    $(function(){

        var faultMap = {}; // 存储map格式故障信息
        var faultListTemplate = $("#faultListTemplate").html();
        Mustache.parse(faultListTemplate);

        loadfaultList();
        loadSearchName();
        loadRoleUser();

        function loadRoleUser() {
            var url = "/faultUser/roleUser.json";
            $.ajax({
                url: url,
                type: 'GET',
                success: function (result) {
                    if (result.ret) {
                        $("#UserList").empty();
                        var arrList =result.data;
                        $("#UserList").append("<option value=\"\">请选择</option>");
                        $.each(arrList,function(key,value){
                            var sysUser_html = "<option value='" + value.id +"'> "+value.username +"</option>";
                            $("#UserList").append(sysUser_html);
                        });
                    } else {
                        showMessage("加载角色用户数据", result.msg, false);
                    }
                }
            });
        }

        function loadSearchName() {
            var url = "/faultUser/roleUser.json";
            $.ajax({
                url: url,
                type: 'GET',
                success: function (result) {
                    if (result.ret) {
                        $("#UserLists").empty();
                        var arrList =result.data;
                        $("#UserLists").append("<option value=\"\">请选择</option>");
                        $.each(arrList,function(key,value){
                            var sysUser_html = "<option value='" + value.id +"'> "+value.username +"</option>";
                            $("#UserLists").append(sysUser_html);
                        });
                    } else {
                        showMessage("加载角色用户数据", result.msg, false);
                    }
                }
            });
        }


        function loadfaultList(){
            var url = "/faultUser/faultRoleUserAll.json";
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
                        "showFaultType": function() {
                            // return this.faultType == 1 ? "系统": "网络";
                            return this.faultTypeId == 1 ? "系统" : (this.faultTypeId == 2 ? "网络" : "未知");
                        },
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
                showMessage("获取人员列表", result.msg, false);
            }



        }

        $(".fault-add").on('click',function () {
            $("#dialog-fault-form").dialog({
                model: true,
                title: "人员变动单",
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
                            showMessage("添加人员信息", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-fault-form").dialog("close");
                    }
                }
            })
        });


        function bindFaultClick(){
            // $(".fault-edit").click(function (e) {
            //     e.preventDefault();
            //     e.stopPropagation();
            //     var  faultId = $(this).attr("data-id");
            //     $("#dialog-fault-form").dialog({
            //         model: true,
            //         title: "人员变动单",
            //         open: function(event, ui) {
            //             $(".ui-dialog-titlebar-close", $(this).parent()).hide();
            //             $("#faultForm")[0].reset();
            //             $("input[type='text']").blur();
            //             $("#typeId").val(faultId);
            //             var targetFault = faultMap[faultId];
            //             if (targetFault) {
            //                 // $("#id").val(targetFault.typeId);
            //                 $("#faultType").val(targetFault.faultTypeId);
            //                 $("#UserList").val(targetFault.userId);
            //             }
            //         },
            //         buttons : {
            //             "修改": function(e) {
            //                 e.preventDefault();
            //                 updateFault(false, function (data) {
            //                     $("#dialog-fault-form").dialog("close");
            //                 }, function (data) {
            //                     showMessage("修改人员信息", data.msg, false);
            //                 })
            //             },
            //             "取消": function () {
            //                 $("#dialog-fault-form").dialog("close");
            //             }
            //         }
            //     })
            // });

            $(".fault-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var typeId = $(this).attr("data-id");
                if (confirm("确定要删除吗?")) {
                    $.ajax({
                        url: "/faultUser/delete.json",
                        data: {
                            id: typeId
                        },
                        type: 'POST',
                        success: function (result) {
                            if (result.ret) {
                                showMessage("确认删除", "操作成功", true);
                                loadfaultList();
                            } else {
                                showMessage("确认删除", result.msg, false);
                            }
                        }
                    });
                }
            });

        }



        function updateFault(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/faultUser/saveFaultType.json" : "/faultUser/update.json",
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

        $(".find-search").click(function(){
            var data ={};
            var url = "/faultUser/faultRoleUserCondition.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#approvalPage .pageNo").val() || 1;
            data.pageSize = pageSize;
            data.pageNo = pageNo;

            var userId =  $(".userId").val();
            if(userId!="" && userId !=undefined){
                data.userId = userId;
            }
            var faultTypeId = $(".faultTypeId").val();
            if(faultTypeId!="" && faultTypeId !=undefined && faultTypeId != "-1"){
                data.faultTypeId = faultTypeId;
            }
            $.ajax({
                url: url,
                data: data,
                type: 'GET',
                success: function (result) {
                    renderFaultListAndPage(result,url);
                }
            });
        })




    })
</script>
</body>
</html>
