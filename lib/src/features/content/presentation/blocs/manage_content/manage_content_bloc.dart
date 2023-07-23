import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_posts_by_user.dart';

import '../../../../../shared/domain/entities/post.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUserUsecase;
  ManageContentBloc({required GetPostsByUser getPostsByUser})
      : _getPostsByUserUsecase = getPostsByUser,
        super(ManageContentLoading()) {
    on<ManageContentGetPostsByUser>(_onManageContentGetPostsByUser);
  }

  FutureOr<void> _onManageContentGetPostsByUser(
    ManageContentGetPostsByUser event,
    Emitter<ManageContentState> emit,
  ) async {
    List<Post> posts = await _getPostsByUserUsecase(
        GetPostsByUserParams(userId: event.userId));
    emit(ManageContentLoaded(posts: posts));
  }
}
