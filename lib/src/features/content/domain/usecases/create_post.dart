// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../../../../shared/domain/entities/post.dart';

class CreatePost implements UseCase<void, CreatePostParams> {
  final PostRepository postRepository;
  CreatePost({
    required this.postRepository,
  });
  @override
  Future<void> call(CreatePostParams params) {
    return postRepository.createPost(params.post);
  }
}

class CreatePostParams extends Params {
  final Post post;
  CreatePostParams({
    required this.post,
  });

  @override
  List<Object?> get props => [post];
}
