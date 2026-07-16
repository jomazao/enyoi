import 'package:image_picker/image_picker.dart';
import 'package:session_3/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:session_3/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:session_3/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
final ProfileLocalDataSource _localDataSource;
final ProfileRemoteDataSource _remoteDataSource;
  ProfileRepositoryImpl({ProfileLocalDataSource? localDataSource, ProfileRemoteDataSource? remoteDataSource})
      : _localDataSource = localDataSource ?? ProfileLocalDataSource(),
        _remoteDataSource = remoteDataSource ?? ProfileRemoteDataSource();

  @override
  Future<void> updateProfileImage(String imagePath) async {
    await _remoteDataSource.updateProfileImage(imagePath);
  }


  /// TODO: CONVERTIR DE XFILE A FILE
  @override
  Future<XFile?> pickImageFromGallery() async {
    final image = await _localDataSource.pickImageFromGallery();
    return image;
  }
  
  /// TODO: CONVERTIR DE XFILE A FILE
  @override
  Future<String> uploadProfileImage(XFile image) {
    return _remoteDataSource.uploadProfileImage(image);
  }
  
  @override
  Future<String?> getProfile() {
    return _remoteDataSource.getProfile();
  }
}