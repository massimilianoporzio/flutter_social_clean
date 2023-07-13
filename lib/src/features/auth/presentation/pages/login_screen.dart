import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/login/login_cubit.dart';
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
          // TODO: implement listener
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
        return previous.status != current.status;
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
                  state.status.isSuccess
                      ? context.read<LoginCubit>().loginWithCredentials()
                      : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Check your username and password: ${state.status}')));
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
          errorText:
              state.password.isNotValid ? "The password is not valid" : null,
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
          errorText:
              state.username.isNotValid ? "The username is not valid" : null,
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
