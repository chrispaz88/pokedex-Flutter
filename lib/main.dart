import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/providers/category_provider.dart';
import 'package:pokedex_mobile/providers/pokemon_provider.dart';
import 'package:pokedex_mobile/screens/pokemon_details.dart';
import 'package:pokedex_mobile/screens/signin_screen.dart';
import 'package:pokedex_mobile/widgets/main_widget.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => PokemonProvider()),
        ],
        child: MaterialApp(
          title: 'Pokedex',
          //home: new MainWidget(),
          initialRoute: '/',
          /// The `routes` property in the `MaterialApp` widget is used to define the routes for navigating
          /// between different screens in the application.
          routes: {
            '/': (context) => const SignInScreen(),
            MainWidget.routeName: (context) => const MainWidget(),
            PokemonDetailsScreen.routeName: (context) =>
                const PokemonDetailsScreen(),
          },
        ));
  }
}

