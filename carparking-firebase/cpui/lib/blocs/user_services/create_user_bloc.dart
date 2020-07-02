import 'dart:async';

import 'package:cpui/beans/bloc/response.dart';
import 'package:cpui/beans/requests/create_user_request.dart';
import 'package:cpui/beans/responses/create_user_response.dart';
import 'package:cpui/services/user_services.dart';

class CreateUserBloc {

  UserServices _userServices;
  StreamController _createUserController;
  StreamSink<Response<CreateUserResponse>> get createUserSink => _createUserController.sink;
  Stream<Response<CreateUserResponse>> get createUserStream => _createUserController.stream;

  CreateUserBloc(CreateUserRequest createUserRequest) {
    _createUserController = StreamController<Response<CreateUserResponse>>();
    _userServices = UserServices();
    createNewUser(createUserRequest);
  }

  createNewUser(CreateUserRequest createUserRequest) async {
    createUserSink.add(Response.loading("Setting up an account"));
    try {
      CreateUserResponse createUserResponse = await _userServices.createUser(createUserRequest);
      createUserSink.add(Response.completed(createUserResponse));
    } catch(e) {
      createUserSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _createUserController?.close();
  }
}