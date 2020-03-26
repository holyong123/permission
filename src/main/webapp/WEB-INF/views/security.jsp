<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>权限</title>
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


</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>
<div class="page-header">
    <h1>
       权限管理
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            权限管理页面
        </small>
    </h1>
</div>

<div class="main-content-inner">

    <div class="col-sm-9">
        <div class="col-xs-12">
            <div class="table-header">
                用户权限列表&nbsp;&nbsp;
<%--                <a class="green" href="#">--%>
<%--                    <i class="ace-icon fa fa-plus-circle orange bigger-130 security-add"></i>--%>
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
                               用户名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                               所属部门
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                角色名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                拥有权限
                            </th>
<%--                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>--%>
                        </tr>
                        </thead>
                        <tbody id="securityList"></tbody>
                    </table>
                    <div class="row" id="securityPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script id="securityListTemplate" type="x-tmpl-mustache">
{{#securityList}}
<tr role="row" class="security-name odd" data-id="{{id}}"><!--even -->
    <td><a href="#" class="security-edit" data-id="{{id}}">{{username}}</a></td>
    <td>{{deptName}}</td>
    <td>{{roleName}}</td>
    <td>{{aclName}}</td>
</tr>
{{/securityList}}
</script>





<script type="text/javascript">

    $(function(){

        var securityMap = {}; // 存储map格式物品信息
        var securityListTemplate = $("#securityListTemplate").html();
        Mustache.parse(securityListTemplate);

        loadSecurityList();

        function loadSecurityList(){
            var url = "/security/list.json";
            var pageSize = $("#pageSize").val();
            var pageNo = $("#securityPage .pageNo").val() || 1;
            $.ajax({
                url: url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                type: 'GET',
                success: function (result) {
                    renderSecurityListAndPage(result,url);
                }
            });
        }

        function renderSecurityListAndPage(result,url){
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(securityListTemplate, {
                        securityList: result.data.data});
                    $("#securityList").html(rendered);
                    $.each(result.data.data, function(i, security) {
                        securityMap[security.id] = security;
                    })

                } else {
                    $("#securityList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#securityPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "securityPage", renderSecurityListAndPage);
            } else {
                showMessage("权限展示列表", result.msg, false);
            }
        }


    })


</script>
</body>
</html>
