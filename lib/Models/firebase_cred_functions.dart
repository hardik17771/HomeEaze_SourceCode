import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> createUser() async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    DocumentReference newUserDoc = usersCollection.doc(currentUser.uid);


    DocumentSnapshot userSnapshot = await newUserDoc.get();
    if (!userSnapshot.exists) {
      // Create the user document with the authenticated user's ID
      await newUserDoc.set({
        'user_name': currentUser.displayName,
        'user_email': currentUser.email,
      });
    }

    // Get the user's address
    // String address = await _getUserAddress();

    // Update the 'address' field in the user document
    await newUserDoc.update({'address': address});

    String newUserId = newUserDoc.id;
    if (kDebugMode) {
      print('Newly created user ID: $newUserId');
    }
  } else {
    if (kDebugMode) {
      print('No authenticated user found.');
    }
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
    'bed-sheets': '12',
    'pillow_cover': '2',
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

Future<void> _postLocationToFirebase(double latitude, double longitude) async {
  try {
    await databaseReference.child('locations').push().set({
      'latitude': latitude,
      'longitude': longitude,
    });
  } catch (e) {
    // Handle any errors that occur while posting to Firebase
    print('Error posting location to Firebase: $e');
  }
}





