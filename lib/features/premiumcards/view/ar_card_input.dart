import 'dart:io';
import 'package:cardxplo/common/rounded_button.dart';
import 'package:cardxplo/core/core.dart';
import 'package:cardxplo/features/card/widgets/text_field_custom.dart';
import 'package:cardxplo/features/home/view/home_page.dart';
import 'package:cardxplo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cardxplo/features/premiumcards/controller/premium_card_controller.dart';

class ArCardInput extends ConsumerWidget {
  final File? image;
  static route(File image) => MaterialPageRoute(
    builder: (context) => ArCardInput(image: image),
  );
  ArCardInput({super.key, required this.image});

  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController companyNameController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController addressController =
      TextEditingController();
  final TextEditingController descriptionController =
      TextEditingController();
  final TextEditingController websiteUrlController =
      TextEditingController();
  final TextEditingController phoneController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Details')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFieldCustom(
                controller: nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: companyNameController,
                hintText: 'Company Name',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: addressController,
                hintText: 'Address',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: descriptionController,
                hintText: 'Description',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: websiteUrlController,
                hintText: 'Website URL',
              ),
              const SizedBox(height: 12),
              TextFieldCustom(
                controller: phoneController,
                hintText: 'Phone',
              ),
              const SizedBox(height: 20),
              RoundedButton(
                buttonText: "Submit and Pay",
                onTap: () async {
                  // 1. Trigger payment flow
                  final isPaid = await showPaymentDialog(context);

                  // 2. If payment is successful, save the data
                  if (isPaid) {
                    final controller = ref.read(
                      PremiumCardControllerprovider.notifier,
                    );

                    controller.savePrimeCard(
                      image: image,
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      companyName: companyNameController.text,
                      designation: '',
                      website: websiteUrlController.text,
                      description: descriptionController.text,
                      address: addressController.text,
                      context: context,
                      uid: '', // Replace with actual user ID
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Payment failed or cancelled"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showPaymentDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor:
                AppPalette.cardBackground, // Changed dialog box color
            title: Row(
              children: [
                const Icon(Icons.payment, color: Colors.blue),
                const SizedBox(width: 10),
                const Text(
                  "Payment",
                  style: TextStyle(color: AppPalette.textWhite),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Simulate payment now?",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppPalette.textWhite,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.currency_rupee,
                      color: Colors.green,
                    ),
                    const Text(
                      "99",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    HomePage.route(),
                    (route) => false,
                  );
                  showSnackBar(context, "Payment Successful!");
                },

                child: Text(
                  "Pay ₹99",
                  style: TextStyle(color: AppPalette.textWhite),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}
