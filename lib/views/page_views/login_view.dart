import 'package:flutter/material.dart';
import 'package:waste_walking_ba/viewmodels/login_viewmodel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();

  final LoginViewModel viewModel;

  LoginView({required this.viewModel});
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Das Icon für den "Zurück"-Button
          onPressed: () {
            Navigator.pop(context, ""); // Gehe zur vorherigen Seite zurück
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    "Willkommen",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                controller: widget.viewModel.emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "E-Mail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: widget.viewModel.passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                      child: Icon(widget.viewModel.passwordObscured
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onTap: () => {widget.viewModel.togglePasswordObscured()}),
                  labelText: "Passwort",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                obscureText: widget.viewModel.passwordObscured,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      //TODO
                    },
                    child: Text('Passwort vergessen?'),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await widget.viewModel.login();
                    print(success);
                    if (success) {
                      Navigator.pop(context, 'logged_in');
                    }
                  },
                  child: Text(
                    'Anmelden',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Noch kein Mitglied?"),
                    TextButton(
                        onPressed: () => {
                              //TODO
                            },
                        child: Text("Registrieren"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
