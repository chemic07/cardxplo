import 'dart:io';

import 'package:cardxplo/apis/premium_card_api.dart';
import 'package:cardxplo/apis/storage_api.dart';
import 'package:cardxplo/core/utils.dart';
import 'package:cardxplo/features/auth/controller/auth_controller.dart';
import 'package:cardxplo/models/premium_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final PremiumCardControllerprovider =
    StateNotifierProvider<PremiumCardController, bool>((ref) {
      final premiumCardApi = ref.watch(premiumCardApiProvider);
      return PremiumCardController(
        premiumCardApi: premiumCardApi,
        ref: ref,
        storageApi: ref.watch(storageApiProvider),
      );
    });

class PremiumCardController extends StateNotifier<bool> {
  final Ref _ref;
  final PremiumCardApi _premiumCardApi;
  final StorageApi _storageApi;

  PremiumCardController({
    required Ref ref,
    required PremiumCardApi premiumCardApi,
    required StorageApi storageApi,
  }) : _premiumCardApi = premiumCardApi,
       _ref = ref,
       _storageApi = storageApi,
       super(false);

  void savePrimeCard({
    required File? image,
    required String name,
    required String email,
    required String phone,
    required String companyName,
    required String designation,
    required String website,
    required String description,
    required String address,
    required BuildContext context,
    required String uid,
  }) async {
    if (state) return;
    state = true;

    if (image == null || !image.existsSync()) {
      showSnackBar(context, "Please select a valid image.");
      state = false; // Reset state if validation fails
      return;
    }

    final user = _ref.watch(currentUserDeatilsProvider).value!;

    final imageUrl = await _storageApi.uploadImage(image);

    PremiumCardModel premiumCardModel = PremiumCardModel(
      id: "",
      name: name,
      companyName: companyName,
      email: email,
      address: address,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
      description: description,
      websiteUrl: website,
      phone: phone,
      uid: user.uid,
    );

    final res = await _premiumCardApi.savePremiumCard(
      premiumCardModel,
    );

    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => print("save card"),
    );
    // Validate image
  }
}
