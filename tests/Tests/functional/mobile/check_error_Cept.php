<?php 
$upoint = basename(__DIR__) ;

$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that check_error template is works');

$I->amOnPage('/pay/check_error/'.$upoint); 
$I->seeResponseCodeIs(200);
$I->see("Ошибка загрузки страницы чека");
$I->see("Платёж совершён, но в процессе формирования чека возникла непредвиденная ошибка");
$I->see("Вернуться в магазин", "a");
