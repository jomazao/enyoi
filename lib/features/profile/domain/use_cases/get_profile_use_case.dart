import 'package:session_3/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:session_3/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepository;

  GetProfileUseCase({ProfileRepository? profileRepository})
    : _profileRepository = profileRepository ?? ProfileRepositoryImpl();

  Future<String?> call() async {
    final profileImageUrl = await _profileRepository.getProfile();
    return profileImageUrl;
  }
}
