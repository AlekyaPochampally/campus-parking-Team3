class CreateUserResponse {

  String emailId;
  String name;
  String registrationPlate;

  CreateUserResponse({this.emailId, this.name, this.registrationPlate});

  CreateUserResponse.fromJson(Map<String, dynamic> json) {
    emailId = json['emailId'];
    name = json['name'];
    registrationPlate = json['registrationPlate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailId'] = this.emailId;
    data['name'] = this.name;
    data['registrationPlate'] = this.registrationPlate;
    return data;
  }
}
