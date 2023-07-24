// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_social_clean/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/custom_user_information.dart';
import '../blocs/manage_content/manage_content_bloc.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoggedInUser user = context.read<AuthBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: BackButton(
          onPressed: () {
            context.goNamed("feed");
          },
        ),
      ),
      body: BlocBuilder<ManageContentBloc, ManageContentState>(
        builder: (context, state) {
          if (state is ManageContentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          if (state is ManageContentLoaded) {
            return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  //sliver! permette di scrollare dentro la tabview
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 9 / 16,
                        ),
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onDoubleTap: () {
                              context.read<ManageContentBloc>().add(
                                  ManageContentDeletePost(
                                      post: state.posts[index]));
                            },
                            child: CustomVideoPlayer(
                                key:
                                    UniqueKey(), //se no sballa lista quando faccio delete
                                assetPath: state.posts[index].assetPath),
                          );
                        },
                      ),
                      const Center(child: Text('Second Tab')),
                    ],
                  ),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              CustomUserInformation(user: user),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF006E),
                                      fixedSize: const Size(175, 50),
                                    ),
                                    onPressed: () {
                                      context.goNamed('add_content');
                                    },
                                    child: Text(
                                      'Add a video',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF006E),
                                      fixedSize: const Size(175, 50),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Update Picture',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TabBar(
                              labelColor: Colors.white,
                              indicatorColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.grid_view_rounded),
                                ),
                                Tab(
                                  icon: Icon(Icons.favorite),
                                )
                              ])
                        ],
                      ),
                    )
                  ],
                ));
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
