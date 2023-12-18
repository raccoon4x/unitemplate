<?php

namespace app;

use Silex\Application;
use Silex\Route;
use Silex\ControllerProviderInterface;
use Silex\ControllerCollection;
use app\pay;
use app\main\main;

class routes implements ControllerProviderInterface {
    
    public function connect(Application $app) {
        $index = new ControllerCollection(new Route());
        header('Content-Type: text/html; charset=utf-8');
        
        $index->get('/', function() use ($app) {
            
            $main = new main();
            
            return $main->acp_index();
        });
        
        $index->get('/main/archive/{upoint}', function($upoint) use ($app) {
            
            $main = new main();
            
            return $main->acp_archive($upoint);
        });
        
        $index->get('/pay/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_index($upoint);
        });
        
        $index->get('/pay/do/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_do($upoint);
        });
        
        $index->post('/pay/do/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_do_redirect($upoint);
        });
        
        $index->get('/pay/error/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_error($upoint);
        });
        
        $index->get('/pay/check/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_check($upoint);
        });
        
        $index->get('/pay/check_error/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_check_error($upoint);
        });
        
        $index->get('/pay/fee/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_fee($upoint);
        });
        
        $index->get('/pay/one/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_one($upoint);
        });
        
        $index->get('/pay/simple/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_simple($upoint);
        });
        
        $index->get('/pay/info/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_info($upoint);
        });
        
        $index->get('/pay/spasibo/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_spasibo($upoint);
        });
        
        $index->get('/pay/spasiboerr/{upoint}', function($upoint) use ($app) {
            
            $pay_class = new pay($upoint);
            
            return $pay_class->acp_spasiboerr($upoint);
        });
        
        
        
        



        return $index;
    }
    
}
