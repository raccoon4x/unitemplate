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
 * Smarty number_format modifier plugin
 *
 * Type:     modifier<br>
 * Name:     number_format<br>
 * Purpose:  format numbers via number_format
 * @author   Monte Ohrt <monte at ohrt dot com>
 * @param float
 * @param int
 * @param string
 * @return string
 */
class SmartyNumberFormat {
    /**
     * @throws Exception
     */
    static public function registerInTemplateEngine(Smarty $templateEngine): void
    {
        $templateEngine->registerPlugin("function","number_format", self::_smartyNumberFormat(...));
    }
    static function _smartyNumberFormat( float|int $number, int $decimals = 0, string $dec_point = '.', string $thousands_sep = ',' ): string
    {
        return number_format( $number, $decimals, $dec_point, $thousands_sep );
    }
}


/* vim: set expandtab: */
