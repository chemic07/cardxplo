import 'dart:io';

import 'package:cardxplo/common/rounded_button.dart';
import 'package:cardxplo/core/utils.dart';
import 'package:cardxplo/features/auth/controller/auth_controller.dart';
import 'package:cardxplo/features/premiumcards/view/create_premiumcards_view.dart';
import 'package:cardxplo/features/user_profile/controller/user_profile_controller.dart';
import 'package:cardxplo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({super.key});

  @override
  ConsumerState<UserProfileView> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  File? profilePic;

  Future<void> selectProfilePic() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        profilePic = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDetailsProvider).value!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: selectProfilePic,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[800],
                    backgroundImage:
                        profilePic != null
                            ? FileImage(profilePic!)
                            : NetworkImage(user.profilePic)
                                as ImageProvider,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppPalette.buttonBlue,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Text(
              user.name.toUpperCase(),
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),

            RoundedButton(
              buttonText: 'Save',
              onTap: () {
                ref
                    .read(userProfileControllerprovider.notifier)
                    .updateUserProfile(
                      userModel: user,
                      profilePic: profilePic,
                      context: context,
                    );
                showSnackBar(context, "Saved successfully");
              },
            ),
            const SizedBox(height: 20),
            RoundedButton(
              buttonText: 'Buy Premium',
              onTap: () {
                Navigator.push(
                  context,
                  CreatePremiumcardsView.route(),
                );
              },
            ),
            const SizedBox(height: 20),
            RoundedButton(
              buttonText: 'Logout',
              onTap: () {
                ref
                    .read(authControllerProvider.notifier)
                    .logOut(context);
              },
              bgColor: AppPalette.iconGray,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
