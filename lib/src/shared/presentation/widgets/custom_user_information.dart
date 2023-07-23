import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class CustomUserInformation extends StatelessWidget {
  final User user;
  const CustomUserInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage:
              (user.imagePath == null) ? null : AssetImage(user.imagePath!),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserInfo(context, "Followers", "${user.followers}"),
              _buildUserInfo(context, "Followings", "${user.followings}"),
            ],
          ),
        )
      ],
    );
  }

  Column _buildUserInfo(BuildContext context, String type, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          type,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
