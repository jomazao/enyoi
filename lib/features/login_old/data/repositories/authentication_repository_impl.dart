import 'package:session_3/features/login_old/data/data_sources/firebase_remote_authentication_data_source.dart';
import 'package:session_3/features/login_old/data/data_sources/local_authentication_data_source.dart';
import 'package:session_3/features/login_old/data/data_sources/remote_authentication_data_source.dart';
import 'package:session_3/features/login_old/data/models/user_password_model.dart';
import 'package:session_3/features/login_old/domain/entities.dart/user.dart';
import 'package:session_3/features/login_old/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final RemoteAuthenticationDataSource _remoteAutheticationDataSource;
  final LocalAuthenticationDataSource _localAuthenticationDataSource;

  AuthenticationRepositoryImpl({
    RemoteAuthenticationDataSource? remoteAutheticationDataSource,
    LocalAuthenticationDataSource? localAuthenticationDataSource,
  }) : _remoteAutheticationDataSource =
           remoteAutheticationDataSource ?? FirebaseRemoteAuthenticationDataSource(),
       _localAuthenticationDataSource =
           localAuthenticationDataSource ?? LocalAuthenticationDataSource();

  @override
  Future<String> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<String> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() async {
    final sessionToken = await _localAuthenticationDataSource.getSessionToken();
    return sessionToken != null;
  }

  @override
  Future<bool> logOut() async {
    await _localAuthenticationDataSource.clearSession();

    return true;
  }

  @override
  Future<bool> registerWithEmailAndPassword(String email, String password) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signIUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print('Repository Signing up with email: $email and password: $password');
    final UserPasswordModel userPasswordModel = UserPasswordModel(
      email: email,
      password: password,
    );

    final userModel = await _remoteAutheticationDataSource
        .loginWithEmailPassword(userPasswordModel: userPasswordModel);

    return User.fromModel(userModel);
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut()async {
    // TODO: implement signOut
      await _localAuthenticationDataSource.clearSession();

  }

  @override
  Future<void> saveSession(String token) async {
    await _localAuthenticationDataSource.saveSession(token);
  }
}
