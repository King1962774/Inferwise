import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Logger logger = Logger();

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> registerUser(String email, String username, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );

      final String uid = userCredential.user!.uid;
      final String defaultImageUrl = "https://i.imgur.com/JpK8H6B.png";

      await _firestore.collection("users").doc(uid).set({
        "email": email.trim().toLowerCase(),
        "username": username,
        "profileImageUrl": defaultImageUrl,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      await prefs.setString('email', email.trim().toLowerCase());
      await prefs.setString('profileImageUrl', defaultImageUrl);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      logger.e("Firebase error: ${e.code} - ${e.message}");
      rethrow;
    } on PlatformException catch (e) {
      logger.e("PlatformException al registrar: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      logger.e("Error inesperado al registrar: $e");
      rethrow;
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password.trim(),
      );
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      logger.e("FirebaseAuthException: ${e.code} - ${e.message}");
      return false;
    } on PlatformException catch (e) {
      logger.e("PlatformException: ${e.code} - ${e.message}");
      return false;
    } catch (e) {
      logger.e("Error inesperado al iniciar sesión: $e");
      return false;
    }
  }

  Future<bool> updateUserData(String username) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection("users").doc(user.uid).update({
          "username": username.trim(),
        });
        return true;
      } on FirebaseAuthException catch (e) {
        logger.e("FirebaseAuthException al actualizar: ${e.code} - ${e.message}");
        return false;
      } on PlatformException catch (e) {
        logger.e("PlatformException al actualizar: ${e.code} - ${e.message}");
        return false;
      } catch (e) {
        logger.e("Error al actualizar datos: $e");
        return false;
      }
    }
    return false;
  }
}