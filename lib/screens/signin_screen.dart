import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_mobile/utils/color_utils.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../widgets/main_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  /// These lines of code are initializing variables for Firebase authentication and text editing.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  /// The function checks if the email and password fields are empty and displays an error dialog if they
  /// are.
  ///
  /// Args:
  ///   context (BuildContext): The `context` parameter is the current build context of the widget tree.
  /// It is typically used to access the Navigator, Theme, MediaQuery, and other context-specific
  /// information.
  ///
  /// Returns:
  ///   a `Future<void>`.
  Future<void> _signIn(BuildContext context) async {
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Por favor, ingresa tu correo electrónico y contraseña.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
      print("Error en inicio de sesion, no se ingresaron credenciales");
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      // Navegar a la pantalla principal
      Navigator.pushReplacementNamed(context, MainWidget.routeName);
    } catch (error) {
      // Mostrar un mensaje de error al usuario
      print("Error de inicio de sesión: ${error.toString()}");
    }
  }

  /// The dispose function is used to clean up resources, such as text controllers, before the widget is
  /// removed from the widget tree.
  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("00D4FF"),
          hexStringToColor("090979"),
          hexStringToColor("020024")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("../assets/images/logoPrincipal.jpeg"),
                const Text(
                  "PokeDex",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                reusableTextField(
                  "correo@ejemplo.com",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Ingresa tu contraseña",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(height: 5),

                /// The `firebaseUIButton` is a custom widget that creates a button with a specific
                /// design for Firebase authentication. In this case, it is used to create a "Sign In"
                /// button.
                firebaseUIButton(context, "Ingresar", () async {
                  await _signIn(context)
                      .then((value) => print("Inicio de sesión exitoso"))
                      .catchError((error) =>
                          print("Error en inicio de sesión: $error"));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
