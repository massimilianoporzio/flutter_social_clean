// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_social_clean/src/features/content/domain/usecases/create_post.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';

import '../../../../../shared/domain/entities/post.dart';
import '../../../../../shared/domain/entities/user.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> with BlocLoggy {
  final CreatePost _createPost;
  AddContentCubit({required CreatePost createPostUsecase})
      : _createPost = createPostUsecase,
        super(AddContentState.initial());

  void videoChanged(File file) {
    emit(state.copyWith(video: file, status: AddContentStatus.loading));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(
      caption: caption,
      status: AddContentStatus.loading,
    ));
  }

  //get info for creating post, create it and send it to database
  void submit() {
    loggy.debug("SUBMITTING: $state");
    emit(state.copyWith(status: AddContentStatus.loading));
    try {
      final Post post = Post(
        id: 'post_000', //hard coded for now
        user: User.empty, //TODO put the current logged in user
        assetPath: state.video!.path,
        caption: state.caption,
      );
      _createPost(CreatePostParams(post: post));
      loggy.debug("Post submitted: $post");
      emit(state.copyWith(status: AddContentStatus.success));
    } catch (err) {
      //TODO handle errors
    }
  }

  //reset: clear all the data
  void reset() {
    emit(AddContentState.initial());
  }
}
