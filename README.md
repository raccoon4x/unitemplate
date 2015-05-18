# Unitemplate - ����� ��� ���������� ��������

��������� ������������� �������

### ���������

����������� ����������:
* php >= 5.4
* git ([���������](http://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git))

#### ���� �� ���������

 1. ������� ������ ����������
 ```sh
 $ git clone [git-repo-url]
 $ cd unitemplate
 ```
 ��� [git-repo-url] - ������� url �����������

 2. ��������� �������� �������
 ```sh
 $ php composer.phar install --no-dev
 ```
 
 3. ��� ������������� ��������� ����� �� ������ ��� �����
 ```sh
 $ chmod -R 777 app/lib/tpl/tpl_compiled/
 ```

 4. ��������� ����������
 ```sh
 $ php -S localhost:8008
 ```
 
 5. ������� ���������� � �������� [http://localhost:8008](http://localhost:8008)

### �������������

����� �������� ���������� � ��� ����� ������ ������� �������. �������� ����� ������� **mobile** � ����� ���� ��������� ������ ������� �������:

 * pay_cc.tpl - �������� ������
 * pay_do.tpl - �������� ��������
 * pay_error.tpl - �������� ������
 * check_cc.tpl - �������� ����
 * check_error.tpl - �������� ������ ����
 * pay_one_cc.tpl - �������� ������ ����������� ������
 * pay_simple_cc.tpl -���������� �������� ������
 * base.tpl - layout ��� ��������

����� ������ ������������� ������, �������� ���������� � ����� **/custom/** (����� ����������� ����� �� ����� **mobile**). ��� ����� ��� ������ ������� ������ ������ ������ ��������� ����������, ��� ���� ����������� ����� �� ����������� ���������� ��������� � ������
 * css
 * img
 * js

����� �������� *.tpl ������ ������ � ����� ��������� ���� �����

��� ��������� � ����������� ������, ���������� ���������� ���������� ����:

```tpl
{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $path = explode("/",dirname($file));
    $this->assign('custom', '/custom/'.end($path)); // ����������� ����������� ����
{% /php %} 
```

����� ���� ��� ����� ������������

```tpl
<link rel="stylesheet" href="{% $custom %}/css/style.css">
<script type="text/javascript" src="{% $custom %}/js/jquery-1.8.3.min.js"></script>
```

��� {% $custom %} - ���������� ���� � ����� � ������ ���������

**�����!** �� ��������� ������� ���� ���������� ������� ����� ������ ����������

```tpl
{% assign var="file" value=$smarty.template %}
{% php %}
    $file = $this->get_template_vars('file');
    $this->assign('template_dir', dirname($file));
{% /php %} 
```

�����
 * file - ����������, � ������� �������� ���� � ����� �������, ������������ ��� ����������� � ����� � �����
 * template_dir - ����������, � ������� �������� ���������� �������

**template_dir** ������������ ��� ��������� layout �����

```tpl
{% assign var="baseFile" value="$template_dir/base.tpl" %}
{% include file=$baseFile
    title=$smarty.capture.title|default:''
    css=$smarty.capture.css|default:''
    body=$smarty.capture.body|default:''
%}
```

