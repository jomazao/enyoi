import 'package:image_picker/image_picker.dart';

abstract class ProfileRepository {
  Future<void> updateProfileImage(String imageUrl);
  Future<String> uploadProfileImage(XFile image, );
  Future<XFile?> pickImageFromGallery();
}