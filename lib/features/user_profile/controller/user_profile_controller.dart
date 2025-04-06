import 'dart:io';

import 'package:cardxplo/apis/card_api.dart';
import 'package:cardxplo/apis/storage_api.dart';
import 'package:cardxplo/apis/user_api.dart';
import 'package:cardxplo/core/core.dart';
import 'package:cardxplo/features/auth/controller/auth_controller.dart';
import 'package:cardxplo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerprovider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
      return UserProfileController(
        userApi: ref.watch(userAPIProvider),
        cardApi: ref.watch(cardAPIProvider),
        storageApi: ref.watch(storageApiProvider),
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
  final StorageApi _storageApi;

  UserProfileController({
    required UserApi userApi,
    required CardApi cardApi,
    required StorageApi storageApi,
    Ref? ref,
  }) : _userApi = userApi,
       _cardApi = cardApi,
       _storageApi = storageApi,

       super(false);

  Future<UserModel> getuserData(String uid) async {
    final userData = await _userApi.getUserData(uid);
    return UserModel.fromMap(userData.data);
  }

  void updateUserProfile({
    required UserModel userModel,
    required BuildContext context,
    required File? profilePic,
  }) async {
    state = true;

    if (profilePic != null) {
      //uploading the image
      final profilePicUrl = await _storageApi.uploadImage(profilePic);
      //replacing the image
      userModel = userModel.copyWith(profilePic: profilePicUrl);
    }
    final res = await _userApi.updateUserData(userModel);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => print("User updated successfully"),
    );
  }
}
