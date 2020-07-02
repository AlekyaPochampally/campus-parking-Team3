class GeneratePasswordResetOtpRequest {
  String emailId;

  GeneratePasswordResetOtpRequest({this.emailId});

  GeneratePasswordResetOtpRequest.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailId'] = this.emailId;
    return data;
  }
}