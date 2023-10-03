import 'dart:convert';
import 'package:homeeaze_sourcecode/core/assets.dart';

class Service {
  final String name;
  final List<Item> items;
  List<Item> selectedItems;
  Service({
    required this.name,
    required this.items,
    required this.selectedItems,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'items': items.map((x) => x.toMap()).toList(),
      'selectedItems': selectedItems.map((x) => x.toMap()).toList(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      name: map['name'] as String,
      items: List<Item>.from(
        (map['items'] as List<dynamic>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
      selectedItems: List<Item>.from(
        (map['selectedItems'] as List<dynamic>).map<Item>(
          (x) => Item.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Item {
  final String name;
  late int quantity;
  Item({
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      name: map['name'] as String,
      quantity: map['quantity'] as int,
    );
  }
}

Map<String, dynamic> serviceImageMap = {
  "Dry Clean": AppAssets.dryCleanServiceImage,
  "Ironing": AppAssets.ironingServiceImage,
  "Wash & Iron": AppAssets.washAndIronServiceImage,
  "Washing": AppAssets.washingServiceImage,
};

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
    selectedItems: [],
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRT', quantity: 0),
      Item(name: "TROUSER", quantity: 0),
      Item(name: 'BLAZER', quantity: 0),
      Item(name: "SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
    ],
  ),
  Service(
    name: "Ironing",
    selectedItems: [],
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRT', quantity: 0),
      Item(name: "TROUSER", quantity: 0),
      Item(name: 'BLAZER', quantity: 0),
      Item(name: "SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
    ],
  ),
  Service(
    name: "Wash & Iron",
    selectedItems: [],
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRT', quantity: 0),
      Item(name: "TROUSER", quantity: 0),
      Item(name: 'BLAZER', quantity: 0),
      Item(name: "SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
    ],
  ),
  Service(
    name: "Washing",
    selectedItems: [],
    items: [
      Item(name: "SHIRT", quantity: 0),
      Item(name: 'T-SHIRT', quantity: 0),
      Item(name: "TROUSER", quantity: 0),
      Item(name: 'BLAZER', quantity: 0),
      Item(name: "SUIT", quantity: 0),
      Item(name: "SAREE", quantity: 0),
      Item(name: "CURTAINS", quantity: 0),
      Item(name: 'BEDSHEET', quantity: 0),
    ],
  ),
];
