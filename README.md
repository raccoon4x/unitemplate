# Unitemplate - среда дл€ разработки шаблонов

ѕозвол€ет разрабатывать шаблоны

### ”становка

Ќеобходимые требовани€:
* php >= 5.4
* git ([установка](http://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git))

#### Ўаги по установке

 1. —качать данное приложение
 ```sh
 $ git clone [git-repo-url]
 $ cd unitemplate
 ```
 где [git-repo-url] - текущий url репозитори€

 2. ¬ыполнить загрузку модулей
 ```sh
 $ php composer.phar install --no-dev
 ```
 
 3. ѕри необходимости поставить права на запись дл€ папки
 ```sh
 $ chmod -R 777 app/lib/tpl/tpl_compiled/
 ```

 4. «апустить приложение
 ```sh
 $ php -S localhost:8008
 ```
 
 5. ќткрыть приложение в браузере [http://localhost:8008](http://localhost:8008)

### »спользование

ѕосле загрузки приложени€ у вас будет пример страниц шаблона. ¬ыберите точку продажи **mobile** и перед вами откроетс€ список страниц шаблона:

 * pay_cc.tpl - страница оплаты
 * pay_do.tpl - страница ожидани€
 * pay_error.tpl - страница ошибки
 * check_cc.tpl - страница чека
 * check_error.tpl - страница ошибки чека
 * pay_one_cc.tpl - страница оплаты созраненной картой
 * pay_simple_cc.tpl -упрощенна€ страница оплаты
 * base.tpl - layout дл€ шаблонов

„тобы начать разрабатывать шаблон, создайте директорию в папке **/custom/** (можно скопировать файлы из папки **mobile**). ¬се файлы дл€ вашего шаблона должны лежать внутри созданной директории, при этом статические файлы по возможности необходимо размещать в папках
 * css
 * img
 * js

‘айлы шаблонов *.tpl должны лежать в корне созданной вами папки

ѕри обращении к статическим файлам, необходимо определить абсолютный путь:

```tpl
{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $path = explode("/",dirname($file));
    $this->assign('custom', '/custom/'.end($path)); // определение абсолютного пути
{% /php %} 
```

после чего его можно использовать

```tpl
<link rel="stylesheet" href="{% $custom %}/css/style.css">
<script type="text/javascript" src="{% $custom %}/js/jquery-1.8.3.min.js"></script>
```

где {% $custom %} - абсолютный путь к папке с вашими шаблонами

**¬ажно!** Ќа страницах шаблона есть переменные которые нужно всегда определ€ть

```tpl
{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $this->assign('template_dir', dirname($file));
{% /php %} 
```

«десь
 * file - переменна€, в которой хранитс€ путь к файлу шаблона, используетс€ дл€ манипул€ции с путем к файлу
 * template_dir - переменна€, к которой хранитс€ директори€ шаблона

**template_dir** используетс€ дл€ подгрузки layout файла

```tpl
{% assign var="baseFile" value="$template_dir/base.tpl" %}
{% include file=$baseFile
    title=$smarty.capture.title|default:''
    css=$smarty.capture.css|default:''
    body=$smarty.capture.body|default:''
%}
```

