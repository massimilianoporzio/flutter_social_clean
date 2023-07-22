import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> with BlocLoggy {
  //TODO: Add use case to create new post and save it
  AddContentCubit() : super(AddContentState.initial());

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
  }

  //reset: clear all the data
  void reset() {
    emit(AddContentState.initial());
  }
}
