class OtpModel {
  OtpModel({
    this.mobile,
    this.otp
  });
  String? mobile;
  String? otp;

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
      'otp': otp,
    };
  }
  OtpModel.fromMap(Map<String, dynamic> map) {
    this.otp = map['otp'];
    this.mobile = map['mobile'];
  }
}