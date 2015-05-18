<?php

namespace app;

use app\tpl;
use app\lib\sm\url;


class pay {
    
    function __construct() {
        $this->tpl = new tpl();
        url::registerInTemplateEngine($this->tpl);
    }
    
    public function acp_index($upoint){
        
        $context = $this->getContext();
        if (isset($_GET['emptyEmail']) && $_GET['emptyEmail']){
            $context['Email'] = '';
            $this->tpl->assign('isValidEmail','0');
        }else{
            $this->tpl->assign('isValidEmail','1');
        }
        
        $this->tpl->assign('context',$context);
        $this->tpl->assign('payment_menu','1');
        $this->tpl->assign( "aYears", $this->getExpYears() );
        $this->tpl->assign( "aMonths", $this->getExpMonths() );
        $this->tpl->assign( "aRegisteredCards", false );
        
        
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('isCustomer','0');
        
        $this->tpl->assign('aShop',$this->getShop());
        $this->tpl->assign('conf',array('currentUrl' => ''));
        
        if (isset($_GET['customer']) && $_GET['customer']){
            $this->tpl->assign('isCustomer',true);
        }
        
        if (isset($_GET['error']) && $_GET['error']){
            $this->tpl->assign('aErrors',array(
                '1000000' => "Ваш платеж отклонен. Пожалуйста, проверьте правильность введенной информации по Вашей банковской карте и попробуйте еще раз.",
                '1000001' => "Просим Вас повторно ввести поля: Номер карты, Срок действия, Код CVC2 или CVV2, Имя держателя карты. Мы не сохраняем их в целях Вашей безопасности."

            ));
        }
        
        return $this->tpl->fetch($upoint . DS . 'pay_cc.tpl', null, null, false);

    }
    
    public function acp_do($upoint){
        
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('url','');
        
        return $this->tpl->fetch($upoint . DS . 'pay_do.tpl', null, null, false);

    }
    
    public function acp_do_redirect($upoint){
		sleep(10);
        return "Redirect is OK";
    }
    
    public function acp_error($upoint){
        
        $this->tpl->assign('context',$this->getContext());
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('conf',array('currentUrl' => ''));
        
        $error = isset($_GET['error']) ? $_GET['error'] : '';
        switch($error){
            case '3ds':
                $this->tpl->assign('context_error_3ds',"true");
            break;
        
            default :
                $this->tpl->assign('message',"true");
        }
        
        return $this->tpl->fetch($upoint . DS . 'pay_error.tpl', null, null, false);

    }
    
    public function acp_check($upoint){
        
        $this->tpl->assign('context',$this->getContext());
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('aShop',$this->getShop());
        $this->tpl->assign('aOrder',$this->getOrder());
        $this->tpl->assign('conf',array('currentUrl' => ''));
        return $this->tpl->fetch($upoint . DS . 'check_cc.tpl', null, null, false);

    }
    
    public function acp_check_error($upoint){
        
        $this->tpl->assign('context',$this->getContext());
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('conf',array('currentUrl' => ''));
        
        $this->tpl->assign('message',"true");
        
        return $this->tpl->fetch($upoint . DS . 'check_error.tpl', null, null, false);

    }
    
    public function acp_fee($upoint){

        $this->tpl->assign('conf',array('currentUrl' => ''));
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('newRouteData',$this->getNewRouteData());
        $this->tpl->assign('originalAmount','51.53');
        return $this->tpl->fetch($upoint . DS . 'pay_fee.tpl', null, null, false);

    }
    
    public function acp_one($upoint){
        
        $context = $this->getContext();
        $this->tpl->assign('context',$context);
        $this->tpl->assign('payment_menu','1');
        $this->tpl->assign( "aYears", $this->getExpYears() );
        $this->tpl->assign( "aMonths", $this->getExpMonths() );
        $this->tpl->assign('isValidEmail','1');
        $this->tpl->assign( "aRegisteredCards", false );
        
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('isCustomer','0');
        
        $this->tpl->assign('aShop',$this->getShop());
        $this->tpl->assign('conf',array('currentUrl' => ''));
        $this->tpl->assign('card',$this->getCard());
        $this->tpl->assign('card_error','');
        
        
        return $this->tpl->fetch($upoint . DS . 'pay_one_cc.tpl', null, null, false);
    }
    
    public function acp_simple($upoint){
        
        $context = $this->getContext();
        $this->tpl->assign('context',$context);
        $this->tpl->assign('payment_menu','1');
        $this->tpl->assign( "aYears", $this->getExpYears() );
        $this->tpl->assign( "aMonths", $this->getExpMonths() );
        $this->tpl->assign('isValidEmail','1');
        
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('isCustomer','0');
        
        $this->tpl->assign('aShop',$this->getShop());
        $this->tpl->assign('conf',array('currentUrl' => ''));
        $this->tpl->assign('aRegisteredCards',$this->getRegisteredCards());

        return $this->tpl->fetch($upoint . DS . 'pay_simple_cc.tpl', null, null, false);

    }
    
    public function acp_info($upoint){

        return $this->tpl->fetch($upoint . DS . 'info_cc.tpl', null, null, false);

    }
    
    public function acp_spasibo($upoint){
        
        $this->tpl->assign('context',$this->getContext());
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('conf',array('currentUrl' => ''));
        
        $this->tpl->assign('spasibo_pay_limit',10);
        $this->tpl->assign('spasibo_balance',99);
        
        return $this->tpl->fetch($upoint . DS . 'pay_spasibo.tpl', null, null, false);

    }
    
    public function acp_spasiboerr($upoint){
        
        $this->tpl->assign('context',$this->getContext());
        $this->tpl->assign('contextSerialized','1234567890');
        $this->tpl->assign('conf',array('currentUrl' => ''));
        
//        $this->tpl->assign('spasibo_pay_limit',10);
//        $this->tpl->assign('spasibo_balance',99);
        
       
        $this->tpl->assign('aErrors',array(
            '0' => "Не удалось списать баллы «СПАСИБО»",
        ));
       
        
        return $this->tpl->fetch($upoint . DS . 'pay_spasibo_err.tpl', null, null, false);

    }
    
    
    
    
    // private
    
    private function getExpYears() {
        $startYear = (int)date("Y");
        $endYear   = $startYear + 20;

        $aYears = array ();
        for ($i = $startYear; $i <= $endYear; $i++) {
            $aYears[$i] = $i;
        }

        return $aYears;
    }

    private function getExpMonths() {
        $aMonths = array ();
        for ($i = 1; $i <= 12; $i++) {
            $aMonths[$i] = sprintf("%02d", $i);
        }

        return $aMonths;
    }
    
    private function getShop(){
        return array(
            'upoint_id' => '00000122',
            'name' => 'TKB 3ds',
            'comp_id' => 5,
            'use_secstep' => 0,
            'is_deleted' => 0,
            'url' => '',
            'email' => '',
            'url_comission' => '', 
            'with_recurrent_pays' => 0,
            'allow_old_signature'=> 1,
            'active_tmpl' => 'mobile',
            'show_check' => 1,
            'send_email' => 1,
            'callback_url' => 'http://test.ru/callbacktest/',
            'currency' => 643,
            'domain_name' => 'http://test.ru/'
        );
    }
    
    private function getContext(){
        $context = array(
            'sProtocolVersion' => '1.1',
            'Shop_IDP' => '00000122',
            'UPointID' => '00000122',
            'Order_IDP' => 'uni-тест +_;№%:?2015-03-31-20826',
            'chSaveCard' => '0',
            'Subtotal_P' => '51.53',
            'Subtotal_P_for_signature' => '51.53',
            'Lifetime' => '36000',
            'IsRecurrentStart' => '0',
            'LifetimeEnds' => '1427816082',
            'LogId' => '14277800827859681',
            'Customer_IDP' => '12345',
            'URL_RETURN' => 'http://test.ru/ecommerce.php?pay/ok/',
            'Comment' => '',
            'FirstName' => '',
            'LastName' => '',
            'MiddleName' => '',
            'Email' => 'mail_51.53@unitecsys.ru',
            'State' => '',
            'Zip' => '',
            'Signature' => 'C9F481E6955573203257893998E8DEF5',
            'MeanType' => '-1',
            'EMoneyType' => '-1',
            'showStandartForm' => '',
            'BillLifetime' => '',
            'OrderLifetime' => '0',
            'Currency' => 'RUB',
            'IssuerName' => '*НЕ ЗАДАВАЛСЯ*',
            'IssuerSupportPhone' => '0000000',
            'Country' => '*НЕ ЗАДАВАЛСЯ*',
            'City' => '*НЕ ЗАДАВАЛСЯ*',
            'Address' => '*НЕ ЗАДАВАЛСЯ*',
            'Phone' => '+370491234567',
            'Card_Registration' => '0',
            'Language' => 'ru',
            'Ip' => '213.208.182.169',
            'isNewSignature' => '1',
            'useSecStep' => '',
            'active_tmpl' => 'mobile',
            'show_email' => '0',
            'show_phone' => '0',
            'payTypes' => array('0' => '0'),
        );
        return $context;
    }
    
    private function getCard(){
        return array(
            'mask' => 'VISA 440505******0005', 
            'state' => '1', 
            'bank_name' => '',
            'card_number' => '440505******0005',
            'card_type' => 'VISA',
            'cid' => '9' 
        );
         
    }
    
    private function getRegisteredCards(){
        return array(
            '9' => array( 
                'cid' => 9,
                'mask' => 'VISA 440505******0005',
                'state' => 1,
                'bank_name' => '',
                'customer_id' => '12345', 
                'shop_id' => '00000291',
                'exp_date' => '',
                'card_number' => '440505******0005',
                'card_type' => 'VISA',
                'acquirerid' => '',
                'isowncard' => ''
            ),
            '10' => array( 
                'cid' => 10,
                'mask' => 'VISA 550505******0001',
                'state' => 1,
                'bank_name' => '',
                'customer_id' => '12345', 
                'shop_id' => '00000291',
                'exp_date' => '',
                'card_number' => '550505******0001',
                'card_type' => 'VISA',
                'acquirerid' => '',
                'isowncard' => ''
            ) 
        ); 
    }
    
    private function getOrder(){
        return array (
            'transaction_id' => 1877,
            'demo' => 0,
            'shop_id' => '00000004',
            'made_at' => '2015-05-13 12:59:20',
            'order_number' => 'uni-тест +_;№%:?2015-05-13-6457',
            'responce_code' => 'AS000',
            'recommendation' => 'АВТОРИЗАЦИЯ УСПЕШНО ЗАВЕРШЕНА',
            'message' => '',
            'comment' => 'Тестовый платеж',
            'total' => '382.06',
            'currency' => 'RUB',
            'card_type' => 'visa',
            'card_number' => '440505******0005',
            'last_name' => 'Пупкин',
            'first_name' => 'Вася',
            'middle_name' => '',
            'address' => '*НЕ ЗАДАВАЛСЯ*',
            'email' => 'mail_382.06@unitecsys.ru',
            'approval_code' => '0DE37B',
            'had_cvc2' => '1',
            'ip_address' => '213.208.182.169',
            'bill_number' => '013313036127',
            'status' => 'Authorized',
            'error_code' => '',
            'error_comment' => '',
            'issuer_name' => '*НЕ ЗАДАВАЛСЯ*',
            'payment_type' => 1,
            'expire_at' => '',
            'cardholder_name' => 'test',
            'phone' => '0000000',
            'ind_data' => '',
            'need_confirm' => 0,
            'pt_code' => '',
            'emoney_type' => 0,
            'eorder_data' => '',
            'inserted' => '2015-05-13 12:59:20',
            'cid' => '',
            'idata_gds' => '',
            'acq_id' => 1,
            'ecshop' => '00000004-221',
            'is_other_card' => 1,
        );     
    }
    
    private function getNewRouteData(){
        return array (
            'orderid' => 'uni-тест +_;№%:?2015-05-13-68929',
            'continuepay' => 1,     
            'newamount' => 401.25,     
            'comissionamount' => 19.11,     
            'message' => 'Комиссия составляет 5% от суммы' 
        );
    }
            
    
}
