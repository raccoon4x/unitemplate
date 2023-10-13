var validationClassName = 'invalid';

var lengths = {
    2: paymentSystem.getSystemByTwoDigits,
    3: paymentSystem.getSystemByThreeDigits,
    4: paymentSystem.getSystemByFourDigits,
    6: paymentSystem.getSystemBySixDigits
};
var items = [
    {item: 'Pan', mask: '9999 9999 9999 9999 999', handler: validateCard},
    {item: 'ExpDate', mask: '99/99', handler: validateExpire},
    {item: 'CardholderName', handler: validateHolder},
    {item: 'Cvc2', mask: '9999', handler: validateCvv},
    {item: 'Email', handler: validateEmail},
    {item: 'DestPhoneNum', mask: '+7 (999) 999 9999', handler: validateDestPhoneNum}
];

document.addEventListener("DOMContentLoaded", function() {
    setTimeout(sendPOSTMessage, 500);

    var codeCvc = document.querySelector('#Cvc2');
    if (codeCvc !== null) {
        var style = window.getComputedStyle(codeCvc),
            webkitTextSecurity = style.getPropertyValue('-webkit-text-security');
        if (!webkitTextSecurity) {
            codeCvc.setAttribute('type', 'password');
        }
    }
    var Pan = find('#Pan');
    var bin;
    if(Pan !== null){
        // Pan.addEventListener('change', function () {
        //     var paymentSystem = find('.payment-systems');
        //     for(var i in lengths) {
        //         getPaymentSystemForUnsavedCards(Pan.value, i, paymentSystem);
        //     }
        // });
        Pan.addEventListener('keyup', function (){
            var value = this.value.replace(/ /g,'');
            if(value.length===0){
                hideAllPaymentSystem();
                clearAcquirerInfo();
                bin = '';
                return;
            }

            if(value.length < 6) {
                clearAcquirerInfo();
                bin = '';
            }

            var slicedPan = value.slice(0, 6);
            if( value.length >= 6 && bin !== slicedPan ) {
                bin = slicedPan;
                clearAcquirerInfo();
                Acquirer.getBankByBin(bin, $('#bank-logo'),$('#bank-logo'),$('#bank-logo'));
            }

            if(Pan.value.length===0){
                hideAllPaymentSystem();
            }
            var paymentSystem = find('.payment-systems');
            for(var i in lengths) {
                getPaymentSystemForUnsavedCards(Pan.value, i, paymentSystem);
            }
        });
    }

    items.forEach(function (item) {
        if (document.getElementById(item.item)===null){
            return;
        }
        document.getElementById(item.item).addEventListener('change', item.handler);
        if(item.mask){
            Inputmask({mask: item.mask, jitMasking: true, showMaskOnHover: false}).mask(document.getElementById(item.item));
        }
        if (item.item === 'ExpDate') {
            document.getElementById(item.item).addEventListener('input', function (e){
                if(document.getElementById(item.item).value.length===5){
                    document.getElementById('Cvc2').focus();
                }
            });
        }
    });

    if(document.getElementById('payForm')!==null){
        document.getElementById('payForm').addEventListener('submit', handleSubmitForm);
    }

    if(document.getElementById('returnBtn')!==null) {
        document.getElementById('returnBtn').addEventListener('click', function (e) {
            if(isset('#inputBack')) {
                if (document.getElementById('inputBack').name===""){
                    document.getElementById('inputBack').name = 'back';
                }
                return document.getElementById('inputBack').parentElement.submit();
            }
        })
    }

    if(document.getElementById('EmailCheck')!==null){
        var EmailContainer = document.getElementById('EmailContainer');
        var Email = document.getElementById('Email');
        document.getElementById('EmailCheck').addEventListener('change', (event) => {
            if (event.currentTarget.checked) {
                EmailContainer.style.display = 'block';
                Email.setAttribute('required', 'required');
                Email.removeAttribute('disabled');
            } else {
                EmailContainer.style.display = 'none';
                Email.removeAttribute('required');
                Email.setAttribute('disabled', 'disabled');
            }
        });
    }

    if(document.querySelector('.delete-saved-card') !== null){
        var deleteCard = document.querySelectorAll('.delete-saved-card');
        deleteCard.forEach(function(element) {
            element.addEventListener('click', function (event) {
                    event.stopPropagation();
                    $("#modalDeleteCard").modal();
                    var cid = event.target.dataset.cardId;
                    document.getElementById('cid').value = cid;
            })
        });
    }
});

window.addEventListener('resize', function() {
    sendPOSTMessage();
});

function deleteCard() {
    document.getElementById('cid').removeAttribute('disabled');
    $("input[name=doPay]").val("");
    $('#deleteCard').attr('name', 'deleteCard')[0].form.submit();
}

function validateCard() {
    var cardInput = document.getElementById("Pan");
    if(cardInput === null || cardInput.getAttribute('disabled')!==null){
        return true;
    }
    var value = cardInput.value.replace(/\s/g, '');
    document.querySelector('input[name=Pan]').value = value;
    var cardLuhn = checkLuhn(value);
    var isValid = value.length >= 12 && cardLuhn;
    toggleInputValidation({isValid, input: cardInput});
    return isValid;
}

function validateHolder() {
    var holder = document.getElementById("CardholderName");
    if(holder === null ||holder.getAttribute('disabled')!==null){
        return true;
    }
    var value = holder.value;
    var pattern = new RegExp("^(\\w| |-|\\.|')+$");
    var isValid = pattern.test(value);
    toggleInputValidation({input: holder, isValid});
    return isValid;
}

function validateExpire() {
    var expireInput = document.getElementById("ExpDate");
    if(expireInput === null || expireInput.getAttribute('disabled')!==null){
        return true;
    }
    var value = expireInput.value.split('/');
    var month = value[0];
    var year = value[1];
    document.querySelector('input[name=ExpMonth]').value = month;
    document.querySelector('input[name=ExpYear]').value = year;
    var isValid = month && year;
    if (month > 12){
        isValid = false;
    }
    toggleInputValidation({input: expireInput, isValid});
    return isValid;
}

function validateCvv() {
    var cvvInput = document.getElementById("Cvc2");
    var value = cvvInput.value;
    var isValid = value.length >= 3;
    toggleInputValidation({input: cvvInput, isValid});
    return isValid;
}

function validateEmail() {
    var email = document.getElementById("Email");
    if(!document.getElementById('EmailContainer')){
        return true;
    }
    if(email.getAttribute('disabled')!==null){
        document.querySelector('input[name=Email]').value = getRandomInt(100000,1000000)+'@address.ru';
        return true;
    }
    var value = email.value;
    var re = /^([a-zA-Z0-9_\.\-])+@[^.@\s]+(\.[^.@\s]+)+$/;
    var isValid = re.test(value);
    document.querySelector('input[name=Email]').value = value;
    toggleInputValidation({input: email, isValid});
    return isValid;
}

function validateDestPhoneNum() {
    var destPhoneNumInput = document.querySelector('[name=DestPhoneNum]');
    var destPhoneNum = document.getElementById('DestPhoneNum');
    var value = '+'+destPhoneNum.value.replace(/\D/g, '');
    var isValid = /^\+7\d{10}$/.test(value);
    destPhoneNumInput.value = value;
    toggleInputValidation({input: destPhoneNum, isValid});
    return isValid;
}

function validateEWallet(){
    var EWalletInput = document.getElementById('EWallet');
    var value = EWalletInput.value;
    var isValid = /^[A-Za-z0-9]+$/.test(value);
    toggleInputValidation({input:EWalletInput, isValid});
    return isValid;
}

function toggleInputValidation({input, isValid}) {
    if (isValid) {
        input.classList.remove(validationClassName);
    } else {
        input.classList.add(validationClassName);
    }
}

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function checkLuhn(number) {
    var digit, n, sum, _i, _len, _ref;
    sum = 0;
    _ref = number.split('').reverse();
    for (n = _i = 0, _len = _ref.length; _i < _len; n = ++_i) {
        digit = _ref[n];
        digit = +digit;
        if (n % 2) {
            digit *= 2;
            if (digit < 10) {
                sum += digit;
            } else {
                sum += digit - 9;
            }
        } else {
            sum += digit;
        }
    }
    return sum % 10 === 0;
}


function handleSubmitForm(event) {
    var isValid = validateInputs();
    if (!isValid) {
        event.preventDefault();
    }
}

function validateInputs() {
    hideErrorBlock();
    var errorFields = [];
    var isValidCard = validateCard();
    if (!isValidCard){
        errorFields.push('Номер карты');
    }
    var isValidHolder = validateHolder();
    if(!isValidHolder){
        errorFields.push('Имя держателя карты');
    }
    var isValidExpire = validateExpire();
    if(!isValidExpire){
        errorFields.push('Срок действия');
    }
    var isValidCvv = validateCvv();
    if(!isValidCvv){
        errorFields.push('Код CVC2 или CVV2');
    }
    var isValidEmail = validateEmail();
    if(!isValidEmail){
        errorFields.push('Email');
    }
    if (document.getElementById('DestPhoneNum')) {
        var isValidDestPhone = validateDestPhoneNum();
        if (!isValidDestPhone) {
            errorFields.push('Номер телефона для пополнения');
        }
    }else{
        isValidDestPhone = true;
    }
    if(document.getElementById('EWallet')){
        var isValidEWallet = validateEWallet();
        if(!isValidEWallet){
            errorFields.push('Номер электронного кошелька');
        }
    }else{
        isValidEWallet = true;
    }
    if (errorFields.length>0){
        showErrorBlock("Вы неправильно заполнили поля: " + errorFields.join(', ') + ".")
    }
    return isValidExpire && isValidCvv && isValidCard && isValidHolder && isValidEmail && isValidDestPhone && isValidEWallet;
}

function hideErrorBlock()
{
    var el = document.getElementById('formErrors');
    if (el === null){
        return;
    }
    el.style.display = 'none';
}

function showErrorBlock(text)
{
    var el = document.getElementById('formErrors');
    if (el === null){
        return;
    }
    el.style.display = 'block';
    el.innerText = text;
}

function show(id) {
    var el = document.getElementById(id);
    if (el === null){
        return;
    }
    el.style.display = 'block';
}

function hide(id) {
    var el = document.getElementById(id);
    if (el === null){
        return;
    }
    el.style.display = 'none';
}

function detectPaymentSystem(pan) {

}

function getPaymentSystemForUnsavedCards(pan, index, systemLogoElement) {
    if (pan.length >= index) {
        var system = lengths[index](pan.slice(0, index));
        if (system !== "") {
            setSystemClass(system, systemLogoElement);
        }
    }
}

function setSystemClass(system, element) {
    hideAllPaymentSystem();
    showPaymentSystem(system);
}
function hideAllPaymentSystem(){
    hidePaymentSystem('visa');
    hidePaymentSystem('mastercard');
    hidePaymentSystem('mir');
}
function hidePaymentSystem(system){
    find('.payment-systems').classList.remove(system);
}
function showPaymentSystem(system){
    system = system.toLowerCase();
    find('.payment-systems').classList.add(system);
}

function clearAcquirerInfo() {
    find('#bank-logo').classList = '';
}

function find(selector) {
    return document.querySelector(selector);
}

function sendPOSTMessage(){
    if(!document.body.offsetHeight) { return; }

    var win = parent,
        height = document.body.offsetHeight + 100;
    if (typeof win.postMessage != 'undefined') {
        win.postMessage(
            height,
            '*'
        );
    }
}

function isset(selector){
    return document.querySelector(selector) !== null;
}