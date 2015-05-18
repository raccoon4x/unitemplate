{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $this->assign('template_dir', dirname($file));
{% /php %}

{% capture name="title" %}
    Шаблоны
{% /capture %}

{% capture name="body" %}
<div class="container theme-showcase" role="main">

      <!-- Main jumbotron for a primary marketing message or call to action -->
      <div class="jumbotron">
        <a target="_blank" href="http://uniteller.ru" title="Uniteller" style="float:left;padding:15px 50px 0 0"><img src="/assets/img/logo.png"/></a>
        
        <h2>Шаблоны для точек продажи</h2>
        <label for="upoint">Выберите точку продажи</label> &nbsp;&nbsp;&nbsp;
        <select name="upoint" onchange="javascript:document.getElementById('currentUpoint').innerHTML = document.getElementById('templates_'+this.value).innerHTML;" >
            <option value=""></option>
            {%foreach name=list item=item key=upoint from=$list%}
            <option value="{% $upoint %}">{% $upoint %}</option>
            {%/foreach%}
        </select>
        
      </div>





<div style="display:none">
{%foreach name=list item=item key=upoint from=$list%}
    <div id="templates_{% $upoint %}">
        <div class="page-header">
            <a style="float:right" href="/main/archive/{% $upoint %}">скачать</a>
            <h2>Шаблоны для точки {% $upoint %}</h2>
        </div>
        
        <ul>
            {%foreach name=templates item=data key=path from=$item%}
            <li>
                <a target="_blank" href="{% $path %}{% $upoint %}">{% $data.template %}</a>
                {% if isset($data.cases) && $data.cases %}
                    {%foreach name=case item=case_title key=case from=$data.cases %}
                        &nbsp; | &nbsp; <a target="_blank" href="{% $path %}{% $upoint %}{% $case %}">{% $data.template %} ({% $case_title %})</a>
                    {%/foreach%}
                {% /if %}
            </li>
            
            {%/foreach%}
        </ul>
    </div>
{%/foreach%}
</div>


<div id="currentUpoint">
    
</div>

</div>
{% /capture %}

{% assign var="baseFile" value="$template_dir/base.tpl" %}
{% include file=$baseFile
    title=$smarty.capture.title|default:''
    body=$smarty.capture.body|default:''
%}

