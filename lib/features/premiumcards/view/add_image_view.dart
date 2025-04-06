import 'dart:io';

import 'package:cardxplo/core/utils.dart';
import 'package:cardxplo/features/premiumcards/view/ar_card_input.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class AddImageView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddImageView());
  const AddImageView({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AddImageViewState();
  }
}

class _AddImageViewState extends State<AddImageView> {
  File? image;

  void onPickImage() async {
    File? pickedImage = await pickimage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Upload the\nBusiness Card",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: onPickImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  dashPattern: [6, 3],
                  color: Colors.white60,
                  strokeWidth: 1.5,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF122144),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child:
                          image == null
                              ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.upload,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Upload Image",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Step 1 of 2",
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    label: "Back",
                    ontap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildButton(
                    label: "Next",
                    ontap: () {
                      if (image != null) {
                        Navigator.push(
                          context,
                          ArCardInput.route(File(image!.path)),
                        );
                      } else {
                        showSnackBar(
                          context,
                          "Please upload an image",
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback ontap,
  }) {
    return OutlinedButton(
      onPressed: ontap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 14,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
