import 'package:alcohol_check/models/account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signInGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    if (googleSignInAccount == null) {
      return {'result': null, 'error': 'User canceled'};
    }

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      return {'result': AccountData(name: user.displayName ?? "", photoURL: user.photoURL ?? "", uid: user.uid, email: user.email ?? ""), 'error': null};
    } else {
      return {'result': null, 'error': 'User is null'};
    }
  } catch (error) {
    print("Error signing in with Google: $error");
    return {'result': null, 'error': error.toString()};
  }
}
