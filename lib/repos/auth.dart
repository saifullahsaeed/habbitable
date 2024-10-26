import 'package:dio/dio.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/utils/api_client.dart';

class AuthRepository {
  final HttpWrapper httpWrapper;
  final String base = "auth/";
  AuthRepository() : httpWrapper = HttpWrapper();

  Future<Response> register(SignupModel signupModel) async {
    return await httpWrapper.post('${base}signup', data: signupModel.toJson());
  }

  Future<Response> login(LoginModel loginModel) async {
    return await httpWrapper.post('${base}login', data: loginModel.toJson());
  }
}
