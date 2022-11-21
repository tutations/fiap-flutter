import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui/components/rounded_button.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'register-page';

  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Criar conta',
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
                      'name': '',
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
                        SizedBox(height: 15),
                        FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            filled: true,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: 'Informe o nome'),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          text: 'CRIAR CONTA',
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              registerUser(
                                  context, _formKey.currentState!.value);
                            }
                          },
                        ),
                        SizedBox(height: 6),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, LoginPage.id);
                          },
                          child: Text(
                            'Login',
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

  void registerUser(BuildContext context, var values) async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: values['email'],
        password: values['password']
    ).then((userCredential) {
      userCredential.user?.updateDisplayName(values['name']);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }).catchError((error){
      String errorMessage;
      print(error.code);
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Seu email está mal formatado.";
          break;
        case "email-already-in-use":
          errorMessage = "Email já utilizado.";
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
