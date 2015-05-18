<?php 
require_once "constants.php";
require_once __DIR__.DIRECTORY_SEPARATOR."vendor".DIRECTORY_SEPARATOR."autoload.php";

$app = new Silex\Application(); 

$app->mount('/', new app\routes());

return $app;

