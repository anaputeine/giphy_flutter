import 'package:flutter/material.dart';
import 'package:giphy_flutter/l10n/app_localizations.dart';

import 'devices.dart';

typedef WidgetWrapper = Widget Function(Widget child);

WidgetWrapper testMaterialWrapper(Device device) =>
        (child) => MaterialApp(
      home: child,

      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          padding: device.safeArea,
          viewPadding: device.safeArea,


          textScaler:
          TextScaler.linear(device.textScale),
        ),
        child: widget ?? const SizedBox.shrink(),
      ),

      title: 'Test',

      locale: device.locale,

      localizationsDelegates:
      AppLocalizations.localizationsDelegates,

      supportedLocales:
      AppLocalizations.supportedLocales,
    );