import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';

import '../models/toilet.dart';
import './bitmapFromSvg.dart';

bool isOpen(List<int> openHours) {
  if (openHours[0] >= openHours[1]) {
    return false;
  }

  DateTime dateTime = DateTime.now();
  int curr = (dateTime.hour * 60) + dateTime.minute;
  int start = 0;
  int end = 1;

  if (openHours.length > 2) {
    start = (dateTime.weekday - 1) * 2;
    end = start + 1;
  }

  if (openHours[start] <= curr && curr <= openHours[end]) {
    return true;
  } else {
    return false;
  }
}

Future<BitmapDescriptor> determineIcon(
    Category category, List<int> openHours, BuildContext context) async {
  String result = "";

  switch (category) {
    case Category.GENERAL:
      result += "general";
      break;
    case Category.SHOP:
      result += "shop";
      break;
    case Category.RESTAURANT:
      result += "restaurant";
      break;
    case Category.GAS_STATION:
      result += "gas_station";
      break;
    case Category.PORTABLE:
      result += "portable";
      break;
    default:
      result += "general";
      break;
  }

  if (isOpen(openHours)) {
    result += "_open";
  } else {
    result += "_closed";
  }

  return await bitmapDescriptorFromSvgAsset(
      context, 'assets/icons/pin/$result.svg');
}