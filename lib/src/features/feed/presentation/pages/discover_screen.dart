import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';

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
            loggy.debug('Users: ${state.users}');
            return Container();
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
