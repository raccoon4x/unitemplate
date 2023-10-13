Acquirer = {
    getBankByBin: function(bin, logoBlock, cardFront, cardBack) {
        var requestUrl = "/service";
        var data = { bin: bin, command: "getBank" };
        
        $.ajax({
            url: requestUrl,
            type: "POST",
            data: data,
            crossDomain: true
            
        }).done(function(responseJson){
            var response = JSON.parse(responseJson);
            if(response.Result === "0") {
                logoBlock.addClass("bank" + response.Acq);
                cardFront.addClass("card-front-bank-" + response.Acq);
                cardBack.addClass("card-back-bank-" + response.Acq);
            }
            if(response.Result === "3") {
                logoBlock.removeClass();
                cardFront.removeClass();
                cardBack.removeClass();
            }
        });
    }
};