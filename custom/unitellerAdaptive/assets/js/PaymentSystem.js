 paymentSystem = {
    getSystemByTwoDigits: function (first2digits) {
        first2digits = parseInt(first2digits, 10);
        if((first2digits >= 40) && (first2digits <= 49)) {
            return 'Visa';
        }
        else if((first2digits >= 51) && (first2digits <= 55)) {
            return 'MasterCard';
        }
        else if(first2digits === 62) {
            return 'ChinaUnionPay';
        }
        else if(first2digits === 36 || first2digits === 38 || first2digits === 39) {
            return 'DinersClubInternational';
        }
        else if(first2digits === 34 || first2digits === 37) {
            return 'AmericanExpress';
        }
        else if(first2digits === 50 || (first2digits >= 56 && first2digits <= 58) 
                || (first2digits + '').slice(0,1) == 6) {
            return 'Maestro';
        }
        else {
            return "";
        }       
    },
    
    getSystemByThreeDigits: function (first3digits) {
        first3digits = parseInt(first3digits, 10);
        if((first3digits >= 300) && (first3digits <= 305) || first3digits === 309) {
            return 'DinersClubInternational';
        }
        else {
            return '';
        }
    },
    
    getSystemByFourDigits: function (first4digits) {
        first4digits = parseInt(first4digits, 10);
        if((first4digits >= 2200) && (first4digits <= 2204)) {
            return 'MIR';
        }
        else if((first4digits >= 2221) && (first4digits <= 2720)) {
            return 'MasterCard';
        }
        else if(first4digits === 7027 || first4digits === 7077 || first4digits === 7018 
            || first4digits === 7002) {
            return 'Shell';
        }
        else if((first4digits >= 3528) && (first4digits <= 3589)) {
            return 'JCB';
        }
        else if(first4digits === 9417) {
            return 'ELCART';
        }
        else {
            return '';
        }
    },
    
    getSystemBySixDigits: function (sixDigits) {
        sixDigits = parseInt(sixDigits, 10);
        if((sixDigits >= 700670) && (sixDigits <= 700699)) {
            return 'BP';
        }
        else if((sixDigits >= 704470) && (sixDigits <= 704499)) {
            return 'SFR';
        }
        else if(sixDigits === 700523 || sixDigits === 700002 || sixDigits === 782546) {
            return 'E100';
        }
        else if(sixDigits === 704310 || sixDigits === 700001) {
            return 'DKV';
        }
        else if((sixDigits >= 710100) && (sixDigits <= 710114)) {
            return 'OMV';
        }
        else if((sixDigits >= 710200) && (sixDigits <= 710214)) {
            return 'ENI';
        }
        else if(sixDigits === 782486) {
            return 'LUKOIL';
        }
	else if((sixDigits >= 905100) && (sixDigits <= 905199)) {
	    return 'MIR';
	}
        else {
            return '';
        }
    }
}
