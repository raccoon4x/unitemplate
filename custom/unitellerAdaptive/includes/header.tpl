{%if $showHeaderBlock|default:1==1%}
<div class="container pr-0">
    <div class="d-flex flex-md-row p-0 my-2 bg-white">
        <nav class="navbar navbar-light p-0">
            <div class="navbar-brand">
                {%if isset($context.URL_RETURN_NO) || isset($context.URL_RETURN)%}
                <img id="returnBtn" role="button" src="{%$custom%}/assets/svg/arrow-back.svg" class="d-lg-inline-block align-top d-none" alt="Назад">
                {%/if%}
                {%if $merchantLogo|default:'' !==""%}
                    <img src="{%$customImagePath%}/{%$merchantLogo|default:''%}" class="d-inline-block align-top" style="max-height: 35px"  alt="">
                {%/if%}
                <h6 class="d-inline-block my-0 mr-md-auto font-weight-normal">{%$merchantName|default:''%}</h6>
            </div>
        </nav>
        <div class="navbar ml-auto">
            <img src="{%$custom%}/assets/svg/uniteller-logo.svg" width="46" height="31" alt="Uniteller">
        </div>
    </div>
</div>
{%/if%}