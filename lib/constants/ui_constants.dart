import 'package:cardxplo/constants/assets_constants.dart';
import 'package:cardxplo/features/card/widgets/card_list.dart';
import 'package:cardxplo/features/card/widgets/fav_card_list.dart';
import 'package:cardxplo/features/user_profile/view/ar_view.dart';
import 'package:cardxplo/features/user_profile/view/user_profile_view.dart';
import 'package:cardxplo/theme/app_palette.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UiConstants {
  static AppBar appBar() {
    return AppBar(
      toolbarHeight: 70,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsConstants.cardxLogo,

            height: 35,

            // colorFilter: ColorFilter.mode(
            //   Pallete.blueColor,
            //   BlendMode.color,
            // ),
          ),
          SizedBox(width: 10),
          Text(
            "Card X",
            style: TextStyle(
              color: AppPalette.textWhite,
              fontWeight: FontWeight.w500,
              fontSize: 28,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomBarPages = [
    CardList(),
    FavCardList(),
    ArView(),
    UserProfileView(),
  ];
}
