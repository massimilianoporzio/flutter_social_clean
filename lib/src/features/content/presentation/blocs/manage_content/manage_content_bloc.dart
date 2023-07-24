import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/delete_post.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_posts_by_user.dart';

import '../../../../../shared/domain/entities/post.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUserUsecase;
  final DeletePost _deletePostUsecase;
  ManageContentBloc({
    required GetPostsByUser getPostsByUser,
    required DeletePost deletePost,
  })  : _getPostsByUserUsecase = getPostsByUser,
        _deletePostUsecase = deletePost,
        super(ManageContentLoading()) {
    on<ManageContentGetPostsByUser>(_onManageContentGetPostsByUser);
    on<ManageContentDeletePost>(_onManageContentDeletePost);
  }

  FutureOr<void> _onManageContentGetPostsByUser(
    ManageContentGetPostsByUser event,
    Emitter<ManageContentState> emit,
  ) async {
    List<Post> posts = await _getPostsByUserUsecase(
        GetPostsByUserParams(userId: event.userId));
    emit(ManageContentLoaded(posts: posts));
  }

  FutureOr<void> _onManageContentDeletePost(
    ManageContentDeletePost event,
    Emitter<ManageContentState> emit,
  ) async {
    if (state is ManageContentLoaded) {
      //SOLO SE HO POST CARICATO
      final state = this.state as ManageContentLoaded;
      await _deletePostUsecase(DeletePostByIdParams(postId: event.post.id));
      //CANCELLATO POST DA LOCAL/REMOTE DATASOURCE NON DALLO STATO
      List<Post> posts = List.from(state.posts)..remove(event.post);
      emit(ManageContentLoaded(posts: posts));
    }
  }
}
