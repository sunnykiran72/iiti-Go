import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iiti_go/cady_schedule/cady_schedule.dart';
import 'package:iiti_go/cady_tracking/cady_tracking.dart';
import 'package:provider/provider.dart';
import 'constants/colors_constants.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:iiti_go/home_screen/home_screen.dart';
import 'package:iiti_go/sign_in/sign_in.dart';
import 'iiti_contacts/iiti_contacts.dart';
import 'internet_connectivity.dart';

// C:\tools\dart-sdk\bin     -- environmental variable -- path

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iiti Go',
      theme: ThemeData(
          colorScheme: customcolorScheme,
          // fascinate ,kaushanScript , paytoneOne ,lemon , cevicheOne , fingerPaint eastSeaDokdo
          textTheme: TextTheme(
            headline1: GoogleFonts.lemon(
                color: const Color.fromARGB(255, 5, 89, 153),
                fontSize: 60,
                letterSpacing: 3,
                shadows: const [
                  Shadow(
                      color: Colors.black12,
                      offset: Offset(5, 5),
                      blurRadius: 6)
                ],
                fontWeight: FontWeight.bold),
            headline2: GoogleFonts.signika(
                // color: const Color.fromARGB(255, 5, 89, 153),
                fontSize: 15,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold),
            headline3: GoogleFonts.lemon(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.bold),
          )),
      home: const MyHomePage(),
      routes: {
        //'/': (context) => const MyHomePage(),
        IITIContacts.routeName: (context) => const IITIContacts(),
        CadySchedule.routeName: (context) => const CadySchedule(),
        CadyTracking.routeName: (context) => const CadyTracking(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SignInPage.routeName: (context) => const SignInPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const SignInPage();
    } else {
//  StreamProvider(
//           initialData: NetworkStatus.online,
//           create: (context) => CheckInternetConnectivity().controller.stream,
//           child: const HomeScreen());
      return const HomeScreen();
    }
  }
}
