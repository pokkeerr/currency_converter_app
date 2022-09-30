import 'package:flutter/material.dart';

import 'colors_manager.dart';
import 'fonts_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorMgr.primary,
      primaryColorLight: ColorMgr.primaryOpacity70,
      primaryColorDark: ColorMgr.darkPrimary,
      disabledColor:
          ColorMgr.grey1, // will be used incase of disabled button for example
      // ignore: deprecated_member_use
      accentColor: ColorMgr.grey,
      // card view theme
      cardTheme: CardTheme(
          color: ColorMgr.white,
          shadowColor: ColorMgr.grey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorMgr.primary,
          elevation: AppSize.s4,
          shadowColor: ColorMgr.primaryOpacity70,
          titleTextStyle: regualerTextStyle(
              color: ColorMgr.white, fontSize: FontSizeMgr.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorMgr.grey1,
          buttonColor: ColorMgr.primary,
          splashColor: ColorMgr.primaryOpacity70),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: regualerTextStyle(color: Colors.white),
              primary: ColorMgr.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      // Text theme
      textTheme: TextTheme(
          headline1: semiBoldTextStyle(
              color: ColorMgr.darkGrey, fontSize: FontSizeMgr.s16),
          subtitle1: mediumTextStyle(
              color: ColorMgr.lightGrey, fontSize: FontSizeMgr.s14),
          subtitle2: mediumTextStyle(
              color: ColorMgr.primary, fontSize: FontSizeMgr.s14),
          caption: regualerTextStyle(color: ColorMgr.grey1),
          bodyText1: regualerTextStyle(color: ColorMgr.grey)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: regualerTextStyle(color: ColorMgr.grey1),

        // label style
        labelStyle: mediumTextStyle(color: ColorMgr.darkGrey),
        // error style
        errorStyle: regualerTextStyle(color: ColorMgr.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorMgr.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorMgr.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorMgr.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorMgr.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
