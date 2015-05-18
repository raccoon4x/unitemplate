<?php 
$upoint = basename(__DIR__) ;

$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that pay_one template is works');

$I->amOnPage('/pay/one/'.$upoint); 
$I->seeResponseCodeIs(200);

$I->seeElement("input[name=context]");
$I->seeElement("input[name=Phone]");

$I->cantSeeElement("input[name=Pan]");
$I->cantSeeElement("input[name=CardholderName]");
$I->cantSeeElement("input[name=Email]");
$I->cantSeeElement("select[name=ExpMonth]");
$I->cantSeeElement("select[name=ExpYear]");

$I->seeElement("input[name=cid]");

$I->wantTo('Ensure that CVC2/CVV2 field is exists and have type=password');
$I->seeElement("input",['name' => 'Cvc2','type'=>'password']);

$I->see("Оплатить","button[type=submit]");
$I->seeElement("button#btnBack");

