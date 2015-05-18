<?php /* Smarty version 2.6.25-dev, created on 2015-05-18 09:34:32
         compiled from mobile/base.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'default', 'mobile/base.tpl', 12, false),)), $this); ?>
<?php 
    $file = $this->get_template_vars('file');
    $path = explode("/",dirname($file));
    $this->assign('custom', '/custom/'.end($path));
 ?> 
<?php echo '<?xml'; ?>
 version="1.0" encoding="UTF-8"<?php echo '?>'; ?>

<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title><?php echo ((is_array($_tmp=@$this->_tpl_vars['title'])) ? $this->_run_mod_handler('default', true, $_tmp, '') : smarty_modifier_default($_tmp, '')); ?>
</title>
    
    <link rel="stylesheet" href="<?php echo $this->_tpl_vars['custom']; ?>
/css/style.css">
    <script type="text/javascript" src="<?php echo $this->_tpl_vars['custom']; ?>
/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<?php echo $this->_tpl_vars['custom']; ?>
/js/jquery.inputmask.js"></script>
    <script type="text/javascript" src="<?php echo $this->_tpl_vars['custom']; ?>
/js/jquery.inputmask.extensions.js"></script>
    <script type="text/javascript" src="<?php echo $this->_tpl_vars['custom']; ?>
/js/validate.js"></script>
    
    <?php echo ((is_array($_tmp=@$this->_tpl_vars['css'])) ? $this->_run_mod_handler('default', true, $_tmp, '') : smarty_modifier_default($_tmp, '')); ?>

    <?php echo ((is_array($_tmp=@$this->_tpl_vars['js'])) ? $this->_run_mod_handler('default', true, $_tmp, '') : smarty_modifier_default($_tmp, '')); ?>

    
</head>
<body>
<?php echo ((is_array($_tmp=@$this->_tpl_vars['body'])) ? $this->_run_mod_handler('default', true, $_tmp, '') : smarty_modifier_default($_tmp, '')); ?>

</body>
</html>