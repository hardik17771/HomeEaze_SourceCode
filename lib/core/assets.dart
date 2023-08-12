import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static final locationStarImage = SvgPicture.asset("assets/location_star.svg");
  static final locationPinImage = SvgPicture.asset("assets/location_pin.svg");
  static final orderPlacedBgImage =
      SvgPicture.asset("assets/order_placed_bg.svg");
  static final orderPlacedTickMarkImage = Image.asset("assets/tick_mark.png");

  static final tShirtIcon = SvgPicture.asset("assets/icons/tshirt_icon.svg");
  static final deliveryBoyIcon =
      SvgPicture.asset("assets/icons/delivery_boy_icon.svg");
  static final convenienceFeeIcon =
      SvgPicture.asset("assets/icons/convenience_fee_icon.svg");
  static final locationPinPointIcon =
      SvgPicture.asset("assets/icons/point_pin_icon.svg");

  static final noVendorImage = Image.asset("assets/checkOut.png");
  static final noOrdersImage = Image.asset("assets/checkOut.png");
}
