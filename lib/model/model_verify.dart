class ModelVerifyLogin {
  ModelVerifyLogin({
    this.mobile,
    this.password,
  });

  String? mobile;
  String? password;


  Map<String, dynamic> toMap() {
    return {
      'email': mobile,
      'password': password,
    };
  }
  ModelVerifyLogin.fromMap(Map<String, dynamic> map) {
    this.mobile = map['mobile'];
    this.password = map['password'];

  }
}