{%capture name="css"%}
<style>
html,body {
    height: 100%;
}
body {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
    padding-top: 40px;
    padding-bottom: 40px;
}
</style>
{%/capture%}
{%capture name="body"%}
{%if isset($message)%}
    <!-- MERCHANT ERROR: {%$message%} -->
{%/if%}
<div class="container text-center">
    <div class="block-wait">
        {%if isset($message)%}
        <div class="h2 font-weight-normal">
            <p>При загрузке страницы оплаты произошла ошибка.</p>
        </div>
        <div>
            <p>Попробуйте позже или обратитесь в магазин.</p>
        </div>
        {%/if%}
        {%if isset($context_error_3ds)%}
            <div class="h2 font-weight-normal">
                <p>Банк-эмитент не вернул корректные параметры платежа.</p>
            </div>
            <div>
                <p>Закройте все вкладки с платежными страницами Uniteller и повторите попытку платежа.</p>
            </div>
        {%/if%}
        {%if !empty($aErrors)%}
            {%change_in_array var="aErrors" index=34000000 value=""%}
            <div class="h2 font-weight-normal">
                <p>Ошибка оплаты</p>
            </div>
            {%assign var="hasNumericKeys" value=false%}
            {%foreach item=item key=key from=$aErrors%}
                {%if is_numeric($key)%}
                    {%assign var="hasNumericKeys" value=true%}
                {%/if%}
            {%/foreach%}
            {%if $hasNumericKeys%}
                {%foreach item=item key=key from=$aErrors%}
                    {%if is_numeric($key)%}
                        <div>
                            <p>{%ic%}{%$item%}{%/ic%}</p>
                        </div>
                    {%/if%}
                {%/foreach%}
            {%/if%}
        {%/if%}
    </div>
</div>
{%include file="includes/footer.tpl" footer_type="pay_error"%}
{%/capture%}

{%assign var="baseFile" value="base.tpl"%}
{%include file=$baseFile
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}