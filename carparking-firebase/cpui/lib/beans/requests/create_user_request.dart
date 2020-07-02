class CreateUserRequest {
  String emailId;
  String password;
  String verifiedPassword;
  String registrationPlate;
  String name;

  CreateUserRequest(
      {this.emailId,
        this.password,
        this.verifiedPassword,
        this.registrationPlate,
        this.name});

  CreateUserRequest.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    password = json['password'];
    verifiedPassword = json['verifiedPassword'];
    registrationPlate = json['registrationPlate'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailId'] = this.emailId;
    data['password'] = this.password;
    data['verifiedPassword'] = this.verifiedPassword;
    data['registrationPlate'] = this.registrationPlate;
    data['name'] = this.name;
    return data;
  }
}