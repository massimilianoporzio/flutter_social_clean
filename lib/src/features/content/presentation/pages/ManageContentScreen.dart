// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_social_clean/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/post.dart';
import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/presentation/widgets/custom_user_information.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO assign current user
    // User user = User.empty;
    User user = const User(
        id: "_",
        username: Username.dirty("Massimiliano"),
        imagePath: 'assets/images/image_4.jpg');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            //sliver! permette di scrollare dentro la tabview
            body: TabBarView(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 9 / 16,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    Post post = Post(
                        id: 'id',
                        user: user,
                        caption: 'Test',
                        assetPath:
                            'assets/videos/compressed/video_${index + 1}.mp4');
                    return CustomVideoPlayer(assetPath: post.assetPath);
                  },
                ),
                Center(child: Text('Second Tab')),
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
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                    .copyWith(fontWeight: FontWeight.bold),
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
          )),
    );
  }
}
