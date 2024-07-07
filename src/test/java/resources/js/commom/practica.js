function fn(data){
    var temp = data.username + ":" + data.password;
    var Base64 = Java.type('java.util.Base64');
    var encode = Base64.getEncoder().encodeToString(temp.toString().getBytes());
    return 'Basic ' + encode;
}
