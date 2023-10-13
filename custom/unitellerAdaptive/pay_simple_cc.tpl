{%capture name="title"%}Страница оплаты{%/capture%}
{%capture name="body"%}
{%include file="includes/header.tpl"%}

<div class="content">
    <div class="container">
{%*        {%include file="includes/payment_info.tpl"%}*%}
        <div class="row pb-md-5">
            <div class="col-md-7 mb-md-0 mb-4 pr-lg-6 pl-lg-1 mx-auto">
                {%include file="includes/payment_info.tpl"%}
                <div id="SavedCards" class="saved-cards mt-8 mb-8">
                    {%foreach from=$aRegisteredCards item="card"%}
                        <div id="{%$card.cid%}" class="saved-card choose-card bg-white p-3 my-2 d-flex">
                            <input type="hidden" id="cid{%$card.cid%}" value="{%$card.card_number|replace:'*':'•'%}">
                            <div id="logo-bank-cid{%$card.cid%}" class="ml-2 bank-logo"></div>
                            <div class="ml-auto" >
                                <div class="d-inline mr-3 saved-card-number">••• {%$card.card_number|substr:-4%}</div>
                                <div class="d-inline-block mr-3 saved-card-system {%$card.card_type|lower%}"></div>
                                <div class="d-inline delete-saved-card" data-card-id="{%$card.cid%}" role="button"><img src="{%$custom%}/assets/svg/remove.svg" alt="Удалить карту"></div>
                            </div>
                        </div>
                    {%/foreach%}
                    <div id="NewCard" class="saved-card bg-white p-3 my-2 d-flex">
                        <div class="">Оплата новой картой</div>
                        <div class="add-new-card ml-auto" role="button">
                            <img src="{%$custom%}/assets/svg/plus.svg" alt="">
                        </div>
                    </div>

                    {%include file="includes/error_block.tpl"%}
                </div>

                <form method="post" name="payForm" id="payForm" action="{%url removeString='procError'%}{%$conf.currentUrl|escape%}{%/url%}" style="display: none">
                    <input type="hidden" name="context" value="{%$contextSerialized|escape%}"/>
                    <input type="hidden" name="doPay" value="1"/>
                    <input type="hidden" name="Pan">
                    <input type="hidden" name="ExpMonth">
                    <input type="hidden" name="ExpYear">
                    <input type="hidden" name="cid" id="cid" disabled="disabled">
                    <input type="hidden" name="Phone" value="{%$context.Phone|default:'0000000'%}" />
                    {%if $showCardholderNameField|default:'1'==='0'%}<input type="hidden" name="CardholderName" value="NONAME"/>{%/if%}
                    {%assign var='random' value=100000|rand:1000000%}
                    <input type="hidden" name="Email" value="{%if $showEmailField|default:'1'==='0' || $isValidEmail == 1%}{%$context.Email|escape%}{%else%}{%$random%}@address.ru{%/if%}" />
                    <input type="hidden" name="" id="inputBack" value="1">
                    <input type="hidden" name="" id="deleteCard" value="1"/>
                    <div class="list-group">
                        <div class="input-container">
                            <input id="Pan" type="tel" required autocomplete="off" alt="Номер карты"/>
                            <label for="Pan">Номер карты</label>
                            <div class="bank-info d-flex">
                                <div id="bank-logo"></div>
                                <div id="paymentSystem" class="payment-systems"></div>
                            </div>
                        </div>
                        <div class="input-container" style="display:none">
                            <input id="SavedPan" type="text" value="" readonly alt="Номер карты"/>
                            <label for="SavedPan">Номер карты</label>
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
                            <div class="input-container" style="display: none">
                                <input id="SavedExpDate" type="text" readonly value="**/**"/>
                                <label for="SavedExpDate">ММ / ГГ</label>
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

                        {%if $showEmailField|default:'1'==='1' && $isValidEmail == 0%}
                            <div class="checkbox mb-1">
                                <input type="checkbox" id="EmailCheck" name="" value="1" >
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


<div class="modal fade" id="modalDeleteCard">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                  <span class="custom-close-icon">
                     <img src="{%$custom%}/assets/svg/close.svg" alt="Закрыть">
                  </span>
                </button>
            </div>

            <div class="modal-body text-center">
                <h5>Точно удалить карту?</h5>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn button" data-dismiss="modal">Нет</button>
                <button type="button" class="btn button" data-dismiss="modal" onclick="deleteCard()">Да</button>
            </div>

        </div>
    </div>
</div>
{%include file="includes/footer.tpl"%}
{%/capture%}

{%capture name="js"%}
<script type="application/javascript">
document.addEventListener("DOMContentLoaded", function() {
    if(document.getElementById('NewCard')!==null){
        document.getElementById('NewCard').addEventListener('click', function (){
            document.getElementById('SavedCards').style.display = 'none';
            document.getElementById('payForm').style.display = 'block';
        });
    }

    if (document.querySelectorAll('.choose-card').length>0) {
        document.querySelectorAll('.choose-card').forEach(item => {
            item.addEventListener('click', function (e) {
                chooseCard(item.id);
            });
        });
    }

    document.querySelectorAll('.choose-card').forEach(item => {
        var bin = document.querySelector('#cid'+item.id).value.substr(0, 6);
        Acquirer.getBankByBin(bin, $('#logo-bank-cid'+item.id),$('#logo-bank-cid'+item.id),$('#logo-bank-cid'+item.id));
    });
});


function chooseCard(id)
{
    document.getElementById('SavedCards').style.display = 'none';
    document.getElementById('payForm').style.display = 'block';
    document.querySelector('input[name=Pan]').setAttribute('disabled', 'disabled');
    document.getElementById('Pan').parentElement.style.display = 'none';
    document.getElementById('Pan').setAttribute('disabled', 'disabled');
    document.getElementById('SavedPan').parentElement.style.display = 'block';
    document.getElementById('SavedPan').removeAttribute('disabled');
    document.getElementById('CardholderName').parentElement.style.display = 'none';
    document.getElementById('CardholderName').setAttribute('disabled', 'disabled');
    document.querySelector('input[name=ExpMonth]').setAttribute('disabled', 'disabled');
    document.querySelector('input[name=ExpYear]').setAttribute('disabled', 'disabled');
    document.getElementById('ExpDate').parentElement.style.display = 'none';
    document.getElementById('ExpDate').setAttribute('disabled', 'disabled');
    document.getElementById('SavedExpDate').parentElement.style.display = 'block';
    document.getElementById('SavedExpDate').removeAttribute('disabled');

    document.getElementById('cid').value = id;
    document.getElementById('cid').removeAttribute('disabled');
    document.getElementById('SavedPan').value = document.getElementById('cid' + id).value;

    document.getElementById('chSaveCard').setAttribute('disabled', 'disabled');
    document.getElementById('chSaveCard').parentElement.style.display = 'none';
}
</script>
{%/capture%}
{%assign var="baseFile" value="base.tpl"%}
{%include file=$baseFile
title=$smarty.capture.title|default:''
css=$smarty.capture.css|default:''
js=$smarty.capture.js|default:''
body=$smarty.capture.body|default:''
%}