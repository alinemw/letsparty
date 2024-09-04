import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/components/login_with_button.dart';
import 'package:lets_party/components/sign_in_up_button.dart';
import 'package:lets_party/components/styled_text_field.dart';
import 'package:lets_party/pages/forgot_password_page.dart';
import 'package:lets_party/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
                child: new SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),
                  const SizedBox(height: 50),
                  Text(
                      'Bem vindo de volta, Vamos organizar uma festa!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      )
                  ),
                  const SizedBox(height: 25),
                  Styledtextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  Styledtextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const ForgotPassword();
                                })
                            );
                          },
                          child:  Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SignInUpButton(
                    onTap: signIn,
                    text: 'Sign In',
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'ou',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          )
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginWithButton(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/googleLoginIcon.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                      'Não se juntou?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                          'Junte-se agora!',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                    ),

                    ],
                  ),
                ],
                ))
            )
        )
    );
  }
}
