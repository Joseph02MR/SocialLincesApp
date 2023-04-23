import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class EmailAuth {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  late UserCredential userCredential;

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String photo}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      userCredential.user!.sendEmailVerification();

      userCredential.user?.updateDisplayName(name);
      userCredential.user?.updatePhotoURL(photo);
      logger.i('User registered: ${userCredential.user}');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.w('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.w('The account already exists for that email.');
      }
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      logger.i(email);
      logger.i(password);
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
      /*if (userCredential.user!.emailVerified) {
        return true;
      } else {
        return false;
      }*/
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.w('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.w('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      userCredential = await auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      logger.w(e);
      return false;
    }
  }

  Future<bool> signInWithGitHub() async {
    try {
      // Create a new provider
      GithubAuthProvider githubProvider = GithubAuthProvider();
      userCredential = await auth.signInWithProvider(githubProvider);
      return true;
    } catch (e) {
      logger.w(e);
      return false;
    }
  }
}
