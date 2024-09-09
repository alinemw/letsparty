import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/components/styled_text_field.dart';

class AddEventPagePage extends StatefulWidget {
  final Function()? onTap;
  const AddEventPagePage({super.key, required this.onTap});

  @override
  State<AddEventPagePage> createState() => _AddEventPagePageState();
}

class _AddEventPagePageState extends State<AddEventPagePage> {
  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();

  void addEvent() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                            'Vamos adicionar um evento!',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            )
                        ),
                        const SizedBox(height: 25),
                        StyledTextField(
                          controller: eventNameController,
                          hintText: 'Nome do evento',
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),

                        StyledTextField(
                          controller: eventDateController,
                          hintText: 'Data e Hora',
                          obscureText: false,

                        ),
                      ],
                    ))
            )
        )
    );
  }
}
