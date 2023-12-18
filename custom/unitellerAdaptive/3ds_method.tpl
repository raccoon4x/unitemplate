<html>
    <head></head>
    <body>
        {% if isset($urlServer) %}
        <iframe name="hid3dsServer" style="display:none;"></iframe>
        <form id='frmRedirectServer' action='{%$urlServer%}' method='post' target="hid3dsServer">
        </form>
        {% /if %}
        {% if $url %}
        <iframe name="hid3ds" style="display:none;"></iframe>
        <form id='frmRedirect' action='{%$url%}' method='post' name='form' target="hid3ds">
            <input type='hidden' name='threeDSMethodData' value='{%$req%}'>
        </form>
        {% /if %}
        <script type="text/javascript" src="/js/browserInfo.js"></script>
            <form id="frmRedirect2" action="{% $url2|escape %}" method="post">
                <input type="hidden" name="threeDSServerTransID" value="{% $threeDSServerTransID|escape %}" readonly>
                <input type="hidden" name="threeDSServerTransStatus" id="threeDSServerTransStatus" value="N">
                <input type='hidden' name='threeDSMethodDataAcs' id='threeDSMethodDataAcs'>
                <input type="hidden" name="context" value="{% $contextSerialized|escape %}" readonly>
            </form>
        <script type="text/javascript">
            UntlBrowserInfo.setAfterContext();
            {% if isset($urlServer) %}
            document.getElementById('frmRedirectServer').submit();
            {% /if %}
            {% if $url %}
            document.getElementById('frmRedirect').submit();
            {% /if %}
            function dosubmit() {
              document.getElementById("frmRedirect2").submit();
            }

            setTimeout(dosubmit, {% $timeout %});
        </script>            
    </body>
</html>