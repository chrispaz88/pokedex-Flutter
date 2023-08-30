import 'package:flutter/material.dart';

/// The function returns an Image widget with the specified image name, fit, width, and height.
/// 
/// Args:
///   imageName (String): The `imageName` parameter is a string that represents the name or path of the
/// image file that you want to display as a logo.
/// 
/// Returns:
///   an Image widget.
Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240
  );
}

/// The function `reusableTextField` returns a TextField widget with customizable text, icon, password
/// visibility, controller, and styling.
/// Returns:
///   The function `reusableTextField` returns a `TextField` widget.
TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

/// The function `firebaseUIButton` returns a container with an elevated button that has a specified
/// width, height, margin, and decoration, and executes a given function when pressed.
/// 
/// Args:
///   context (BuildContext): The context parameter is the BuildContext object, which represents the
/// location in the widget tree where the container is being built. It is used to access the size of the
/// screen using MediaQuery.of(context).size.width.
///   title (String): The title parameter is a string that represents the text to be displayed on the
/// button.
///   onTap (Function): The `onTap` parameter is a function that will be called when the button is
/// pressed. It is a callback function that you can define and pass to the `firebaseUIButton` function.
/// This allows you to perform any desired actions when the button is pressed.
/// 
/// Returns:
///   a Container widget that contains an ElevatedButton widget.
Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
