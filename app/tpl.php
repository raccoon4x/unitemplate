<?php

namespace app;

use \Smarty\Smarty;

class tpl extends Smarty {
    
    public $smarty;

    public $params = [];

    /**
     *
     *
     * @noinspection PhpMissingParentConstructorInspection
     */
    public function __construct($dir = '') {
        parent::__construct($dir);
        $smarty_dir = BASE_PATH.DS . 'vendor'.DS.'smarty'.DS.'smarty';

        $this->template_dir = $dir ? $dir : BASE_PATH.DS.'custom';

        $this->compile_dir  = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'tpl_compiled';
        $this->config_dir   = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl';
        $this->cache_dir    = BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'cache';
        $this->plugins_dir = array(
            $smarty_dir .DS.'libs'.DS.'plugins',
            BASE_PATH.DS.'app'.DS.'lib'.DS.'tpl'.DS.'plugins'
        );
        $this->registerPlugin("block","ic",array($this,'smartyIcb'));

        $this->setLeftDelimiter("{%");
        $this->setRightDelimiter( "%}");
        
        $this->debugging = true;
        $this->error_reporting = E_ALL;
        $this->auto_literal = false;  // this is the remedy :)
        $this->setForceCompile(true);
        //$this->compile_check = true;
        
    }

    /**
     * Вывод шаблона в строку
     *
     *
     * @param string $name        - template name
     * @param string $cache_id    - ID of cached template
     * @param string $compile_id  - ID of compiled template
     * @param boolean $display    - показывать или нет
     *
     * @return string             - результат исполнения шаблона
     */
    public function fetch( $template = null, $cache_id = null, $compile_id = null ) {
        $this->assign('template_dir', "."); // $this->template_dir;
        
        if(strpos($this->template_dir,"..")) {
            $arr = explode("..",$this->template_dir);
            $this->assign('template_dir', $arr[1]);
            $this->assign('custom', $arr[1]);
        } else {
            $this->assign('template_dir', $this->template_dir);
            $this->assign('custom', $this->template_dir);
        }
        $this->assign('defaultSupportPhone', '8 800 707-67-19');
        return parent::fetch( $template, $cache_id, $compile_id);

    }

    public function assign($tpl_var, $value = null, $nocache = false, $scope = null){
        $this->params[$tpl_var] = $value;
        parent::assign($tpl_var, $value);
    }

    public function smartyIcb($params, $content, $smarty, &$repeat)
    {
       return $content;
    }
   
}
