<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


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
function smarty_modifier_number_format( $number, $decimals = 0, $dec_point = '.', $thousands_sep = ',' )
{
    return number_format( $number, $decimals, $dec_point, $thousands_sep );
}

/* vim: set expandtab: */

?>
