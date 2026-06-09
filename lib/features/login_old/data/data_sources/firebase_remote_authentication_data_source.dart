import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:session_3/features/login_old/data/data_sources/remote_authentication_data_source.dart';
import 'package:session_3/features/login_old/data/models/user_model.dart';
import 'package:session_3/features/login_old/data/models/user_password_model.dart';

class FirebaseRemoteAuthenticationDataSource extends RemoteAuthenticationDataSource {

    final FirebaseAuth _auth;

    FirebaseRemoteAuthenticationDataSource({ FirebaseAuth? firebaseAuth}):
     _auth= firebaseAuth ?? FirebaseAuth.instance;

    
  @override
  Future<UserModel> loginWithEmailPassword({required UserPasswordModel userPasswordModel})async {

    print('haciendo login a firebase con: email:${userPasswordModel.email} password:${userPasswordModel.password}');
       final credentials = await _auth.createUserWithEmailAndPassword(
      email: userPasswordModel.email,
      password: userPasswordModel.password,
    );

    print(credentials.user);
    return UserModel(
      email: credentials.user!.email!,
      id: credentials.user!.uid,
      username: '',
      firstName: '',
      lastName: '',
      gender: '',
      image: '',
      accessToken: '',
      newId: '',
    );
  }



  
}