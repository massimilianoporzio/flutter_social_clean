import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/feed/feed_bloc.dart';

class FeedScreen extends StatelessWidget with UiLoggy {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is FeedLoaded) {
            // loggy.debug(state.posts);

            return SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return CustomVideoPlayer(
                    assetPath: post.assetPath,
                    username: post.user.username.value,
                    caption: post.caption,
                  );
                },
              ),
            );
          } else {
            return const Text('Something went wrong!');
          }
        },
      ),
    );
  }
}
