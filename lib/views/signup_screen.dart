import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mvvm/resources/color.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: height * 0.25,
            ),
            const Text(
              'Create an account',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                          context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                  ValueListenableBuilder(
                      valueListenable: _obscurePassword,
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwordController,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: _obscurePassword.value,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_open_rounded),
                            suffixIcon: InkWell(
                              child: Icon(
                                _obscurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                              ),
                              onTap: () {
                                _obscurePassword.value =
                                    !_obscurePassword.value;
                              },
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
            SizedBox(height: height * 0.25),
            RoundButton(
              title: 'Sign Up',
              loading: authViewModel.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter email', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter password', context);
                } else if (_passwordController.text.length < 8) {
                  Utils.flushBarErrorMessage(
                      'Pasword must be 8 characters long', context);
                } else {
                  Map registerData = {
                    'email': _emailController.text.toString(),
                    'password': _passwordController.text.toString(),
                  };
                  print("REgister API hit");
                  authViewModel.registerApi(registerData, context);
                  Utils.flushBarErrorMessage('Registered Sucessfully', context);
                  Navigator.of(context).pushNamed('login_screen');
                }
              },
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Already have an acoount? ',
                style: TextStyle(
                  fontSize: height * 0.018,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('login_screen');
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.buttonColor,
                    fontSize: height * 0.018,
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    ));
  }
}
