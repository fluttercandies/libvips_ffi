// Re-export enums from core package to avoid duplication.
// 重新导出 core 包的枚举以避免重复。
export 'package:libvips_ffi_core/libvips_ffi_core.dart'
    show VipsDirection, VipsInterpretation;

/// Image format for casting operations.
enum VipsBandFormat {
  notset(-1),
  uchar(0),
  char_(1),
  ushort(2),
  short_(3),
  uint(4),
  int_(5),
  float_(6),
  complex(7),
  double_(8),
  dpcomplex(9);

  final int value;
  const VipsBandFormat(this.value);
}

/// Blend mode for composite operations.
enum VipsBlendMode {
  clear(0),
  source(1),
  over(2),
  in_(3),
  out(4),
  atop(5),
  dest(6),
  destOver(7),
  destIn(8),
  destOut(9),
  destAtop(10),
  xor_(11),
  add(12),
  saturate(13),
  multiply(14),
  screen(15),
  overlay(16),
  darken(17),
  lighten(18),
  colourDodge(19),
  colourBurn(20),
  hardLight(21),
  softLight(22),
  difference(23),
  exclusion(24);

  final int value;
  const VipsBlendMode(this.value);
}

/// Gravity / compass direction for operations like embed.
enum VipsCompassDirection {
  centre(0),
  north(1),
  east(2),
  south(3),
  west(4),
  northEast(5),
  southEast(6),
  southWest(7),
  northWest(8);

  final int value;
  const VipsCompassDirection(this.value);
}

/// Interesting region for smart crop.
enum VipsInteresting {
  none(0),
  centre(1),
  entropy(2),
  attention(3),
  low(4),
  high(5),
  all(6);

  final int value;
  const VipsInteresting(this.value);
}
