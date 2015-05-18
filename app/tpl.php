<?php

namespace app;

use \Smarty;

class tpl extends Smarty {
    
    public $smarty;
    
    function __construct($dir = '') {
        
        $smarty_dir = BASE_PATH.DS . 'vendor'.DS.'smarty'.DS.'smarty';
   
        $this->template_dir = $dir ? $dir : BASE_PATH.DS.'custom';
        $this->compile_dir  = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'tpl_compiled';
        $this->config_dir   = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl';
        $this->cache_dir    = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'cache';
        $this->plugins_dir = array(
            $smarty_dir .DS.'libs'.DS.'plugins',
            BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'plugins'
        );
        $this->register_block("ic",array('app\tpl','smartyIcb'));
        


        $this->left_delimiter = '{%';
        $this->right_delimiter = '%}';
        
        $this->debugging = true;
        $this->error_reporting = E_ALL;
        
        $this->force_compile = true;
        //$this->compile_check = true;
        
        
    }
    
    public function smartyIcb($params, $content, $smarty, &$repeat)
    {   
       return $content;
    }
   
}
