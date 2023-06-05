import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> createUser() async {

  CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  DocumentReference newUserDoc = await usersCollection.add({
    'user_name': 'Hardikk',
    'user_mobile': 'hardik@gmail.com',

  });

  String newUserId = newUserDoc.id;
  if (kDebugMode) {
    print('Newly created user ID: $newUserId');
  }
}


Future<void> createOrder() async {
  CollectionReference mainCollectionRef = FirebaseFirestore.instance.collection('orders');
  DocumentReference mainDocumentRef = mainCollectionRef.doc('order_2');

   mainDocumentRef = await mainCollectionRef.add({
    'user_id': 'Value 1',
    'vendor_id': 'Value 2',
  });

  String mainDocumentId = mainDocumentRef.id;
  if (kDebugMode) {
    print('Main Document ID: $mainDocumentId');
  }


  CollectionReference subCollectionRef = mainDocumentRef.collection('order_details');
  DocumentReference subDocumentRef = subCollectionRef.doc('Laundary');
  await subDocumentRef.set({
    'subField1': 'Sub Value 1',
    'subField2': 'Sub Value 2',
  });

  await subDocumentRef.set({
    'subField1': 'Sub Value 3',
    'subField2': 'Sub Value 4',
  });

  print('Sub-documents created successfully.');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  createOrder();
}

Future<void> fetchUser(String userId) async {
  DocumentSnapshot userSnapshot =
  await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userSnapshot.exists) {
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    String username = userData['user_name'] as String;
    String email = userData['user_email'] as String;


    if (kDebugMode) {
      print('User ID: $userId, Username: $username, Email: $email');
    }
  } else {
    if (kDebugMode) {
      print('User with ID $userId does not exist.');
    }
  }
}




