import 'package:chili_text_scale_factor/chili_text_scale_factor.dart';
import 'package:flutter/material.dart';
import 'package:presentation/design/design_src.dart';
import 'package:presentation/generated/l10n/app_localizations.g.dart';

import 'devices.dart';

typedef WidgetWrapper = Widget Function(Widget child);

WidgetWrapper testMaterialWrapper(Device device) =>
        (child) => DesignSystemTheme(
      lightSystemData: DesignSystemThemeData.light(device.textScale),
      darkSystemData: DesignSystemThemeData.dark(device.textScale),
      isDarkMode: device.isDarkMode,
      isTestEnv: true,
      child: MaterialApp(
        home: child,
        builder: (context, widget) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            padding: device.safeArea,
            viewPadding: device.safeArea,
          ),
          child: LimitTextScaleFactorWrapper(
            child: widget ?? emptyWidget,
          ),
        ),
        title: 'Test',
        locale: Locale(device.appLanguage.code),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );