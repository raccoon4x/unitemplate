<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>{% $title|default:'' %}</title>
    
    <link rel="stylesheet" href="/assets/css/main.css">
    <script type="text/javascript" src="/assets/js/jquery-3.7.0.min.js"></script>
    <link rel="stylesheet" href="/assets/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="/assets/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="/assets/js/bootstrap.min.js"></script>
    
    
    {% $css|default:'' %}
    {% $js|default:'' %}
    
</head>
<body>
{% $body|default:'' %}
</body>
</html>