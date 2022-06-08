import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_time/app/services/auth/auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> signIn() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication; // googleAuth is null if user is not signed in

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      GoogleSignIn().signOut(),
      FirebaseAuth.instance.signOut(),
    ]);
  }
}
