import 'package:image_picker/image_picker.dart';

class ProfileLocalDataSource {

  final ImagePicker _imagePicker;

  ProfileLocalDataSource({ImagePicker? imagePicker}) : _imagePicker = imagePicker ?? ImagePicker(); 



  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      // Handle any errors that may occur during image picking
      print('Error picking image: $e');
      return null;
    }
  }



}