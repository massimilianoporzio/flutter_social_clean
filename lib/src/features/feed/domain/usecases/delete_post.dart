// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

class DeletePost extends UseCase<void, DeletePostByIdParams> {
  final PostRepository postRepository;
  DeletePost({
    required this.postRepository,
  });
  @override
  call(DeletePostByIdParams params) {
    return postRepository.deletePostById(params.postId);
  }
}

class DeletePostByIdParams extends Params {
  final String postId;
  DeletePostByIdParams({
    required this.postId,
  });

  @override
  List<Object?> get props => [postId];
}
