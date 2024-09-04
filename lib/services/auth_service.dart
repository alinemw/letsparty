import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

    signInWithGoogle() async {

      //inicia autenticacao
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      //resgata os detalhes da autenticação
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //cria novas credenciais
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      //autentica no firebase usando as credenciais
      return await FirebaseAuth.instance.signInWithCredential(credential);

    }

}