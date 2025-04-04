import 'package:cardx/apis/card_api.dart';
import 'package:cardx/apis/user_api.dart';
import 'package:cardx/features/auth/controller/auth_controller.dart';
import 'package:cardx/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerprovider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
      return UserProfileController(
        userApi: ref.watch(userAPIProvider),
        cardApi: ref.watch(cardAPIProvider),
      );
    });

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserID =
      ref.watch(currentUserAccountProvider).value!.$id;
  final userDeatils = ref.watch(userDetailsProvider(currentUserID));

  return userDeatils.value;
});

final getUserDataProvider = FutureProvider((ref) async {
  final userProfileController = ref.watch(
    userProfileControllerprovider.notifier,
  );
  final userData = await userProfileController.getuserData(
    ref.watch(currentUserAccountProvider).value!.$id,
  );
  return userData;
});

class UserProfileController extends StateNotifier<bool> {
  final UserApi _userApi;
  final CardApi _cardApi;
  UserProfileController({
    required UserApi userApi,
    required CardApi cardApi,
  }) : _userApi = userApi,
       _cardApi = cardApi,
       super(false);

  Future<UserModel> getuserData(String uid) async {
    final userData = await _userApi.getUserData(uid);
    return UserModel.fromMap(userData.data);
  }
}
