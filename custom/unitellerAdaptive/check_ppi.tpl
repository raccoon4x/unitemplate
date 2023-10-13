{%capture name="title"%}Страница оплаты{%/capture%}
{%assign var="order_date_param" value=$response.operDatetime%}
{%php%}
    setlocale(LC_TIME, 'ru_RU.UTF-8');
    $time = $this->get_template_vars('order_date_param');
    $r = $this->get_template_vars('response');
    $order_date = strftime("%Y-%m-%d %H:%M:%S", $time);
    $this->assign('order_date', $order_date);
{%/php%}
{%capture name="body"%}
{%include file="includes/header.tpl"%}
<div class="content">
    <div class="container py-6">
        <div class="row">
            <div class="col-md-7 mb-md-0 mb-4 pr-lg-6 pl-lg-1 text-center text-md-left">
                <div class="list-group">
                    {%if $ppi==17%}
                    <h2 class="mb-1">
                        Ваш платеж через СБП совершен успешно.
                    </h2>
                    <div class="mt-2 d-none d-md-block">
                        Пожалуйста, сохраните указанную информацию о платеже
                    </div>
                    <div class="mt-2 d-md-none">
                        Информация о платеже направлена по указанному адресу электронной почты.
                    </div>
                    {%/if%}
                    <div class="form-group-pay-btn mt-4">
                        {%if isset($context.URL_RETURN_NO) || isset($context.URL_RETURN)%}
                        {%if !isset($preview)%}
                        <form action="{%$conf.currentUrl%}" method="post">
                            {%/if%}
                            <input type="hidden" name="context" value="{%$contextSerialized|escape%}" />
                            <input type="hidden" id="inputBack" name="doReturn" value="1" />
                            <button id="btnPay" type="submit" class="button">Вернуться в магазин</button>
                            {%if !isset($preview)%}
                        </form>
                        {%/if%}
                        {%/if%}
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="list-body">
                    <div class="">
                        {% if !empty($response.brandName) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Название магазина:</div>
                            <div class="ml-auto">{%$response.brandName|default:''%}</div>
                        </div>            
                        {% /if %}                        
                        {% if !empty($response.url  ) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">URL магазина:</div>
                            <div class="ml-auto">{%$response.url|default:''%}</div>
                        </div>
                        {% /if %}
                        {% if !empty($response.email  ) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Контактный адрес:</div>
                            <div class="ml-auto">{%$response.email|default:''%}</div>
                        </div>
                        {% /if %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Номер платежа:</div>
                            <div class="ml-auto">{%$context.Order_IDP%}</div>
                        </div>                        
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Сумма платежа:</div>
                            <div class="ml-auto">{%$context.Subtotal_P|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Наименование Юр.лица:</div>
                            <div class="ml-auto">{%$response.name|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Идентификатор Юр.лица:</div>
                            <div class="ml-auto">{%$response.legalid|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Идентификатор ТСП:</div>
                            <div class="ml-auto">{%$response.merchantid|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Qrc Id:</div>
                            <div class="ml-auto text-break text-right w-75 w-lg-auto">{%$response.qrcid|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Trx Id:</div>
                            <div class="ml-auto text-break text-right w-75 w-lg-auto">{%$response.trxid|default:''%}</div>
                        </div>
                        {% if !empty($kzo) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">КЗО:</div>
                            <div class="ml-auto text-break text-right w-85">{%$response.kzo|default:''%}</div>
                        </div>
                        {% /if %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Тип операции:</div>
                            <div class="ml-auto">Продажа</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="left small">{%$order_date%}</div>
                            <div></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{%include file="includes/footer.tpl"%}
{%/capture%}

{%include file="base.tpl"
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}