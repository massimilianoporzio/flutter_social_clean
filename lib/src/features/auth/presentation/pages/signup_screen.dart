import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              _Username(),
              SizedBox(
                height: 10.0,
              ),
              _Email(),
              SizedBox(
                height: 10.0,
              ),
              _Password(),
              SizedBox(
                height: 10.0,
              ),
              _SignupButton(),
              Spacer(
                flex: 2,
              ),
              _LoginRedirect(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("login");
      },
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(text: "Already registered? "),
            TextSpan(
                text: "Login!",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: () {},
        child: Text(
          'Signup',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ));
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: "Password",
      obscureText: true,
      textInputType: TextInputType.name,
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: "Username",
      textInputType: TextInputType.name,
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: "Email",
      textInputType: TextInputType.emailAddress,
    );
  }
}
