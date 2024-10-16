import 'package:flutter/material.dart';

class ColorFamily {
  /// Primary (Main green)
  ///
  /// 서비스의 브랜드 컬러를 기반으로 한 앱 서비스 메인 컬러입니다.
  /// green 컬러는 00서비스의 메인 컬러입니다.
  /// green050이 브랜드 컬러이며, 필요에 따라 다른 명도의 컬러를 적절하게 사용합니다.
  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      10: Color(0xFFE5F9ED),
      20: Color(0xFFBFEFD3),
      30: Color(0xFF94E5B7),
      40: Color(0xFF5FDB99),
      50: Color(_primaryValue),
      60: Color(0xFF00CA6A),
      70: Color(0xFF00B95F),
      80: Color(0xFF00B95F),
    },
  );
  static const _primaryValue = 0xFF20D281;

  /// Secondary (Main cobalt)
  ///
  /// 서비스의 브랜드 컬러를 기반으로 한 앱 서비스 메인 컬러입니다.
  /// cobalt050이 브랜드 컬러이며, 필요에 따라 다른 명도의 컬러를 적절하게 사용합니다.
  static const MaterialColor secondary = MaterialColor(
    _secondaryValue,
    <int, Color>{
      10: Color(0xFFE8E9FB),
      20: Color(0xFFC4C8F5),
      30: Color(0xFF9BA4EE),
      40: Color(0xFF6F80E8),
      50: Color(_secondaryValue),
      60: Color(0xFF3A56E0),
      70: Color(0xFF2646E0),
      80: Color(0xFF1A39D3),
    },
  );
  static const _secondaryValue = 0xFF4A64E3;

  /// Sub (red)
  ///
  /// 강조, 경고 등의 목적으로 보조적으로 사용하는 컬러입니다.
  static const MaterialColor sub = MaterialColor(
    _subValue,
    <int, Color>{
      10: Color(0xFFFFEBEC),
      20: Color(0xFFFFCCCD),
      30: Color(0xFFFE9890),
      40: Color(0xFFF86D64),
      50: Color(_subValue),
    },
  );
  static const _subValue = 0xFFFF4A39;
}
