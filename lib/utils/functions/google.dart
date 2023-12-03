import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signInGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return {'result': null, 'error': 'User canceled'};
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User? user = authResult.user;

    print('result');
/* 
    SharedPreferences sharedPrefrence = await SharedPreferences.getInstance();
    sharedPrefrence.setString('user', user!.uid); */

    return {'result': user, 'error': null};
  } catch (error) {
    print("Error signing in with Google: $error");
    return {'result': null, 'error': error.toString()};
  }
}
