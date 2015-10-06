# Unitemplate - среда для разработки шаблонов

Позволяет разрабатывать шаблоны

### Установка

Необходимые требования:
* php >= 5.4
* git ([установка](http://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git))

#### Шаги по установке
  * [Linux/mac](#linux-mac)
  * [Windows](#windows)
  
### Linux/mac
 1. Скачать данное приложение
 ```sh
 $ git clone https://github.com/uniteller/unitemplate
 $ cd unitemplate
 ```

 2. Выполнить загрузку модулей
 ```sh
 $ php composer.phar install --no-dev
 ```
 
 3. Поставить права на запись для папки
 ```sh
 $ chmod -R 777 app/lib/tpl/tpl_compiled/
 ```

 4. Запустить сервер приложения (начиная с php5.4 можно запускать встроенный сервер php)
 ```sh
 $ php -S localhost:8008
 ```
 
 5. Открыть приложение в браузере [http://localhost:8008](http://localhost:8008)

### Windows
Для платформы windows у Вас должен быть установлен php. Можно воспользоваться автоматическим установщиком XAMPP ([установка xampp](https://www.apachefriends.org/ru/download.html)). После установки, перейдите в командную строку windows (cmd в меню Пуск). Дальнейший пример будет представлен для установленного пакета XAMPP в папку C:\xampp\ .
 1. Скачать данное приложение
 ```sh
 git clone https://github.com/uniteller/unitemplate
 cd unitemplate
 ```

 2. Выполнить загрузку модулей
 ```sh
 C:\xampp\php\php.exe composer.phar install --no-dev
 ```
 
 3. Запустить сервер приложения (начиная с php5.4 можно запускать встроенный сервер php)
 ```sh
 C:\xampp\php\php.exe -S localhost:8008
 ```
 
 4. Открыть приложение в браузере [http://localhost:8008](http://localhost:8008)

### Использование

После загрузки приложения у вас будет пример страниц шаблона. Выберите точку продажи **mobile** и перед вами откроется список страниц шаблона:

 * base.tpl - layout для шаблонов
 * pay_cc.tpl - страница оплаты в 4 возможных вариантах (все варианты физически
                содержатся в одном файле pay_cc.tpl):
       - pay_cc.tpl -стандартный вариант
       - pay_cc.tpl (Pay using Customer_IDP) - вариант с чекбоксом для запоминания информации о карте
       - pay_cc.tpl (Pay without Email)  - вариант с полем для ввода Email для плательщика
       - pay_cc.tpl (Pay with error) - вариант с выводом ошибки в случае неправильно веденных данных
 * pay_one_cc.tpl - страница оплаты с ипользованием сохраненной карты
 * pay_simple_cc.tpl -упрощенная страница оплаты (с ипользованием нескольких сохраненных карт)
 * pay_do.tpl - страница ожидания
 * pay_error.tpl - страница ошибки оплаты в 2 вариантах (все варианты физически содержатся 
                   в одном файле pay_cc.tpl):
       - pay_error.tpl -стандартный вариант
       - pay_error.tpl (3DS error) - ошибка при 3DS
 * check_cc.tpl - страница чека
 * check_error.tpl - страница ошибки чека (не возможно по какимто причинам сформировать страницу чека)


Чтобы начать разрабатывать шаблон, создайте директорию в папке **/custom/** (можно скопировать файлы из папки **mobile**). Все файлы для вашего шаблона должны лежать внутри созданной директории, при этом статические файлы по возможности необходимо размещать в папках
 * css
 * img
 * js

Файлы шаблонов *.tpl должны лежать в корне созданной вами папки

При обращении к статическим файлам, необходимо определить абсолютный путь:

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

**Важно!** На страницах шаблона есть переменные которые нужно всегда определять

```tpl
{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $this->assign('template_dir', dirname($file));
{% /php %} 
```

Здесь
 * file - переменная, в которой хранится путь к файлу шаблона, используется для манипуляции с путем к файлу
 * template_dir - переменная, к которой хранится директория шаблона

**template_dir** используется для подгрузки layout файла

```tpl
{% assign var="baseFile" value="$template_dir/base.tpl" %}
{% include file=$baseFile
    title=$smarty.capture.title|default:''
    css=$smarty.capture.css|default:''
    body=$smarty.capture.body|default:''
%}
```

