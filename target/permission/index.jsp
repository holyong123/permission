
<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>导出Excel</title>

</head>

<body>

<form id="form_login" action="/test/export.json" method="post">



</form>

<button id="btn-submit" onclick="beforeSubmit()">Submit</button>

<script type="text/javascript">

    var loginForm = document.getElementById('form_login');

    function beforeSubmit() {

        loginForm.submit();

    }

</script>

</body>

</html>
