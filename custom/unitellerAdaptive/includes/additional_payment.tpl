<!--дополнительные методы оплаты-->
<div id="menu_content" class="col-md-5 p-0" style="display: none">
    <div  class="bg-white p-4 h-100">
        <div class="list-body">
            <div id="menu_title" style="display: none"></div>
            <div class="">
                <ul class="wallets-payment">
                    {%if isset($payment_menu) && !empty($payment_menu)%}
                        {%foreach from=$payment_menu item=value key=key name=foo%}
                            {%if isset($value.lihtml)%}
                                {%$value.lihtml%}
                                <script type="application/javascript">
                                    if(document.getElementById('menu_content').style.display === 'none') {
                                        document.getElementById('menu_content').style.display = '';
                                    }
                                </script>                                
                            {%/if%}
                        {%/foreach%}
                    {%/if%}
                </ul>
                {%if isset($ppi.17) %}
                    <div id="sbpBlock" class="pcw-button" onclick="$.redirectPost('/pay/ppi/sbp/', {context:$('input[name=context]').val()})">
                        <img src="{%$custom%}/assets/svg/sbp-pay.svg" alt="SBP Pay">
                    </div>
                    <script type="application/javascript">
                        if(document.getElementById('menu_content').style.display === 'none') {
                            document.getElementById('menu_content').style.display = '';
                        }
                    </script>
                {%/if%}
            </div>
        </div>
    </div>
</div>