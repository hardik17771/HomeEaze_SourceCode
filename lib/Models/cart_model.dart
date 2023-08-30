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
  late int quantity;
  Item({
    required this.name,
    required this.quantity,
  });
}

List<Service> services = [
  Service(
    name: "Dry Clean",
    image: AppAssets.dryCleanServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRTS', quantity: 0),
      Item(name: "TROUSERS", quantity: 0),
      Item(name: 'BLAZERS', quantity: 0),
      Item(name: "WOMEN SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
      Item(name: "CARPET", quantity: 0),
    ],
  ),
  Service(
    name: "Ironing",
    image: AppAssets.ironingServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRTS', quantity: 0),
      Item(name: "TROUSERS", quantity: 0),
      Item(name: 'BLAZERS', quantity: 0),
      Item(name: "WOMEN SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
      Item(name: "CARPET", quantity: 0),
    ],
  ),
  Service(
    name: "Wash & Iron",
    image: AppAssets.washAndIronServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRTS', quantity: 0),
      Item(name: "TROUSERS", quantity: 0),
      Item(name: 'BLAZERS', quantity: 0),
      Item(name: "WOMEN SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
      Item(name: "CARPET", quantity: 0),
    ],
  ),
  Service(
    name: "Washing",
    image: AppAssets.washingServiceImage,
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRTS', quantity: 0),
      Item(name: "TROUSERS", quantity: 0),
      Item(name: 'BLAZERS', quantity: 0),
      Item(name: "WOMEN SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
      Item(name: "CARPET", quantity: 0),
    ],
  ),
];
