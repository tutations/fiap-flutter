import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'register_page.dart';
import '../ui/components/rounded_button.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login-page';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/profile.png'),
                  height: 100,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {
                      'email': '',
                      'password': '',
                    },
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(
                            labelText: 'Email',
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Informe o email',
                            ),
                            FormBuilderValidators.email(
                              errorText: 'Informe um email válido',
                            ),
                          ]),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Informe a senha',
                            ),
                            FormBuilderValidators.minLength(
                              6,
                              errorText:
                                  'A senha deve ter no mínimo 6 caracteres',
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          text: 'ENTRAR',
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              authenticateUser(
                                  context, _formKey.currentState!.value);
                            }
                          },
                        ),
                        SizedBox(height: 6),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterPage.id);
                          },
                          child: Text(
                            'Criar conta',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authenticateUser(BuildContext context, var values) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: values['email'],
      password: values['password'],
    )
        .then((userCredential) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    }).catchError((error) {
      String errorMessage;
      //print(error.message);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Seu email está mal formatado.";
          break;
        case "wrong-password":
          errorMessage = "Email e/ou senha inválidos.";
          break;
        case "user-not-found":
          errorMessage = "Email e/ou senha inválidos.";
          break;
        case "user-disabled":
          errorMessage = "Email e/ou senha inválidos.";
          break;
        default:
          errorMessage = error.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    });
  }
}
