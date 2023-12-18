{%capture name="title"%}Страница оплаты{%/capture%}

{%capture name="body"%}
{%include file="includes/header.tpl"%}
<div class="content">
    <div class="container">
{%*        {%include file="includes/payment_info.tpl"%}*%}
        <div class="row pb-md-5">
            <div class="col-md-8 mb-md-0 mb-4 pr-lg-6 pl-lg-1 mx-auto">
                {%include file="includes/payment_info.tpl"%}
                {%if $ppikey===17%}
                <div class="bg-white card-group rounded p-3">
                    <!-- QR Code -->
                    {%* TODO: Динамический фон можно попробовать через canvas
                    https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Manipulating_video_using_canvas
                    *%}
                    <div id="qr-img" class="col-12 col-sm-6" style="display: none">
                        {%if isset($item.qrdata.payload)%}
                            <input id="sbpUrl" type="hidden" value="{%$item.qrdata.payload%}">
                        <span><a href="{%$item.qrdata.payload%}">{%generate_qr_code data=$item.qrdata.payload ecc="L" size="4" frame="2"%}</a></span>
                        {%/if%}
                    </div>
                    <div id="desktop-info" style="display: none" class="qr-caption col-12 col-sm-6">
                        <span class="h6">Оплата через Систему Быстрых Платежей</span>
                        <div >
                            <ol>
                                <li>Наведите камеру смартфона на QR-код</li>
                                <li>Нажмите на появившуюся ссылку</li>
                                <li>Откроется приложение вашего банка - войдите и подтвердите оплату</li>
                            </ol>
                        </div>
                    </div>
                    <div id="mobile-info" class="col-12" style="display: none">
                        <span class="h6">Оплата через Систему Быстрых Платежей</span>
                        <ol>
                            <li>Нажмите кнопку «Оплатить СБП»</li>
                            <li>Откроется приложение вашего банка</li>
                            <li>Войдите в него и подтвердите оплату</li>
                        </ol>
                    </div>
                    <div class="d-flex justify-content-center col-12">
                        <div id="ttimer"><span>До конца действия QR-кода осталось</span>:
                      <div class="timer">
                        <div class="timer__items">
                          <div class="timer__item timer__days">00</div>
                          <div class="timer__item timer__hours">00</div>
                          <div class="timer__item timer__minutes">00</div>
                          <div class="timer__item timer__seconds">00</div>
                        </div>
                      </div>
                    </div>
                </div>
                </div>
                {%/if%}

                {%include file="includes/error_block.tpl"%}

                {%if $ppikey===17%}
                    {%assign var="ppiId" value="ppi"|cat:$ppikey%}
                    <div id="qr-button" class="form-group-pay-btn center mt-4" style="display: none">
                        {%if isset($item.qrdata.payload)%}
                        <a class="pay-button button" target="_blank" href="{%$item.qrdata.payload%}">
                            <div class="text-button">
                                Оплатить <img class="ml-2" src="{%$custom%}/assets/svg/sbp-pay.svg" alt="SBP Pay">
                            </div>
                        </a>
                        {%/if%}

                    </div>
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
                        function {%$ppiId%}init() {
                            if( /Android|webOS|iPhone|iPad|iPod|Opera Mini/i.test(navigator.userAgent) ) {
                                $("#qr-button").show();
                                $("#qr-img").hide();
                                $("#mobile-info").show();
                                $("#desktop-info").hide();
                                $("#ttimer span").first().text($("#ttimer span").first().text().replace("QR-кода", "ссылки на оплату"))
                            } else {
                                $("#qr-img").show();
                                $("#qr-button").hide();
                                $("#mobile-info").hide();
                                $("#desktop-info").show();
                                $("#ttimer span").first().text($("#ttimer span").first().text().replace("ссылки на оплату", "QR-кода"))
                            }
                        
                            var repeats = 200;
                            var timerId = setTimeout(function tick() {
                                $.ajax({
                                    type: "POST",
                                    url: "/ppi/action",
                                    data: {
                                        context     : $("input[name=context]").val(),
                                        paymentType : 17,
                                        actionMethod : "getPaymentStatus",
                                        actionData : JSON.stringify({operationId:{% $item.ppiOperationId %}, operationCoreId:{% $item.ppiOperationCoreId %}})
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
                                            actionData : JSON.stringify({operationId:{% $item.ppiOperationId %}, operationCoreId: {% $item.ppiOperationCoreId %}}).replace(/\"/g, '&quot;')
                                        }
                                        $.redirectPost("/check", params);
                                    } else if(resp.return.ppiData.status == 2) {
                                        clearTimeout(timerId);
                                        var str = '<div class="h4 font-weight-normal pt-3 infotext"><p>Оплата СБП завершена ошибкой: </p><p class="h3 ppiErrorText">'+resp.return.ppiData.message+'</p><p></p></div>';
                                        $(".card-group").eq(1).removeClass("bg-white")
                                        $(".card-group").eq(1).html(str)
                                        $("#qr-button").hide();
                                    }

                                    //repeats--;
                                    if(repeats) {
                                        timerId = setTimeout(tick, 5000); // (*)
                                    } else {
                                        clearTimeout(timerId);
                                        var str = '<div class="h4 font-weight-normal pt-3 infotext"><p class="h3 ppiErrorText">Не удалось узнать статус оплаты СБП</p><p></p></div>';
                                        $(".card-group").eq(1).removeClass("bg-white")
                                        $(".card-group").eq(1).html(str)
                                        $("#qr-button").hide();
                                        return;
                                    }
                                });
                            }, 5000); //set timeout                        
                        }
                        $(document).ready(function() {
                            {%$ppiId%}init();
                        });
                        document.addEventListener('DOMContentLoaded', function () {
                          // конечная дата
                          var deadline = (new Date('{% $item.qrdata.staleTime %}'));
                          var nnow = (new Date('{% $smarty.now|date_format:"%Y-%m-%d %H:%M:%S"%}'));
                          // id таймера
                          var ttimerId = null;
                          // склонение числительных
                          function declensionNum(num, words) {
                            return words[(num % 100 > 4 && num % 100 < 20) ? 2 : [2, 0, 1, 1, 1, 2][(num % 10 < 5) ? num % 10 : 5]];
                          }
                          // вычисляем разницу дат и устанавливаем оставшееся времени в качестве содержимого элементов
                          function countdownTimer() {
                            
                            const diff = deadline - nnow;
                            if (diff <= 0) {
                                clearTimeout(ttimerId);
                                var str = '<div class="h4 font-weight-normal pt-3 infotext" style="display:block;width:100%;text-align:center;"><p class="h3 ppiErrorText">QR-код устарел</p><div class="d-flex justify-content-center col-12"><a id="genqr" class="pay-button button" style="height:auto;width:300px;">Запросить новый QR-код</a></div></div>';
                                $(".card-group").eq(1).removeClass("bg-white")
                                $(".card-group").eq(1).html(str)
                                $("#genqr").click(function(){
                                  var params = {
                                    context: $("input[name=context]").val()
                                  }
                                  $.redirectPost("/pay/ppi/sbp/", params);                                
                                })                                
                                $("#qr-button").hide();
                                return;                              
                            }
                            nnow.setSeconds(nnow.getSeconds()+1)
                            
                            const days = diff > 0 ? Math.floor(diff / 1000 / 60 / 60 / 24) : 0;
                            const hours = diff > 0 ? Math.floor(diff / 1000 / 60 / 60) % 24 : 0;
                            const minutes = diff > 0 ? Math.floor(diff / 1000 / 60) % 60 : 0;
                            const seconds = diff > 0 ? Math.floor(diff / 1000) % 60 : 0;
                            $days.textContent = days < 10 ? '0' + days : days;
                            $hours.textContent = hours < 10 ? '0' + hours : hours;
                            $minutes.textContent = minutes < 10 ? '0' + minutes : minutes;
                            $seconds.textContent = seconds < 10 ? '0' + seconds : seconds;
                            $days.dataset.title = declensionNum(days, ['день', 'дня', 'дней']);
                            $hours.dataset.title = declensionNum(hours, ['час', 'часа', 'часов']);
                            $minutes.dataset.title = declensionNum(minutes, ['минута', 'минуты', 'минут']);
                            $seconds.dataset.title = declensionNum(seconds, ['секунда', 'секунды', 'секунд']);
                          }
                          // получаем элементы, содержащие компоненты даты
                          const $days = document.querySelector('.timer__days');
                          const $hours = document.querySelector('.timer__hours');
                          const $minutes = document.querySelector('.timer__minutes');
                          const $seconds = document.querySelector('.timer__seconds');
                          // вызываем функцию countdownTimer
                          countdownTimer();
                          // вызываем функцию countdownTimer каждую секунду
                          ttimerId = setInterval(countdownTimer, 1000);
                        });
                    </script>
                {%/if%}
            </div>
        </div>
    </div>
</div>
<form method="post" name="payForm" id="payForm" action="/payInternal" >
    <input type="hidden" name="context" value="{%$contextSerialized|escape%}"/>
    <input type="hidden" name="" id="inputBack" value="1">
</form>
{%include file="includes/footer.tpl"%}
{%/capture%}

{%include file="base.tpl"
    title=$smarty.capture.title|default:''
    js=$smarty.capture.js|default:''
    body=$smarty.capture.body|default:''
%}
