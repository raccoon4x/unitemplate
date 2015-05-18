<?php 
$upoint = basename(__DIR__) ;

$I = new FunctionalTester($scenario);
$I->wantTo('Ensure that pay_cc template is works');

$I->amOnPage('/pay/do/'.$upoint); 
$I->seeResponseCodeIs(200);

