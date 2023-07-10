import 'package:flutter/material.dart';

class Service {
  final String name;
  final List<Item> items;
  List<Item> selectedItems;

  Service({required this.name, required this.items}): selectedItems = [];

  // int getTotalSelectedItems() {
  //   int total = 0;
  //   for (var item in items) {
  //     total += item.quantity;
  //   }
  //   return total;
  // }
}

class Item {
  final String name;
  late  int quantity;

  Item({required this.name, required this.quantity});
}

List<Service> services = [
  Service(
    name: "Wash + Iron",
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
    name: "Wash Only",
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
    name: "Iron",
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
    name: "Dry Clean",
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
    name: "Stitch",
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

class CartItem {
  final Service service;
  final List<Item> items;

  CartItem({required this.service, required this.items});
}


