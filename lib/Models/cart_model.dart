import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';

class Service {
  final String name;
  final Image image;
  final List<Item> items;
  List<Item> selectedItems;
  Service({
    required this.name,
    required this.image,
    required this.items,
  }) : selectedItems = [];
}

class Item {
  final String name;
  final Image image;
  late int quantity;
  Item({
    required this.name,
    required this.image,
    required this.quantity,
  });
}

Map<String, dynamic> itemImageMap = {
  "SHIRT": AppAssets.shirtIcon,
  "T-SHIRT": AppAssets.tShirtIcon,
  "TROUSER": AppAssets.trouserIcon,
  "BLAZER": AppAssets.blazerIcon,
  "SUIT": AppAssets.suitIcon,
  "SAREE": AppAssets.sareeIcon,
  "CURTAINS": AppAssets.curtainIcon,
  "BEDSHEET": AppAssets.bedsheetIcon,
};

List<Service> services = [
  Service(
    name: "Dry Clean",
    image: AppAssets.dryCleanServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0, image: AppAssets.shirtIcon),
      Item(name: 'T-SHIRT', quantity: 0, image: AppAssets.tShirtIcon),
      Item(name: "TROUSER", quantity: 0, image: AppAssets.trouserIcon),
      Item(name: 'BLAZER', quantity: 0, image: AppAssets.blazerIcon),
      Item(name: "SUIT", quantity: 0, image: AppAssets.suitIcon),
      Item(name: "SAREE", quantity: 0, image: AppAssets.sareeIcon),
      Item(name: "CURTAINS", quantity: 0, image: AppAssets.curtainIcon),
      Item(name: 'BEDSHEET', quantity: 0, image: AppAssets.bedsheetIcon),
    ],
  ),
  Service(
    name: "Ironing",
    image: AppAssets.ironingServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0, image: AppAssets.shirtIcon),
      Item(name: 'T-SHIRT', quantity: 0, image: AppAssets.tShirtIcon),
      Item(name: "TROUSER", quantity: 0, image: AppAssets.trouserIcon),
      Item(name: 'BLAZER', quantity: 0, image: AppAssets.blazerIcon),
      Item(name: "SUIT", quantity: 0, image: AppAssets.suitIcon),
      Item(name: "SAREE", quantity: 0, image: AppAssets.sareeIcon),
      Item(name: "CURTAINS", quantity: 0, image: AppAssets.curtainIcon),
      Item(name: 'BEDSHEET', quantity: 0, image: AppAssets.bedsheetIcon),
    ],
  ),
  Service(
    name: "Wash & Iron",
    image: AppAssets.washAndIronServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0, image: AppAssets.shirtIcon),
      Item(name: 'T-SHIRT', quantity: 0, image: AppAssets.tShirtIcon),
      Item(name: "TROUSER", quantity: 0, image: AppAssets.trouserIcon),
      Item(name: 'BLAZER', quantity: 0, image: AppAssets.blazerIcon),
      Item(name: "SUIT", quantity: 0, image: AppAssets.suitIcon),
      Item(name: "SAREE", quantity: 0, image: AppAssets.sareeIcon),
      Item(name: "CURTAINS", quantity: 0, image: AppAssets.curtainIcon),
      Item(name: 'BEDSHEET', quantity: 0, image: AppAssets.bedsheetIcon),
    ],
  ),
  Service(
    name: "Washing",
    image: AppAssets.washingServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0, image: AppAssets.shirtIcon),
      Item(name: 'T-SHIRT', quantity: 0, image: AppAssets.tShirtIcon),
      Item(name: "TROUSER", quantity: 0, image: AppAssets.trouserIcon),
      Item(name: 'BLAZER', quantity: 0, image: AppAssets.blazerIcon),
      Item(name: "SUIT", quantity: 0, image: AppAssets.suitIcon),
      Item(name: "SAREE", quantity: 0, image: AppAssets.sareeIcon),
      Item(name: "CURTAINS", quantity: 0, image: AppAssets.curtainIcon),
      Item(name: 'BEDSHEET', quantity: 0, image: AppAssets.bedsheetIcon),
    ],
  ),
];
