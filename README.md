# Unitemplate - среда для разработки шаблонов

Позволяет разрабатывать шаблоны

### Устанвка

Необходимые требования:
* php >= 5.4
* git ([установка](http://git-scm.com/book/ru/v2/%D0%92%D0%B2%D0%B5%D0%B4%D0%B5%D0%BD%D0%B8%D0%B5-%D0%A3%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-Git))

#### Шаги по установке

 1. Скачать данное приложение
 ```sh
 $ git clone [git-repo-url]
 $ cd unitemplate
 ```
 где [git-repo-url] - текущий url репозитория

 2. Выполнить загрузку модулей
 ```sh
 $ php composer.phar install --no-dev
 ```
 
 3. При необходимости поставить права на запись для папки
 ```sh
 $ chmod -R 777 app/lib/tpl/tpl_compiled/
 ```

 4. Запустить приложение
 ```sh
 $ php -S localhost:8008
 ```
 
 5. Открыть приложение в браузере [http://localhost:8008](http://localhost:8008)