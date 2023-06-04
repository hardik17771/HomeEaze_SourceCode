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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  createUser();
  fetchUser('h');
}

Future<void> fetchUser(String userId) async {
  DocumentSnapshot userSnapshot =
  await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userSnapshot.exists) {
    // Access the user data
    String username = userSnapshot.data()!['username'] as String;
    String email = userSnapshot.data()!['email'] as String;

    // Do something with the user data
    print('User ID: $userId, Username: $username, Email: $email');
  } else {
    print('User with ID $userId does not exist.');
  }
}




