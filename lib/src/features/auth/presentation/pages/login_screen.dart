import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/login/login_cubit.dart';
import 'package:flutter_social_clean/src/shared/presentation/widgets/awesome_snackbar.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(buildAwesomeSnackbar(
                  message: state.errorText ?? 'Auth failure',
                  title: 'Auth failure',
                  contentType: ContentType.failure));
          }
        },
        child: const SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Spacer(
                flex: 3,
              ),
              _Username(),
              SizedBox(
                height: 10,
              ),
              _Password(),
              SizedBox(
                height: 10,
              ),
              _LoginButton(),
              Spacer(
                flex: 2,
              ),
              _SignupRedirect()
            ],
          ),
        )),
      ),
    );
  }
}

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("signup");
      },
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
                text: "Signup!",
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

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        //build solo se lo stato del login cubit è cambiato
        return previous != current;
      },
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
                    context.read<LoginCubit>().loginWithCredentials();
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(buildAwesomeSnackbar(
                          message: 'Check your username and password',
                          title: "Error",
                          contentType: ContentType.failure));
                  }
                },
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ));
      },
    );
  }
}

class _Password extends StatelessWidget with UiLoggy {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: "Password",
          errorText: state.password.isNotValid && !state.isPure
              ? "The password is not valid"
              : null,
          onChanged: (password) {
            loggy.debug("OnChanged Password");
            context.read<LoginCubit>().passwordChanged(password);
          },
          obscureText: true,
          textInputType: TextInputType.name,
        );
      },
    );
  }
}

class _Username extends StatelessWidget with UiLoggy {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.username !=
            current.username; //rebuild solo se ho cambiato lo username!
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: "Username",
          errorText: state.username.isNotValid && !state.isPure
              ? "The username is not valid"
              : null,
          onChanged: (username) {
            loggy.debug("OnChanged username");
            context.read<LoginCubit>().usernameChanged(
                username); //quando l'input cambia chiamo metodo del cubit
            //che richiama la validazione ed emette stato:
          },
          textInputType: TextInputType.name,
        );
      },
    );
  }
}
