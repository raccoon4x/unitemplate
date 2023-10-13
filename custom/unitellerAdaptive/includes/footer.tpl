{%if isset($footer_type) && $footer_type==='pay_do'%}
<footer class="sticky-footer">
    <div class="container text-center">
        <img src="{%$custom%}/assets/svg/uniteller-logo.svg" width="46" height="31" alt="Uniteller">
    </div>
</footer>
{%elseif isset($footer_type) && $footer_type==='pay_error'%}
<footer class="sticky-footer contact">
    <div class="container text-center">
        <img src="{%$custom%}/assets/svg/uniteller-logo.svg" width="46" height="31" alt="Uniteller">
        <div class="text-break">
            <p class="mt-2 small">
                В случае возникновения вопросов Вы можете обратиться в Службу поддержки компании Uniteller по телефону <a href="tel:{%$defaultSupportPhone%}">{%$defaultSupportPhone%}</a> или электронной почте <a href="mailto:support@uniteller.ru">support@uniteller.ru</a>
            </p>
        </div>
    </div>
</footer>
{%else%}
{%if $showPaymentSystemLogosBlock|default:1 == 1%}
<div class="container">
    <footer class="my-3 d-flex">
        <div class="card-group text-center text-md-left w-100">
            <img class="mr-4" src="{%$custom%}/assets/svg/mir-accept.svg" width="40" height="18" alt="Mir Accept">
            <img class="mr-4" src="{%$custom%}/assets/svg/visa-verified.svg" width="31" height="18" alt="Visa Verified">
            <img class="mr-4" src="{%$custom%}/assets/svg/mastercard-securecode.svg" width="48" height="18" alt="MasterCard Securecode">
            <img class="mr-4" src="{%$custom%}/assets/svg/pci-dss.svg" width="40" height="18" alt="PCI DSS">
            <div class="ml-auto py-2 py-sm-0">
                <img src="{%$custom%}/assets/svg/secured-by-uniteller.svg" width="86" height="14" alt="Secured by Uniteller">
            </div>
        </div>
    </footer>
</div>
{%/if%}
{%/if%}