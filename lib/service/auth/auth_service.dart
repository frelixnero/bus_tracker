import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // intsance of AuthServics
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _fireBaseAuth.currentUser;
  }

  // sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _fireBaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code} - ${e.message}");
      throw Exception(e.message);
    }
  }

  // register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
    // String name,
    // String phoneNumber,
  ) async {
    try {
      UserCredential userCredential = await _fireBaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // // additional data for firestore
      // await _firestore.collection('users').doc(userCredential.user!.uid).set({
      //   'uid': userCredential.user!.uid,
      //   'email': email,
      //   'name': name,
      //   'phoneNumber': phoneNumber,
      //   'timestamp': DateTime.now(),
      // });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code} - ${e.message}");
      throw Exception(e.message);
    } catch (e) {
      print("General Error: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> saveUserDetails(
    String uid,
    String firstname,
    String lastname,
    String phoneNumber,
  ) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'phoneNumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error saving user details: $e");
      throw Exception("Failed to save user details.");
    }
  }

  // Check if a user's data exists in Firestore
  Future<bool> hasUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      // Check if the document exists and has the required fields
      return doc.exists && doc.data() != null;
    } on FirebaseException {
      return false; // Assume data doesn't exist on error
    }
  }

  // sign out
  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
  }

  // error handling
}
