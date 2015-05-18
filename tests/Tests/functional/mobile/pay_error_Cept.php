<?php 
$upoint = basename(__DIR__) ;

$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that pay_error template is works for default error');

$I->amOnPage('/pay/error/'.$upoint); 
$I->seeResponseCodeIs(200);
$I->see("Ошибка загрузки страницы оплаты");
$I->see("При загрузке страницы оплаты произошла ошибка");
$I->see("Вернуться в магазин", "a");


