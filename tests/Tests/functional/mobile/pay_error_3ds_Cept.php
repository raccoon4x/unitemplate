<?php 
$upoint = basename(__DIR__) ;
$_GET['error'] = "3ds";
$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that pay_error template is works for 3ds error');

$I->amOnPage('/pay/error/'.$upoint); 
$I->seeResponseCodeIs(200);
$I->see("Ошибка загрузки страницы оплаты");
$I->see("Банк-эмитент не вернул корректные параметры платежа");
$I->see("Вернуться в магазин", "a");


