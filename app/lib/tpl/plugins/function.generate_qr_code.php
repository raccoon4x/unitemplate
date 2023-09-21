<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty generate_qr_code function plugin
 * Type: function
 * Name: generate_qr_code
 * Purpose: generates a qr code image from passed data (e.g. url). Uses PHP QR Code library.
 * Example: {generate_qr_code data="Hello, world!" ecc="L" size="5" frame="5"} ecc, size and frame are not necessary; default values are ecc="L" size="3" frame="3"
 * @author t.chursina
 * @param array
 * @param Smarty
 * @return string
 */
require_once("phpqrcode/phpqrcode.php");

function smarty_function_generate_qr_code($params, &$smarty) {
    if(empty($params)) {
        $smarty->trigger_error("No parameters passed.");
        return;
    }   
    if(empty($params['data'])) {
        $smarty->trigger_error("No data passed.");
        return;
    }
    
    $ecc = QR_ECLEVEL_L;
    if(!empty($params['ecc'])) {
        $ecc = defineEcc($params['ecc'], $smarty);
    }
    
    $size = 3;
    if(!empty($params['size'])) {
        $size = validateSize($params['size'], $smarty);
    }
    
    $frame = 3;
    if(!empty($params['frame'])) {
        $frame = validateFrame($params['frame'], $smarty);
    }
    
    ob_start();
    QRCode::png($params['data'], null, $ecc, $size, $frame);
    $base64 = base64_encode( ob_get_contents() );
    ob_end_clean();
    
    return '<img src="data:image/png;base64,'.$base64.'" />'; 
}

/**
 * defineEcc function: returns a phpqrcode library constant according to passed value
 * @param string $param
 * @param Smarty
 * @return string
 */
function defineEcc($param, &$smarty) {
    switch($param) {
        case "L":
            $ecc = QR_ECLEVEL_L;
            break;
        case "M":
            $ecc = QR_ECLEVEL_M;
            break;
        case "Q":
            $ecc = QR_ECLEVEL_Q;
            break;
        case "H":
            $ecc = QR_ECLEVEL_H;
            break;
        default:
            $smarty->trigger_error("Unknown value for ECC. Use values L, M, Q or H.");
            return;
    }   
    return $ecc;
}

/**
 * validateSize: checks passed qr code size
 * @param string $param
 * @param Smarty
 * @return string
 */
function validateSize($param, &$smarty) {
    if(!($param >= 1 && $param <= 10)) {
        $smarty->trigger_error("Unknown value for size. Use values 1-10.");
        return;
    }
    
    return $param;
}

/**
 * validateFrame: checks passed frame size
 * @param string $param
 * @param Smarty
 * @return string
 */
function validateFrame($param, &$smarty) {
        if(!($param >= 1 && $param <= 100)) {
        $smarty->trigger_error("Unknown value for frame. Use values 1-100.");
        return;
    }
    
    return $param;
}