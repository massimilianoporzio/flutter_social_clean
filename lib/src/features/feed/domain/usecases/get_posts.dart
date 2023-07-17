// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

import '../../../../shared/domain/entities/post.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  final PostRepository postRepository;
  GetPosts({
    required this.postRepository,
  });

  @override
  call(NoParams params) {
    return postRepository.getPosts();
  }
}
