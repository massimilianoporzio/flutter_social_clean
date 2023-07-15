import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/awesome_snackbar.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/signup/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: const Column(
                children: [
                  Spacer(
                    flex: 1,
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
                  _Password2(),
                  SizedBox(
                    height: 18.0,
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onPressed: () {
                  if (state.isValid) {
                    context.read<SignupCubit>().signupWithCredentials();
                    //e poi ritorno alla pagina di prima
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(buildAwesomeSnackbar(
                          message: 'Check your username, email and password',
                          title: "Error",
                          contentType: ContentType.failure));
                  }
                },
                child: Text(
                  'Signup',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ));
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return SizedBox(
          child: CustomTextField(
            labelText: "Password",
            errorText: !state.isPure && state.password.isNotValid
                ? "Invalid password"
                : null,
            obscureText: true,
            textInputType: TextInputType.name,
            onChanged: (password) {
              context.read<SignupCubit>().passwordChanged(password);
            },
          ),
        );
      },
    );
  }
}

class _Password2 extends StatelessWidget {
  const _Password2();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.password2 != current.password2;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: "Confirm Password",
          errorText:
              !state.isPure && !state.isValid ? 'Password not matches' : null,
          obscureText: true,
          onChanged: (password2) {
            context.read<SignupCubit>().password2Changed(password2);
          },
          textInputType: TextInputType.name,
        );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: "Username",
          errorText: state.username.isNotValid && !state.isPure
              ? 'The username is not valid'
              : null,
          onChanged: (username) {
            context.read<SignupCubit>().usernameChanged(username);
          },
          textInputType: TextInputType.name,
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: "Email",
          errorText: state.email.isNotValid && !state.isPure
              ? 'Invalid email adress'
              : null,
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          textInputType: TextInputType.emailAddress,
        );
      },
    );
  }
}
