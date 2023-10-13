{%capture name="title"%}Страница статуса платежа СБП{%/capture%}

{%capture name="body"%}
{%include file="includes/header.tpl"%}
{%*<div class="container text-center">*%}
{%*    <div id="myloader" class="block-wait pt-6">*%}
{%*        <img class="loader" src="{%$custom%}/assets/svg/loader.svg" alt="Загрузка..."/>*%}
{%*        <div class="h4 font-weight-normal pt-5">*%}
{%*            <p>Подождите, пожалуйста. <br>*%}
{%*                Уточняем состояние платежа…</p>*%}
{%*        </div>*%}
{%*        <form action="{%$conf.currentUrl%}" method="post">*%}
{%*            <input type="hidden" name="context" value="{%$contextSerialized|escape%}" />*%}
{%*        </form>*%}
{%*    </div>*%}
{%*    <div class="e-payment-details"></div>*%}
{%*</div>*%}

<div class="content">
    <div class="container py-6">
        <div class="row">
            <div class="col-md-7 mb-md-0 mb-4 pr-lg-6 pl-lg-1 text-center text-md-left">
                <div class="list-group text-center">
                    <div id="myloader" class="block-wait">
                        <img class="loader" src="{%$custom%}/assets/svg/loader.svg" alt="Загрузка..."/>
                        <div class="h4 font-weight-normal pt-5 infotext">
                            <p>Подождите, пожалуйста. <br>
                                Уточняем состояние платежа…</p>
                        </div>
                        <form action="{%$conf.currentUrl%}" method="post">
                            <input type="hidden" name="context" value="{%$contextSerialized|escape%}" />
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="list-body">
                    <div class="">
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Название магазина:</div>
                            <div class="ml-auto">{%$brandName|default:''%}</div>
                        </div>
                        {% if !empty($sbpUrl) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">URL магазина:</div>
                            <div class="ml-auto">{%$sbpUrl|default:''%}</div>
                        </div>
                        {% /if %}
                        {% if !empty($sbpEmail) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Контактный адрес:</div>
                            <div class="ml-auto">{%$sbpEmail|default:''%}</div>
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
                            <div class="ml-auto">{%$sbpName|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Идентификатор Юр.лица:</div>
                            <div class="ml-auto">{%$legalid|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Идентификатор ТСП:</div>
                            <div class="ml-auto">{%$merchantid|default:''%}</div>
                        </div>
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Qrc Id:</div>
                            <div class="ml-auto text-break text-right w-75 w-lg-auto">{%$qrcid|default:''%}</div>
                        </div>
                        {% if !empty($trxid) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">Trx Id:</div>
                            <div class="ml-auto text-break text-right w-75 w-lg-auto">{%$trxid|default:''%}</div>
                        </div>
                        {% /if %}
                        {% if !empty($kzo) %}
                        <div class="check-label row px-4 py-3">
                            <div class="font-weight-bold">КЗО:</div>
                            <div class="ml-auto text-break text-right w-85">{%$kzo|default:''%}</div>
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
<form method="post" name="payForm" id="payForm" action="/payInternal" >
    <input type="hidden" name="context" value="{%$contextSerialized|escape%}"/>
    <input type="hidden" name="" id="inputBack" value="1">
</form>
{%include file="includes/footer.tpl"%}

<script type="application/javascript">
$.extend(
{
    redirectPost: function(location, args)
    {
        var form = '';
        $.each( args, function( key, value ) {
            form += '<input type="hidden" name="'+key+'" value="'+value+'">';
        });
        $('<form action="'+location+'" method="POST">'+form+'</form>').appendTo('body').submit();
    }
});

$(function(){
    var repeats = 100;
    var timerId = setTimeout(function tick() {
        $.ajax({
            type: "POST",
            url: "/ppi/action",
            data: {
                context     : $("input[name=context]").val(),
                paymentType : 17,
                actionMethod : "getPaymentStatus",
                actionData : JSON.stringify({operationId:{% $operationId %}, operationCoreId:{% $operationCoreId %}})
            }
        }).done(function(responseJson){
            console.log(responseJson);
            var resp = JSON.parse(responseJson);

            if(
            undefined != resp.Result && resp.Result==0 &&
            undefined != resp.return.status && (resp.return.status==3 || resp.return.status==2 || resp.return.status==7) && resp.return.own==true) {

                var params = {
                    ppi: 17,
                    context: $("input[name=context]").val(),
                    actionData : JSON.stringify({operationId:{% $operationId %}, operationCoreId: {% $operationCoreId %}}).replace(/\"/g, '&quot;')
                }
                $.redirectPost("/check", params);
            } else if(resp.return.ppiData.status == 2) {
                clearTimeout(timerId);
                var str = '<p>Оплата СБП завершена ошибкой: </p><p class="h3 ppiErrorText"">'+resp.return.ppiData.message+' <p>';
                    $(".loader").remove();
                    $('.infotext').html(str);
                    return ;
            }

            repeats--;
            if(repeats) {
                timerId = setTimeout(tick, 5000); // (*)
            } else {
                clearTimeout(timerId);
                $(".loader").remove();
                var str = 'Не удалось уточнить состояние платежа';
                $('.infotext').html(str);
            }
        }).fail(function() {
            repeats--;
            if(repeats) {
                timerId = setTimeout(tick, 5000); // (*)
            } else {
                    $(".loader").remove();
                            clearTimeout(timerId);
                            var str = 'Не удалось уточнить состояние платежа';
                    $('.infotext').html(str);
            }
        }); //done&error
    }, 5000); //set timeout
})
</script>
{%/capture%}
{%include file="base.tpl"
    title=$smarty.capture.title|default:''
    js=$smarty.capture.js|default:''
    body=$smarty.capture.body|default:''
%}
