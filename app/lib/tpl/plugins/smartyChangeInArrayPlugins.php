<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */

namespace app\lib\tpl\plugins;

use Smarty\Exception;
use Smarty\Smarty;

/**
 * Smarty {change_in_array function plugin
 *
 * Type:     function<br>
 * Name:     change_in_array<br>
 * Purpose:  change value (if index exists) in array<br>
 * Example: {change_in_array var="arr" index="10" value="new_value"}
 * @param array $params
 * @param Smarty $smarty
 * @return void
 *@author   uniteller
 */
class SmartyChangeInArrayPlugins {
    /**
     * @throws Exception
     */
    static public function registerInTemplateEngine(Smarty $templateEngine): void
    {
        $templateEngine->registerPlugin("function","change_in_array", self::_smartyChangeInArray(...));
    }
    static public function _smartyChangeInArray(array|string $params, Smarty &$smarty): void
    {
        // be sure var parameter is present
        if (empty($params['var'])) {
            $smarty->trigger_error("change_in_array: missing var parameter");
            return;
        }
        // be sure index parameter is present
        if (empty($params['index'])) {
            $smarty->trigger_error("change_in_array: missing index parameter");
            return;
        }
        if ( isset( $smarty->_tpl_vars[$params['var']][$params['index']] ) ) {
            if (empty($params['value'])) {
                // remove element from array
                unset( $smarty->_tpl_vars[$params['var']][$params['index']] );
            } else {
                // update value in array
                $smarty->_tpl_vars[$params['var']][$params['index']] = $params['value'];
            }
        }
        return;
    }
}
