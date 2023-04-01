import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/ui/home/home_screen.dart';
import 'package:chat_oline_1/ui/login/login_veiw_model.dart';
import 'package:chat_oline_1/ui/register/register_screen.dart';
import 'package:chat_oline_1/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Utils/dialog_uitlis.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.checkLoggedInUser();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text('Login'),
            ),
            body: Container(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Email Address";
                          }
                          if (!ValidationUtils.isValidEmail(text)) {
                            return 'Please enter A Valid Email';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'E-mail Address'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return "Please Enter Password";
                          }
                          if (text.length < 6) {
                            return 'Password sold be at Least 6 Chars ';
                          }
                          return null;
                        },
                        obscureText: securedPassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                                onTap: () {
                                  securedPassword = !securedPassword;
                                  setState(() {});
                                },
                                child: Icon(securedPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(12))),
                          child: const Text(
                            'Login In',
                            style: TextStyle(fontSize: 18),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: const Text('Or Create Account?'))
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    viewModel.login(emailController.text, passwordController.text);
  }

  @override
  void gotoHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
