<iframe name="hid" style="display:none;"></iframe>
<form id="frmRedirect" action="{%$url|escape%}" style="display:none;" method="post" {%if ($url eq "/pay/check/" || $url eq "/pay/spasiboerr" || $url eq "/pay/error" || $url eq "/pay" || $url eq "/pay/?procError=1") && isset($context.is3DS) && $context.is3DS eq true %}target="_parent"{%elseif ($url eq "/pay/3ds/" || ($url eq "/pay/do/" && isset($atmacp) && $atmacp eq "termurl")) %}target="hid"{%/if%}>
    <input type="hidden" name="context" value="{%$contextSerialized|escape%}" readonly>
</form>
<script type="text/javascript" src="/js/browserInfo.js"></script>
<script type="text/javascript">
    window.setTimeout(function () {
        {%if $url eq "/pay/3ds/"%}UntlBrowserInfo.setAfterContext();{%/if%}
        document.getElementById("frmRedirect").submit();
    }, 2000);
</script>