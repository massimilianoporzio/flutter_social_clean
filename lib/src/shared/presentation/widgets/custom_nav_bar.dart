import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      notchMargin: 10,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 30,
              onPressed: () {
                context.goNamed('feed');
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {
                context.goNamed('discover');
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.add_circle),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.message),
            ),
            IconButton(
              iconSize: 30,
              onPressed: () {
                //faccio emettere evento di logout
                context.read<AuthBloc>().add(AuthLogoutUser());
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
