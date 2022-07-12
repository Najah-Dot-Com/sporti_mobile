import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class SocialMedia {
  SocialMedia._();

  static final SocialMedia instance = SocialMedia._();

  factory SocialMedia() => instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<Map<String, dynamic>> facebookLogin() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      ); // by default we request the email and the public profile
      // or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.instance.getUserData();

        ///{
        ///  "name": "Open Graph Test User",
        ///  "email": "open_jygexjs_user@tfbnw.net",
        ///  "picture": {
        ///    "data": {
        ///      "height": 126,
        ///      "url": "https://scontent.fuio21-1.fna.fbcdn.net/v/t1.30497-1/s200x200/8462.jpg",
        ///      "width": 200
        ///    }
        ///  },
        ///  "id": "136742241592917"
        /// }
        return userData;
      } else {
        Logger().e(result.status);
        Logger().e(result.message);
        return {};
      }
    } catch (e) {
      Logger().e(e);
      return {};
    }
  }

  Future<GoogleSignInAccount> googleSignIn() async {
    try {
      await _googleSignIn.signOut();
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount != null) {
        return signInAccount;
      } else {
        throw "error";
      }
    } catch (e) {
      Logger().e(e);
      throw "$e";
    }
  }
}
