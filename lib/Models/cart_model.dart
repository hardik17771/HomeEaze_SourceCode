import 'package:flutter/material.dart';

class Service {
  final String name;
  final List<Item> items;

  Service({required this.name, required this.items});
}

class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});
}

List<Service> services = [
  Service(
    name: 'Service 1',
    items: [
      Item(name: 'Item 1', quantity: 0),
      Item(name: 'Item 2', quantity: 0),
    ],
  ),
  Service(
    name: 'Service 2',
    items: [
      Item(name: 'Item 3', quantity: 0),
      Item(name: 'Item 4', quantity: 0),
    ],
  ),
  // Add more services here...
];


