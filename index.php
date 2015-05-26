<?php 
ini_set('display_errors', 1);
ini_set('error_reporting', E_ALL );
date_default_timezone_set('Europe/Moscow');


$app = require_once __DIR__.'/app.php';

use Symfony\Component\Debug\ErrorHandler;
use Symfony\Component\Debug\ExceptionHandler;

ExceptionHandler::register();
ErrorHandler::register();

$app->error(function ( \Exception $e, $code ) use ($app) {
    echo "<pre>";
    echo "<br>";
    print_r($e->getMessage());
    echo "<br><br><br>";
    print_r($e->getTraceAsString());
    echo "</pre>";

    return $app->json( '', 404 );
});

$app->run(); 










