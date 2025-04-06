import 'package:cardxplo/constants/constants.dart';
import 'package:cardxplo/features/premiumcards/view/add_image_view.dart';
import 'package:cardxplo/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatePremiumcardsView extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const CreatePremiumcardsView(),
  );

  const CreatePremiumcardsView({super.key});

  @override
  State<StatefulWidget> createState() =>
      _CreatePremiumcardsViewState();
}

class _CreatePremiumcardsViewState
    extends State<CreatePremiumcardsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(
        0xFF0D1B2A,
      ), // Deep navy background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create an\nAR Business Card',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                child: Image.asset(AssetsConstants.addCardIcon),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, AddImageView.route());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.buttonBlue,
                  foregroundColor: AppPalette.textWhite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.black),
    );
  }
}
