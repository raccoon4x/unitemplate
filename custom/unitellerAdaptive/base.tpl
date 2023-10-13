<!DOCTYPE html>
<html lang="ru">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>{%$title|default:'Страница оплаты'%}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="{%$custom%}/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="{%$custom%}/assets/css/main.css" />
    <style>
        {%if isset($pcwalletsCss) && count($pcwalletsCss) > 0%}
        {%foreach from=$pcwalletsCss item=value key=key%}
        {%eval var=$value%}
        {%/foreach%}
        {%/if%}
    </style>
    {%include file="includes/styles.tpl"%}
    {%$css|default:''%}
    <script type="text/javascript" src="{%$custom%}/assets/js/Acquirer.js"></script>
    <script type="text/javascript" src="{%$custom%}/assets/js/PaymentSystem.js"></script>
    <script type="text/javascript" src="{%$custom%}/assets/js/jquery-3.7.0.min.js"></script>
    <script type="text/javascript" src="{%$custom%}/assets/js/inputmask.js"></script>
    <script type="text/javascript" src="{%$custom%}/assets/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="{%$custom%}/assets/js/main.js"></script>
    {%if isset($pcwalletsJsScripts) && count($pcwalletsJsScripts) > 0 %}
        {%foreach from=$pcwalletsJsScripts item=value key=key %}
            {%foreach from=$value item=val %}
                <script type="text/javascript" src="{%$val%}"></script>
            {%/foreach %}
        {%/foreach %}
    {%/if %}

    {%$js|default:''%}
</head>
<body>
{%$body|default:''%}
{%if isset($pcwalletsJs) && count($pcwalletsJs) > 0 %}
<script type="application/javascript">
    {%foreach from=$pcwalletsJs item=value key=key %}
    {%eval var=$value %}
    {%/foreach %}
</script>
{%/if%}
</body>
</html>