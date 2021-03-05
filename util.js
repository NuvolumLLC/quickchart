'use strict';
var crypto = require('crypto');
var config = require('./environment/prod.js');
var computeSignature = function(uri,apiSecret,method,nonce,timestamp){

    var data = uri+ "" + method + "" + nonce + "" + "" + timestamp;
    var hmac = crypto.createHmac('sha256',apiSecret);
    var _out = hmac.update(data);
    return _out.digest('base64');

}
exports.computeSignature = computeSignature;

exports.validExternalApiSignature = function(uri,method,apiKey,nonce,signature,timestamp){
    try {
        var apiCreds = config.apiCreds[apiKey];
        if( apiCreds != undefined ){
            var computedSignature = computeSignature(uri,apiCreds.secret,method,nonce,timestamp);
            var computedUrlEncodedSignature = encodeURIComponent(computedSignature);
            return signature == computedSignature || signature == computedUrlEncodedSignature;
        }else{
            return false;
        }
        
    } catch (error) {
        return false;
    }
    
}

var readInt = function(item,defaultVal){
    if( item == undefined || item.trim().length == 0 ){
        return defaultVal
    }
    var theInt = parseInt(item);
    if( isNaN(theInt) ){
        return defaultVal;
    }
    return theInt;
}
exports.readInt = readInt;