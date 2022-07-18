import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iiti_go/sign_in/sign_in.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          minimumSize: const Size(double.infinity, 15)),
      icon: const Icon(Icons.logout),
      onPressed: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SignInPage.routeName, (route) => false);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => const SignInPage(),
        //   ),
        // );
        await GoogleSignIn().disconnect();
        FirebaseAuth.instance.signOut();
      },
      label: Text('Logout', style: Theme.of(context).textTheme.headline2),
    );
  }
}
