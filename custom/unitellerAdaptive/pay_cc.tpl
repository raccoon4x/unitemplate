{%capture name="title"%}Страница оплаты{%/capture%}

{%capture name="body"%}
{%include file="includes/header.tpl"%}
<div class="content">
    <div class="container">
{%*        {%include file="includes/payment_info.tpl"%}*%}
        <div class="row pb-md-5">
            <div class="col-md-7 mb-md-0 mb-4 pr-lg-6 pl-lg-1 mx-auto">
                {%include file="includes/payment_info.tpl"%}
                <input type="hidden" name="" id="actionURL" value="{%url removeString='procError'%}{%$conf.currentUrl|escape%}{%/url%}" />
                <form method="post" name="payForm" id="payForm" action="{%url removeString='procError'%}{%$conf.currentUrl|escape%}{%/url%}" >
                    <input type="hidden" name="context" value="{%$contextSerialized|escape%}"/>
                    <input type="hidden" name="doPay" value="1"/>
                    <input type="hidden" name="Pan">
                    <input type="hidden" name="ExpMonth">
                    <input type="hidden" name="ExpYear">
                    <input type="hidden" name="Phone" value="{%$context.Phone|default:'0000000'%}" />
                    {%if $showCardholderNameField|default:'1'==='0'%}<input type="hidden" name="CardholderName" value="NONAME"/>{%/if%}
                    {%assign var='random' value=100000|rand:1000000%}
                    <input type="hidden" name="Email" value="{%if $isValidEmail == 1%}{%$context.Email|escape%}{%else%}{%$random%}@address.ru{%/if%}" />
                    <input type="hidden" name="" id="inputBack" value="1">
                    <div class="list-group">
                        <div class="input-container">
                            <input id="Pan" type="tel" required autocomplete="off" alt="Номер карты"/>
                            <label for="Pan">Номер карты</label>
                            <div class="bank-info d-flex">
                                <div id="bank-logo"></div>
                                <div id="paymentSystem" class="payment-systems"></div>
                            </div>
                        </div>
                        {%if $showCardholderNameField|default:'1'==='1'%}
                        <div class="input-container">
                            <input id="CardholderName" type="text" name="CardholderName" required autocomplete="off" alt="Имя держателя карты"/>
                            <label for="CardholderName">Держатель карты</label>
                        </div>
                        {%/if%}
                        <div class="card-expire-cvv w-100 mb-3">
                            <div class="input-container">
                                <input id="ExpDate" type="tel" required autocomplete="off" />
                                <label for="ExpDate">ММ / ГГ</label>
                            </div>
                            <div class="input-container">
                                <input id="Cvc2" type="tel" name="Cvc2" required autocomplete="off" />
                                <label for="Cvc2">CVC/CVV</label>
                                <div class="icon-eye"></div>
                            </div>
                        </div>

                        {%if isset($isCustomer) && $isCustomer%}
                            <div class="checkbox mb-1">
                                <input type="checkbox" id="chSaveCard" name="chSaveCard" value="1" checked="checked">
                                <label class="checkbox" for="chSaveCard"><span>Сохранить данные карты</span></label>
                            </div>
                        {%/if%}

                        {%if $isValidEmail == 0%}
                            <div class="checkbox mb-1">
                                <input type="checkbox" id="EmailCheck" value="1" >
                                <label class="checkbox" for="EmailCheck"><span>Нужен чек</span></label>
                            </div>

                            <div class="input-container mb-3" id="EmailContainer" style="display: none">
                                <input id="Email" type="text" disabled="disabled" autocomplete="off" value=""/>
                                <label for="Email">E-mail</label>
                            </div>
                        {%/if%}

                        {%if $aShop.dest_phone|default:0 && !$isValidDestPhoneNum %}
                            <div class="input-container mb-3" id="DestPhoneNumContainer">
                                <input name="DestPhoneNum" hidden="hidden">
                                <input id="DestPhoneNum" type="tel" autocomplete="off" value="+7" required/>
                                <label for="DestPhoneNum">Номер телефона для пополнения</label>
                            </div>
                        {%/if%}

                        {%if $aShop.quasi_cash|default:0 && !$isValidEWallet %}
                            <div class="input-container mb-3" id="EWalletContainer">
                                <input id="EWallet" type="text" autocomplete="off" value="" name="EWallet" maxlength="30" required/>
                                <label for="EWallet">Номер электронного кошелька</label>
                            </div>
                        {%/if%}

                        {%include file="includes/error_block.tpl"%}

                        <div class="form-group-pay-btn center w-100">
                            <button id="btnPay" type="submit" class="pay-button button">{%$buttonPayText|default:'Оплатить'%} {%$context.Subtotal_P|escape%} ₽</button>
                        </div>
                    </div>
                </form>
            </div>
            {%include file="includes/additional_payment.tpl"%}
        </div>
    </div>
</div>
{%include file="includes/footer.tpl"%}
{%/capture%}

{%capture name="js"%}
<script>
$.extend({
    redirectPost: function(location, args) {
        var form = '';
        $.each( args, function( key, value ) {
        form += '<input type="hidden" name="'+key+'" value="'+value+'">';
        });
        $('<form action="'+location+'" method="POST">'+form+'</form>').appendTo('body').submit();
    }
});

</script>
{%/capture%}

{%assign var="baseFile" value="base.tpl"%}
{%include file=$baseFile
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}