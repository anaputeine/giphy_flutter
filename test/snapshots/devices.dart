import 'package:domain/locale/model/app_language.dart';
import 'package:flutter/widgets.dart';

final class Device {
  final Size size;
  final String name;
  final EdgeInsets safeArea;
  final double textScale;
  final bool isDarkMode;
  final AppLanguage appLanguage;

  const Device({
    required this.size,
    required this.name,
    this.safeArea = EdgeInsets.zero,
    this.textScale = 1.0,
    this.isDarkMode = false,
    this.appLanguage = AppLanguage.en,
  });

  Device copyWith({
    Size? size,
    String? name,
    EdgeInsets? safeArea,
    double? textScale,
    bool? isDarkMode,
    AppLanguage? appLanguage,
  }) => .new(
    size: size ?? this.size,
    name: name ?? this.name,
    safeArea: safeArea ?? this.safeArea,
    textScale: textScale ?? this.textScale,
    isDarkMode: isDarkMode ?? this.isDarkMode,
    appLanguage: appLanguage ?? this.appLanguage,
  );

  String get scenarioLabel => [
    name,
    isDarkMode ? 'dark' : 'light',
    appLanguage.code,
    if (textScale != 1.0) '${textScale}x',
  ].join('__');
}

const _baseDevices = [
  Device(
    size: Size(375.0, 667.0),
    name: 'iphone_8',
    safeArea: .only(top: 20.0),
  ),
  Device(
    size: Size(414.0, 896.0),
    name: 'iphone_11',
    safeArea: .only(top: 48.0, bottom: 34.0),
  ),
  Device(
    size: Size(428.0, 926.0),
    name: 'iphone_12_pro_max',
    safeArea: .only(top: 47.0, bottom: 34.0),
  ),
];

final allScenarios = [
  ..._baseDevices,
  ..._baseDevices.map((device) => device.copyWith(appLanguage: .lv)),
  ..._baseDevices.map((device) => device.copyWith(isDarkMode: true)),
  ..._baseDevices.map((device) => device.copyWith(textScale: 1.6)),
];