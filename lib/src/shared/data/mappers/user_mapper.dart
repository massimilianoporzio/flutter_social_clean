import 'package:flutter_social_clean/src/shared/data/mappers/base_mapper.dart';
import 'package:flutter_social_clean/src/shared/data/models/user_model.dart';

import '../../domain/entities/user.dart';

class UserMapper extends EntityMapper<UserModel, User> {
  @override
  UserModel fromEntity(User entity) {
    return UserModel(
        id: entity.id,
        username: entity.username.value,
        followers: entity.followers,
        followings: entity.followings,
        imagePath: entity.imagePath);
  }

  @override
  User toEntity(UserModel model) {
    return User(
      id: model.id,
      username: Username.dirty(model.username),
      followers: model.followers,
      followings: model.followings,
      imagePath: model.imagePath,
    );
  }
}
