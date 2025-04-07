import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:installed_apps/app_info.dart';
// import 'package:android_intent_plus/flag.dart';
import 'package:installed_apps/installed_apps.dart';

class ArView extends StatelessWidget {
  const ArView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          printAllAppNames();
          const packageName = 'com.chemictech.Plantify';

          final intent = AndroidIntent(
            action: 'android.intent.action.MAIN',
            category: 'android.intent.category.LAUNCHER',
            package: packageName,
          );

          try {
            await intent.launch();
          } catch (e) {
            debugPrint('Error launching app: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Could not open Unity app. Please make sure it is installed.',
                ),
              ),
            );
          }
        },
        child: const Text("Open Unity"),
      ),
    );
  }

  Future<void> printAllAppNames() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps();

    for (AppInfo a in apps) {
      print(" (app list${a.name}");
    }
    // AppInfo app = await InstalledApps.getInstalledApps(String id);git
  }
}
