import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_walking_ba/viewmodels/confirm_registration_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/register_viewmodel.dart';
import 'package:waste_walking_ba/views/page_views/confirm_registration_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();

  final RegisterViewModel viewModel;

  RegisterView({required this.viewModel});
}

class _RegisterViewState extends State<RegisterView> {
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
                    "Registrieren",
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
                controller: widget.viewModel.emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "E-Mail",
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
                    labelText: "Passwort",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  obscureText: true),
              SizedBox(height: 20.0),
              Container(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await widget.viewModel.register();
                    print(success);
                    if (success) {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (context) =>
                                    ConfirmRegistrationViewModel(),
                                builder: (context, child) {
                                  return ConfirmRegistrationView(
                                      username: widget
                                          .viewModel.usernameController.text,
                                      viewModel: Provider.of<
                                              ConfirmRegistrationViewModel>(
                                          context));
                                }),
                          ));
                      if (result == "code_valid") {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    'Registrieren',
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
            ],
          ),
        ),
      ),
    );
  }
}
