import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:meditation_app/constants/colors.dart';
import 'package:meditation_app/provider/app_provider.dart';
import 'package:meditation_app/provider/firebase_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ScreensProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseServiceProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: ScreensProvider.appRun(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              Widget screen = snapshot.data;
              return screen;
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
