{%capture name="title"%}Авторизация платежа...{%/capture%}

{%capture name="body"%}
<div class="container text-center">
    <div class="block-wait pt-6">
        <img class="loader" src="{%$custom%}/assets/svg/loader.svg" alt="Загрузка..."/>
        <div class="h4 font-weight-normal pt-5">
            <p>Подождите, пожалуйста. <br>
                Идет авторизация Вашего платежа…</p>
        </div>
    </div>
</div>
{%include file="includes/redirect.tpl"%}
{%include file="includes/footer.tpl" footer_type="pay_do"%}
{%/capture%}

{%assign var="baseFile" value="base.tpl"%}
{%include file=$baseFile
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}