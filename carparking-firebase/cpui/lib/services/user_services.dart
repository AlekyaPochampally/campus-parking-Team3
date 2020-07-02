import 'package:cpui/beans/requests/authenticate_user_request.dart';
import 'package:cpui/beans/requests/create_user_request.dart';
import 'package:cpui/beans/requests/generate_password_reset_otp_request.dart';
import 'package:cpui/beans/responses/authenticate_user_response.dart';
import 'package:cpui/beans/responses/create_user_response.dart';
import 'package:cpui/services/base_api_service_provider.dart';

class UserServices {

  BaseApiServiceProvider _provider = BaseApiServiceProvider();

  /// API call for creating a new user.
  Future<CreateUserResponse> createUser(CreateUserRequest createUserRequest) async {
    final response = await _provider.post('/users/create', createUserRequest.toJson());
    return CreateUserResponse.fromJson(response);
  }

  /// API call for authenticating users
  Future<AuthenticateUserResponse> authenticate(AuthenticateUserRequest authenticateUserRequest) async {
    final response = await _provider.post('/users/authenticate', authenticateUserRequest.toJson());
    return AuthenticateUserResponse.fromJson(response);
  }

  /// API call for generating OTP
  Future<bool> resetPasswordRequest(GeneratePasswordResetOtpRequest generatePasswordResetOtpRequest) async {
    final response = await _provider.post('/users/reset-password/generate-otp', generatePasswordResetOtpRequest.toJson());
    return response as bool;
  }
}