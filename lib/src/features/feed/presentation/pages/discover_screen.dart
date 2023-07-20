import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loggy/loggy.dart';

import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/discover/discover_bloc.dart';

class DiscoverScreen extends StatelessWidget with UiLoggy {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discover"),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (state is DiscoverLoaded) {
            // loggy.debug('Users: ${state.users}');
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10, crossAxisSpacing: 10,
              itemCount: state.users.length, //due colonne
              itemBuilder: (context, index) {
                User user = state.users[index];
                return _DiscoverUserCard(
                  user: user,
                  index: index,
                );
              },
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}

class _DiscoverUserCard extends StatelessWidget {
  const _DiscoverUserCard({
    super.key,
    required this.user,
    required this.index,
  });

  final User user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: index == 0 ? 250 : 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: user.imagePath == null
                      ? const AssetImage('assets/images/images_1.jpg')
                      : AssetImage(user.imagePath!))),
        ),
        const CustomGradientOverlay(
          stops: [0.4, 1.0],
          colors: [Colors.transparent, Colors.black],
        ),
        Positioned(
            left: 10,
            bottom: 10,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: user.imagePath == null
                      ? null
                      : AssetImage(user.imagePath!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  user.username.value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ))
      ],
    );
  }
}
