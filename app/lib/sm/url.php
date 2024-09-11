<?php

namespace app\lib\sm;

use \Smarty\Smarty;
/**
 * Утилитный класс для формирования URL: добавление, удаление, изменения параметров.
 */
class url {
    /**
     * Регистрирует в Smarty
     *
     * <ul>
     * <li>блочную функцию {url}{/url}</li>
     * <li>smarty tag {paramsToHiddenInputs url=$url [ignore="name1, name2, ..."} - generate hidden inputs for each GET parameter in the URL. You can skip some of them by adding to ignore list.</li>
     * <li>smarty tag {curParameters url=$url} - cut GET parameters off the URL</li>
     * <li>smarty tag {uid name="name"} - generate unique id for the name and return it every time the tag with the name is used</li>
     * <li>блочная функция {jsLoader} - {jsLoader url=$conf.jsUrl separate=$conf.debugMode version=$resourcesVersion}dummy1.js,dummy2.js{/jsLoader}</li>
     * <li>smarty модификатор url_to_html_link - заменяте в тексте урлы на ссылки на них, используя тег A.</li>
     * <li></li>
     * </ul>
     *
     * блок-функцию для формирования URL.
     *
     * Пример использования в PHP пишем:
     * <pre>
     * require_once "sm_url.php";
     * sm_url::registerInTemplateEngine($smarty);
     * </pre>
     *
     * В шаблоне:
     * <pre>
     * {url paramsString="param1=value1&param2=value2" param3="value3"}
     *     {$conf.baseUrl}{$project_id|escape:"url"}/discussions/discussions/
     * {/url}
     *
     * {jsLoader url=$conf.jsUrl separate=$conf.debugMode version=$resourcesVersion}
     * common.js,transport_ajax.js,
     * ImMessage.js,ImPresence.js,ImSession.js,ImUser.js,ImHub.js,
     * Chat.js,SingleChat.js,
     * TransportQueue.js
     * {/jsLoader}
     * </pre>
     *
     * В URL добавляет GET-параметры. Причём, если в URL уже такие параметры есть, то перезаписывает указанными значениями.
     * <ul>
     * <li>paramsString - необязательный. Строка с уже сформированными для вставки в URL GET-параметрами.</li>
     * <li>Все остальные параметры - считаеются GET-параметрами и добавляются в URL (перезаписываясь поверх существующих, если таковые имеются).</li>
     * </ul>
     *
     * @param Smarty $templateEngine
     * @access public
     * @static
     */
    static public function registerInTemplateEngine(Smarty $templateEngine)
    {
        $templateEngine->registerPlugin("block","url", array ("app\lib\sm\url", "_smartyUrl"));
        $templateEngine->registerPlugin("function","paramsToHiddenInputs", array ("app\lib\sm\url", "_smartyParamsToHiddenInputs"));
        $templateEngine->registerPlugin("function","cutParameters", array ("app\lib\sm\url", "_smartyCutParameters"));
        $templateEngine->registerPlugin("block","jsLoader", array ("app\lib\sm\url", "_smartyJsLoader"));
        $templateEngine->registerPlugin("function","uid", array ("app\lib\sm\url", "_smartyUid"));
        $templateEngine->registerPlugin("modifier","is_numeric", array ("app\lib\sm\url", "_is_numeric"));
        //$templateEngine->registerPlugin("modifier","url_to_html_link", array ("app\lib\sm\url", "urlsToHtmlLinks"));
        $templateEngine->registerPlugin("modifier","rand", array ("app\lib\sm\url", "_rand"));
    }

    /**
     * В URL добавляет GET-параметры добавляя\перезаписывая их к уже там присутствующим.
     *
     * @param mixed string - если указан только этот параметр, то он заменяет собой следующий
     *              array - $aParams array (paramName => paramValue): Все остальные параметры - считаеются GET-параметрами и добавляются в URL (перезаписываясь поверх существующих, если таковые имеются)
     * @param string $paramsString необязательный. Строка с уже сформированными для вставки в URL GET-параметрами
     * @param string[] массив имён параметров, которые нужно удалить из URL
     * @return string результирующий URL
     * @access public
     * @static
     */
    static public function format($url, $aParams = array (), $paramsString = "", $aRemoveParams = array ()) {
        $url = urldecode($url);

        if (empty($aParams) && $paramsString == "" && empty($aRemoveParams)) {
            return $url;
        }

        $fragment = '';
        if (strpos($url, '#') !== false) {
            $fragment = substr($url, strpos($url, '#'));
            $url = substr($url, 0, strpos($url, '#'));
        }

        if (is_string($aRemoveParams)) {
            $aRemoveParams = preg_split("`\s*,\s*`", $aRemoveParams, -1, PREG_SPLIT_NO_EMPTY);
        }

        if ($paramsString != "") {
            $aGetParams = sm_url::cutGetParams($paramsString, true);
            foreach ($aGetParams as $name => $value) {
                $aParams[$name] = $value;
            }
        }

        $aGetParams = array ();

        // получить уже присутствующие в URL параметры
        if (preg_match("`\?`", $url, $aMatches)) {
            $aUrlParams = sm_url::cutGetParams($url);
            foreach ($aUrlParams as $n => $v) {
                $aGetParams[$n] = $v;
            }
        }

        if (is_string($aParams)) {
            // на самом деле $aParams - такая же строка, как и $paramsString
            $aParams = sm_url::cutGetParams($aParams, true);
        }

        // перезаписать поверх существующих или добавить новые параметры
        foreach ($aParams as $n => $v) {
            $aGetParams[$n] = $v;
        }

        // удалить указанные параметры
        foreach ($aRemoveParams as $n) {
            if (preg_match("`^(.+)\\[\\*\\]$`", $n, $aMatches)) {
                $regexp = preg_quote($aMatches[1]);
                foreach ($aGetParams as $pn => $pv) {
                    if (preg_match("`^$regexp\\[.*\\]$`", $pn)) {
                        unset($aGetParams[$pn]);
                    }
                }
            }
            else {
                if (array_key_exists($n, $aGetParams)) {
                    unset($aGetParams[$n]);
                }
            }
        }

        // сформировать строку запроса
        $aGetString = array ();
        foreach ($aGetParams as $n => $v) {
            if (is_array($v)) {
                foreach ($v as $pValue) {
                    $aGetString[] = urlencode($n) . "=" . urlencode($pValue);
                }
            }
            else {
                $aGetString[] = urlencode($n) . "=" . urlencode($v);
            }
        }
        if (!empty($aGetString)) {
            $getString = "?" . implode("&", $aGetString);
            $url .= $getString;
        }

        return trim($url).$fragment;
    }

    static public function getUrlParameters($url)
    {
        // copy the url because cutGetParams() cut them off the parameter
        $_url = $url;
        return sm_url::cutGetParams($_url);
    }

    /**
     * Cut GET parameters from the URL and return the list in form name => value or name => array of values.
     *
     * The URL is passed by refference so GET parameters are cut from the variable that is passed to the function
     *
     * @param string $url the URL to cut the GET parameters from
     * @param boolean $fromTheBeginning whether $url contains only GET part of request or full request
     * @return array name => value
     * @access private
     * @static
     */
    static public function cutGetParams(&$url, $fromTheBeginning = false)
    {
        $aGetParams = array ();

        if ($fromTheBeginning) {
            $getString = $url;
        }
        else {
            // cut trailing '?' if present
            $url = preg_replace("`\?$`", "", $url);

            if (preg_match("`\?(.+)$`", $url, $aMatches)) {
                $getString = $aMatches[1];
            }
            else {
                // no GET parameters in the URL
                return array ();
            }
        }
        if ($getString) {
            // вырезать GET-параметры из URL
            $url = preg_replace("`\?(.+)$`", "", $url);

            $aParams = preg_split("`&`", $getString, -1, PREG_SPLIT_NO_EMPTY);
            foreach ($aParams as $p) {
                if (preg_match("`^([^=]+)(?:=(.*))?$`", $p, $aMatches2)) {
                    $paramName = urldecode($aMatches2[1]);
                    if (array_key_exists($paramName, $aGetParams)) {
                        if (!is_array($aGetParams[$paramName])) {
                            $aGetParams[$paramName] = array ($aGetParams[$paramName]);
                        }

                        $aGetParams[$paramName][] = isset($aMatches2[2]) ? urldecode($aMatches2[2]) : "";
                    }
                    else {
                        $aGetParams[$paramName] = isset($aMatches2[2]) ? urldecode($aMatches2[2]) : "";
                    }
                }
                else {
                    // игнорировать синтаксически неверные параметры
                    // (по всей видимости только отдельно стоящее '=' или начинающийся на него параметр)
                }
            }
        }

        return $aGetParams;
    }

    /**
     * Реализация плагина к Smarty.
     *
     * @access public
     * @static
     */
    static public function _smartyUrl($params, $content, &$smarty, &$repeat)
    {
        if (isset($content)) {
            if (array_key_exists("paramsString", $params)) {
                $paramsString = $params["paramsString"];
                unset($params["paramsString"]);
            }
            else {
                $paramsString = "";
            }

            if (array_key_exists("removeString", $params)) {
                $removeString = $params["removeString"];
                unset($params["removeString"]);
            }
            else {
                $removeString = "";
            }

            return url::format($content, $params, $paramsString, $removeString);
        }
    }

    /**
     * Реализация плагина к Smarty.
     *
     * @access public
     * @static
     */
    static public function _smartyJsLoader($params, $content, &$smarty, &$repeat)
    {
        if (isset($content)) {
            if (!array_key_exists("url", $params)) {
                $smarty->trigger_error("jsLoader: 'url' parameter is missing.");
            }

            $version = array_key_exists("version", $params) ? "version=" . urlencode($params['version']) : '';

            $aFiles = preg_split("`\s*,+\s*`", trim($content), -1, PREG_SPLIT_NO_EMPTY);
            if (!empty($params['separate'])) {
                // separate each js file in <script></script> line

                $s = "";
                foreach ($aFiles as $file) {
                    $s .= '<script type="text/javascript" src="' . $params['url'] . $file . ($version ? '?' . $version : '') . '"></script>' . "\n";
                }

                return $s;
            }
            else {
                // just return on js_loader.php call
                return '<script type="text/javascript" src="' . $params['url'] . 'js_loader.php' . ($version ? '?' . $version . '&' : '?') . 'files=' . urlencode(implode(",", $aFiles)) . '"></script>';
            }
        }
    }

    /**
     * Реализация функции Smarty.
     *
     * @access public
     * @static
     */
    static public function _smartyParamsToHiddenInputs($params, &$smarty)
    {
        if (!array_key_exists("url", $params)) {
            $smarty->trigger_error("paramsToHiddenInputs: 'url' parameter is missing.");
        }

        $aIgnore = array ();
        if (array_key_exists("ignore", $params)) {
            $aIgnore = preg_split("`\s*,\s*`", $params["ignore"], -1, PREG_SPLIT_NO_EMPTY);
            $params['url'] = sm_url::format($params['url'], array (), '', $aIgnore);
        }

        $aInputs = array ();
        foreach (sm_url::getUrlParameters($params['url']) as $name => $value) {
            if (!is_array($value)) {
                $value = array ($value);
            }

            foreach ($value as $atomicValue) {
                $aInputs[] = '<input type="hidden" name="' . htmlspecialchars($name) . '" value="' . htmlspecialchars($atomicValue) . '">';
            }
        }

        return implode("\n", $aInputs);
    }

    /**
     * Реализация функции Smarty.
     *
     * @access public
     * @static
     */
    static public function _smartyCutParameters($params, &$smarty)
    {
        if (!array_key_exists("url", $params)) {
            $smarty->trigger_error("cutParamters: 'url' parameter is missing.");
        }

        $url = $params['url'];
        sm_url::cutGetParams($url);
        return $url;
    }

    /**
     * Реализация функции Smarty.
     *
     * @access public
     * @static
     */
    static public function _smartyUid($params, &$smarty)
    {
        if (!array_key_exists("name", $params)) {
            $smarty->trigger_error("uid: 'name' parameter is missing.");
        }

        return sm_url::uid($params['name']);
    }
    
    
    /**
     * Реализация функции Smarty.
     *
     * @access public
     * @static
     */
    static public function _rand($from, $to)
    {
        return rand($from, $to);
    }    
    
    static public function _is_numeric($params)
    {
        return is_numeric($params);
    }    


    /**
     * @var string
     */
    static private $uidPrefix = null;

    /**
     * Generate unique id for each name or return the same unique id if the name used not at the first time.
     *
     * @param string $name
     * @return string
     */
    static public function uid($name)
    {
        if (sm_url::$uidPrefix === null) {
            sm_url::$uidPrefix = time() . mt_rand(1000000, 9999999);
        }

        return $name . "_" . sm_url::$uidPrefix;
    }
}
?>