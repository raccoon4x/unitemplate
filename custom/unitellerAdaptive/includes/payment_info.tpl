{%*<div class="row">*%}
{%*    <div class="d-flex col-md-7 pl-lg-1 pr-lg-6">*%}
        <div class="card-group w-100 pb-4 pt-5">
            <h5 class="order-idp {%if $hideOrderIDP|default:'0'==='1'%}d-none{%/if%}">Заказ № {%$context.Order_IDP|escape%}</h5>
            <h5 class="{%if $hideOrderIDP|default:'0'==='0'%}d-none{%else%}d-flex align-items-end{%/if%}">Сумма заказа:</h5>
            <h3 class="ml-sm-auto">{%$context.Subtotal_P|escape%} <span class="rouble">₽</span></h3>
        </div>
{%*    </div>*%}
{%*</div>*%}