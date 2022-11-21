import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'login_page.dart';
import '../ui/components/rounded_button.dart';

class ProfilePage extends StatefulWidget {
  static const String id = 'profile-page';

  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final user = FirebaseAuth.instance.currentUser!;

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
                Padding(
                  padding: EdgeInsets.all(16),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {
                      'email': user.email ?? '',
                      'name': user.displayName ?? '',
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
                          text: 'ATUALIZAR DADOS',
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              updateUser(_formKey.currentState!.value);
                            }
                          },
                        ),
                        SizedBox(height: 6),
                        MaterialButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (_) => false,
                            );
                          },
                          child: Text(
                            'Sair',
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

  void updateUser(var values) async {
    FirebaseAuth.instance.currentUser!.updateEmail(values['email']);
    FirebaseAuth.instance.currentUser!.updateDisplayName(values['name']);
  }
}
