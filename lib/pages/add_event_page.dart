import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/components/styled_button.dart';
import 'package:lets_party/components/styled_text_field.dart';

class AddEventPagePage extends StatefulWidget {
  const AddEventPagePage({super.key});

  @override
  State<AddEventPagePage> createState() => _AddEventPagePageState();
}

class _AddEventPagePageState extends State<AddEventPagePage> {
  final user = FirebaseAuth.instance.currentUser;

  final eventNameController = TextEditingController();
  final eventDateController = TextEditingController();

  Future addEvent() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (user == null) {
      showErrorMessage('Você precisa entrar para a turma primeiro!');
    } else if (eventNameController.text == '') {
      showErrorMessage('Que tipo de evento não merece um nome?');
    } else if (eventDateController.text == '') {
      showErrorMessage('Legal... mas quando?');
    } else {
      DateTime dateTime = DateTime.parse(eventDateController.text);

      await FirebaseFirestore.instance.collection('events').add({
        'user': user!.email!,
        'eventName': eventNameController.text,
        'eventDate': dateTime.microsecondsSinceEpoch,
      });
    }

    Navigator.pop(context);
    goToHome();
  }

  void goToHome(){
    Navigator.pop(context,true);
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

                        const SizedBox(height: 50),
                        StyledButton(onTap: addEvent, text: 'Adicionar!'),
                        const SizedBox(height: 10),
                        StyledButton(onTap: goToHome, text: 'Desistir!'),
                      ],
                    ))
            )
        )
    );
  }
}
