<?php
namespace app\main;

use app\tpl;

class main {
    
    protected $tpl;
    protected $custom_dir;
    
    static $template_types = array(
        array('path' => '/pay/', 'template' => 'pay_cc.tpl', 'cases' => 
            array(
                '?customer=true' => 'Pay using Customer_IDP',
                '?emptyEmail=true' => 'Pay without Email',
                '?error=true' => 'Pay with error',
            )
        ),
        array('path' => '/pay/do/', 'template' => 'pay_do.tpl'), 
        array('path' => '/pay/error/', 'template' => 'pay_error.tpl', 'cases' => array('?error=3ds' => '3DS error')),
        array('path' => '/pay/check/', 'template' => 'check_cc.tpl'),
        array('path' => '/pay/check_error/', 'template' => 'check_error.tpl'), 
        array('path' => '/pay/fee/', 'template' => 'pay_fee.tpl'), 
        array('path' => '/pay/one/', 'template' => 'pay_one_cc.tpl'),
        array('path' => '/pay/simple/', 'template' => 'pay_simple_cc.tpl'),
        array('path' => '/pay/info/', 'template' => 'info_cc.tpl'),
        
        array('path' => '/pay/spasibo/', 'template' => 'pay_spasibo.tpl'),
        array('path' => '/pay/spasiboerr/', 'template' => 'pay_spasibo_err.tpl'),
    );
    
    function __construct() {
        $tpl_dir = __DIR__.DS."tpl";
        
        $this->custom_dir = BASE_PATH.DS.'custom'.DS;
        $this->tpl = new tpl($tpl_dir);
    }
    
    
    
    public function acp_index(){
        
        $folder = $this->custom_dir;
        
        $values_to_remove= array('..', '.');
        $folders = array_diff(scandir($folder), $values_to_remove);
        
        $list = array();
        foreach ($folders as $folder){
            if (strpos("_".$folder,".") || !file_exists($this->custom_dir.$folder)){ // if it is not folder
                continue; 
            }
            
            $forder_dir = $this->custom_dir.$folder.DS;
            $folder_templates = array();
            
            
            foreach (self::$template_types as $data){
                if (file_exists($forder_dir.$data['template'])){
                    $folder_templates[$data['path']] = $data;
                }
            }
            
            $list[$folder] = $folder_templates;
        }
               
        $this->tpl->assign('list',$list);
        
        
        return $this->tpl->fetch('main.tpl', null, null, false);
    }
    
    public function acp_archive($upoint){
        echo $upoint;
        
        $name = $upoint . '_'.time().'.zip';
        $filename = 'assets/cache/'.$name ;
        $archive = new \PclZip($filename); //Создаём объект и в качестве аргумента, указываем название архива, с которым работаем.
        $result = $archive->create(BASE_PATH . DS .'custom' . DS . $upoint . DS, PCLZIP_OPT_REMOVE_PATH, BASE_PATH."/custom/".$upoint); // Этим методом класса мы создаём архив с заданным выше названием
        
        if($result == 0) {
            echo $archive->errorInfo(true);
            die();
        }
        
        // скачиваем архив
        header("Content-Type: application/zip");
        header("Content-Disposition: attachment; filename=\"".$name."\"");
        readfile($filename);
        
        
        // Удаляем файл архива
        unlink($filename);
        die();
    }
    
}
