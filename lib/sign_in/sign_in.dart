import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiti_go/home_screen/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iiti_go/widgets/custom_snackbar.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/SignInPage';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var isLoading = false;

  Future<UserCredential?> signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final googleAuthCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      return await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);
    } else {
      return null;
    }
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    setState(() {
      isLoading = false;
    });
  }

  onPressedgoogleSignIn() {
    signInWithGoogle().then((value) {
      if (value != null) {
        if (value.user!.email!.contains('@iiti.ac.in') ||
            value.user!.email!.contains('kiranchowdarapu7')) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        } else {
          logout();
          CustomSnackBar(
                  content: 'Please login with Institute Gmail Id',
                  context: context)
              .snackbar();
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }).onError<PlatformException>((error, _) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar(
              content: 'Please check your Internet connection',
              context: context)
          .snackbar();
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      CustomSnackBar(
              content: 'There is some issue please try again', context: context)
          .snackbar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              strokeWidth: 6,
            ))
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('iiti Go',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1),
                    const SizedBox(height: 40),
                    Text('Hey! Welcome',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 17,
                            letterSpacing: 0.0,
                            shadows: [],
                            fontWeight: FontWeight.w100)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 15, 45),
                      child: Text(
                          'Know the caddy details and many more at any time, anywhere. Please login with college mail Id.',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.grey.shade400,
                                  shadows: [])),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 45)),
                        onPressed: onPressedgoogleSignIn,
                        child: Text('Sign in with Google',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ))),
                  ],
                ),
              ),
            ),
    );
  }
}
