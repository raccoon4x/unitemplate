<?php 
$upoint = basename(__DIR__) ;

$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that check_cc template is works');

$I->amOnPage('/pay/check/'.$upoint); 
$I->seeResponseCodeIs(200);
$I->see("Ваш платеж банковской картой совершен успешно");
$I->seeElement("button#btnBack");
