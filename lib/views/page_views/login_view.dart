import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_walking_ba/viewmodels/login_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/register_viewmodel.dart';
import 'package:waste_walking_ba/views/page_views/register_view.dart';

class LoginView extends StatefulWidget {
  @override
  LoginViewState createState() => LoginViewState();

  final LoginViewModel viewModel;

  const LoginView({super.key, required this.viewModel});
}

class LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back), // Das Icon für den "Zurück"-Button
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
                controller: widget.viewModel.usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Benutzername",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),
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
                    child: const Text('Passwort vergessen?'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Anmelden',
                    style: TextStyle(color: Colors.black),
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
                    const Text("Noch kein Mitglied?"),
                    TextButton(
                        onPressed: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (context) => RegisterViewModel(),
                                  builder: (context, child) {
                                    return RegisterView(
                                        viewModel:
                                            Provider.of<RegisterViewModel>(
                                                context));
                                  }),
                            ),
                          );

                          if (result == 'register_success') {}
                        },
                        child: const Text("Registrieren"))
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
