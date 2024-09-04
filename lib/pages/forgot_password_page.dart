import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/components/styled_button.dart';
import 'package:lets_party/components/styled_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final emailController = TextEditingController();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  'Email com instruções enviado!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          });
    } on FirebaseAuthException catch (e){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                  e.message.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Informe seu e-mail, e lhe enviaremos um link para para redefinir seu password!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Styledtextfield(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          const SizedBox(height: 10),
          StyledButton(
              onTap: passwordReset,
              text: 'Enviar link',
          )
        ],
      ),
    );
  }
}
