// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';

class LoggedInUser extends User with EquatableMixin {
  final String? email;
  const LoggedInUser(
      {this.email,
      required super.id,
      required super.username,
      super.imagePath,
      super.followers,
      super.followings});

  static const empty = LoggedInUser(
    id: '-',
    username: '-',
    email: '-',
  );

  @override
  List<Object?> get props => [
        id,
        username,
        followers,
        followings,
        imagePath,
        email,
      ];

  LoggedInUser copyWith({
    String? email,
    String? id,
    String? username,
    String? imagePath,
    int? followers,
    int? followings,
  }) {
    return LoggedInUser(
        email: email ?? this.email,
        id: id ?? this.id,
        username: username ?? this.username,
        imagePath: imagePath ?? this.imagePath,
        followers: followers ?? this.followers,
        followings: followings ?? this.followings);
  }
}
