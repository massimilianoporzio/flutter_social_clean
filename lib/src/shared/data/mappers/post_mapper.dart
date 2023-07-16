import 'package:flutter_social_clean/src/shared/data/mappers/base_mapper.dart';

import '../../domain/entities/post.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class PostMapper extends EntityMapper<PostModel, Post> {
  @override
  PostModel fromEntity(Post entity) {
    return PostModel(
      id: entity.id,
      userModel: UserModel.fromEntity(entity.user),
      caption: entity.caption,
      assetPath: entity.assetPath,
    );
  }

  @override
  Post toEntity(PostModel model) {
    return Post(
      id: model.id,
      user: model.userModel.toEntity(),
      caption: model.caption,
      assetPath: model.assetPath,
    );
  }
}
