import 'package:session_3/features/login_old/data/models/user_model.dart';
import 'package:session_3/features/login_old/data/models/user_password_model.dart';

abstract class RemoteAuthenticationDataSource {
  Future<UserModel>  loginWithEmailPassword({required  UserPasswordModel userPasswordModel, });
}