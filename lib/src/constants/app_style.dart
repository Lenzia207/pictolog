// Padding constants
import 'package:flutter/material.dart';

const double p2 = 2;
const double p3 = 3;
const double p4 = 4;
const double p6 = 6;
const double p8 = 8;
const double p10 = 10;
const double p12 = 12;
const double p14 = 14;
const double p16 = 16;
const double p18 = 18;
const double p20 = 20;
const double p22 = 22;
const double p24 = 24;
const double p30 = 30;
const double p40 = 40;

/// Minimum size of tappable elements.
const double touchTarget = 44;

class Space {
  static const SizedBox h2 = SizedBox(height: p2);
  static const SizedBox h3 = SizedBox(height: p3);
  static const SizedBox h4 = SizedBox(height: p4);
  static const SizedBox h6 = SizedBox(height: p6);
  static const SizedBox h8 = SizedBox(height: p8);
  static const SizedBox h10 = SizedBox(height: p10);
  static const SizedBox h12 = SizedBox(height: p12);
  static const SizedBox h14 = SizedBox(height: p14);
  static const SizedBox h16 = SizedBox(height: p16);
  static const SizedBox h18 = SizedBox(height: p18);
  static const SizedBox h20 = SizedBox(height: p20);
  static const SizedBox h22 = SizedBox(height: p22);
  static const SizedBox h24 = SizedBox(height: p24);
  static const SizedBox h40 = SizedBox(height: p40);

  static const SizedBox w4 = SizedBox(width: p4);
  static const SizedBox w6 = SizedBox(width: p6);
  static const SizedBox w8 = SizedBox(width: p8);
  static const SizedBox w10 = SizedBox(width: p10);
  static const SizedBox w12 = SizedBox(width: p12);
  static const SizedBox w14 = SizedBox(width: p14);

  Space._();
}

/// Corner radius constants.
/// Inputs 14, tiles 16, cards 18, sheets 28, buttons fully rounded.
class AppRadius {
  static const double sm = 10;
  static const double thumbnail = 12;
  static const double input = 14;
  static const double tile = 16;
  static const double card = 18;
  static const double tileLarge = 20;
  static const double emptyCard = 24;
  static const double sheet = 28;
  static const double pill = 100;

  AppRadius._();
}
