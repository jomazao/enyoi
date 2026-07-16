import 'package:session_3/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:session_3/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfilePictureUseCase {
  final ProfileRepository _profileRepository;
  UpdateProfilePictureUseCase({ProfileRepository? profileRepository})
    : _profileRepository = profileRepository ?? ProfileRepositoryImpl();

  Future<String?> call() async {
    /// Pick an image from the gallery. - Almacenamiento local del dispositivo
    final image = await _profileRepository.pickImageFromGallery();
    if (image != null) {
      /// Subir la imagen seleccionada a Firebase Storage y obtener la URL
      final imageUrl = await _profileRepository.uploadProfileImage(image);

      /// Actualizar la URL de la imagen de perfil en FIRESTORE
      await _profileRepository.updateProfileImage(imageUrl);
      return imageUrl;
    } else {
      print('No image selected.');

      return null;
    }
  }
}
