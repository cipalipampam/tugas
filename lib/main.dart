import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Color.fromARGB(255, 143, 58, 183)),
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController usernameInputController;
  late TextEditingController passwordInputController;

  @override
  void initState() {
    super.initState();
    usernameInputController = TextEditingController();
    passwordInputController = TextEditingController();
  }

  @override
  void dispose() {
    usernameInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void validateCredentials() {
    String username = usernameInputController.text;
    String password = passwordInputController.text;

    // Validate username
    if (!isValidUsername(username)) {
      showSnackBar("Username harus mengandung '@' dan '.'");
      return;
    }

    // Validate password
    if (!isValidPassword(password)) {
      showSnackBar(
          "Password harus terdiri dari minimal 10 karakter alfanumerik");
      return;
    }

    // Credentials are valid
    showSnackBar("Username dan password valid");
  }

  bool isValidUsername(String username) {
    return username.contains('@') && username.contains('.');
  }

  bool isValidPassword(String password) {
    // Regex for at least one alphanumeric character and minimum length of 10
    RegExp regex = RegExp(r'^(?=.*[a-zA-Z0-9]).{10,}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 251, 7),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 7, 7),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: usernameInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
                hintText: "Enter your username",
              ),
            ),
            TextField(
              obscureText: true,
              controller: passwordInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                hintText: "Enter your password",
              ),
            ),
            TextButton(
              onPressed: validateCredentials,
              child: Text("Submit"),
              style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 60, 255, 0)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
