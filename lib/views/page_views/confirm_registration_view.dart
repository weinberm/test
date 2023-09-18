import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_walking_ba/viewmodels/confirm_registration_viewmodel.dart';
import 'package:waste_walking_ba/viewmodels/register_viewmodel.dart';
import 'package:waste_walking_ba/views/page_views/register_view.dart';

class ConfirmRegistrationView extends StatefulWidget {
  @override
  ConfirmRegistrationViewState createState() => ConfirmRegistrationViewState();

  final ConfirmRegistrationViewModel viewModel;
  final String username;

  const ConfirmRegistrationView(
      {super.key, required this.viewModel, required this.username});
}

class ConfirmRegistrationViewState extends State<ConfirmRegistrationView> {
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
                    "Bestätigen",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                controller: widget.viewModel.verificationCodeController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Bestätigungscode",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success =
                        await widget.viewModel.verify(widget.username);
                    print(success);
                    if (success) {
                      Navigator.pop(context, 'code_valid');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Bestätigen',
                    style: TextStyle(color: Colors.black),
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
