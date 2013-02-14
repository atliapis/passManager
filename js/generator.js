// JavaScript Document

function returnPassword(displayObj) {
    
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
    var string_length = 8;
    var randomstring = '';
    var charCount = 0;
    var numCount = 0;
    
            for (var i=0; i<string_length; i++) {
                if((Math.floor(Math.random() * 2) == 0) && numCount < 3 || charCount >= 5) {
                    var rnum = Math.floor(Math.random() * 10);
                    randomstring += rnum;
                    numCount += 1;
                } 
              else {
                var rnum = Math.floor(Math.random() * chars.length);
                randomstring += chars.substring(rnum,rnum+1);
                charCount += 1;
            }
        }
            displayObj.value=randomstring ;

   }