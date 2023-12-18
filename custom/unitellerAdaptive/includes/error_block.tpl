<div id="formErrors" class="error-block mb-2 w-100" {%if empty($aErrors)%}style="display: none"{%/if%}>
    {%if !empty($aErrors)%}
        {%foreach item=item key=key from=$aErrors%}
            {%if is_numeric($key)%}
                <p class="">{%ic%}{%$item%}{%/ic%}</p>
            {%/if%}
        {%/foreach%}
    {%/if%}
</div>