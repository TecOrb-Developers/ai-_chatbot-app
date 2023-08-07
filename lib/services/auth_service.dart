import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign in with google
  Future<bool> signInWithGoogle() async {
    print('sign in with google');
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) return false;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    User? user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    print("User Details ------->>");
    print(user?.displayName);
    print(user?.email);
    print(user?.uid);
    print(user?.phoneNumber);
    print(user?.photoURL);

    return user?.uid.isNotEmpty ?? false;
  }

  //SIGN OUT
  Future<bool> signOut() async {
    print('signout');
    bool isClear = false;
    try {
      await FirebaseAuth.instance.signOut();

      // .whenComplete(() async {
      //   print("LOGGED OUT SUCCESSFULLY");

      //   await GoogleSignIn()
      //       .disconnect()
      //       .then((value) => GoogleSignIn().signOut());
      // });
      final prefs = await SharedPreferences.getInstance();
      isClear = await prefs.clear();
      return isClear;
    } catch (e) {
      print(e);
      return isClear;
    }
  }
}
