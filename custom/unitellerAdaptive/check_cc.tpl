{%capture name="title"%}Страница оплаты{%/capture%}
{%assign var="order_date_param" value=$aOrder.made_at%}
{%php%}
setlocale(LC_TIME, 'ru_RU.UTF-8');
$time = strtotime($this->get_template_vars('order_date_param'));
$order_date = strftime("%Y-%m-%d %H:%M:%S", $time);
$this->assign('order_date', $order_date);
{%/php%}
{%capture name="body"%}
{%include file="includes/header.tpl"%}
<div class="content">
    <div class="container py-6">
        <div class="row py-6">
            <div class="col-md-7 mb-md-0 mb-4 pr-lg-6 pl-lg-1 text-center text-md-left">
                <div class="list-group">
                    <h2 class="mb-1">
                        Ваш платеж банковской картой совершен успешно.
                    </h2>
                    <div class="mt-2 d-none d-md-block">
                        Пожалуйста, сохраните указанную информацию о платеже
                    </div>
                    <div class="mt-2 d-md-none">
                        Информация о платеже направлена по указанному адресу электронной почты.
                    </div>
                    <div class="form-group-pay-btn mt-4">
                        {%if !isset($preview)%}
                        <form action="{%$conf.currentUrl%}" method="post">
                            {%/if%}
                            <input type="hidden" name="context" value="{%$contextSerialized|escape%}" />
                            <input type="hidden" id="inputBack" name="doReturn" value="1" />
                            <button id="btnPay" type="submit" class="button">Вернуться в магазин</button>
                            {%if !isset($preview)%}
                        </form>
                        {%/if%}
                    </div>
                </div>
            </div>
            <div class="col-md-5 d-none d-md-block">
                <div class="list-body">
                    <div class="">
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Номер платежа:</div>
                            <div class="ml-auto text-break">{%$context.Order_IDP%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Сумма операции:</div>
                            <div class="ml-auto">{%$context.Subtotal_P%} ₽</div>
                        </div>
                        {%if $showCardholderNameField|default:1 == 1%}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Покупатель:</div>
                            <div class="text-uppercase ml-auto">{%$CardholderName%}</div>
                        </div>
                        {%/if%}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Номер карты:</div>
                            <div class="ml-auto">{%$aOrder.card_number%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Код авторизации:</div>
                            <div class="ml-auto">{%$aOrder.approval_code%}</div>
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
{%assign var="baseFile" value="base.tpl"%}
{%include file=$baseFile
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}