import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<Either<String, User>> loginWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An unknown error occurred');
    }
  }

  Future<Either<String, User>> registerWithEmail(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An unknown error occurred');
    }
  }

  Future<Either<String, User>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return const Left('Google sign in was canceled');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      /// <-- Check if the user exists in the database -->
      if (!(userDoc.exists && userDoc.data() != null)) {
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          username: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          userType: UserType.user,
          phoneNumber: userCredential.user!.phoneNumber,
          profileImage: userCredential.user!.photoURL,
          createdAt: DateTime.now(),
          favList: [],
          orderHistory: [],
        );
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
      }

      return Right(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An unknown error occurred');
    }
  }

  Future<Either<String, void>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? 'An unknown error occurred');
    }
  }

  Future<Either<String, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> getCurrentUser(String uid) async {
    try {
      ///<--- Get user data from the database --->///
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      /// <-- Check if the user exists in the database -->
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        /// <-- Convert the Map to a UserModel --->///
        UserModel user = UserModel.fromJson(userData);

        ///< --- Return the user in the Right side (success) -->///
        return Right(user);
      } else {
        /// <--- Return error message in the Left side (failure) --->///
        return const Left("User not found");
      }
    } catch (e) {
      /// <--- Return error message in the Left side (failure) --->///
      return Left("Error fetching user data: $e");
    }
  }

  Future<Either<String, UserModel>> setUser(User user) async {
    try {
      ///<--- Get user data from the database --->///
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      /// <-- Check if the user exists in the database -->
      if (!(userDoc.exists && userDoc.data() != null)) {
        UserModel userModel = UserModel(
          id: user.uid,
          username: user.displayName ?? ' ',
          email: user.email!,
          userType: UserType.user,
          phoneNumber: user.phoneNumber ?? " ",
          profileImage: user.photoURL ?? " ",
          createdAt: DateTime.now(),
          favList: [],
          orderHistory: [],
        );
        await user.sendEmailVerification();

        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .set(userModel.toJson());

        ///< --- Return the user in the Right side (success) -->///
        return Right(userModel);
      } else {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        /// <-- Convert the Map to a UserModel --->///
        UserModel user = UserModel.fromJson(userData);

        ///< --- Return the user in the Right side (success) -->///
        return Right(user);
      }
    } catch (e) {
      /// <--- Return error message in the Left side (failure) --->///
      return Left("Error set user data: $e");
    }
  }
}
