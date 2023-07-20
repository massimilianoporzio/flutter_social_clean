import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_users.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> with BlocLoggy {
  final GetUsers _getUsersUsecase;
  DiscoverBloc({required GetUsers getUsers})
      : _getUsersUsecase = getUsers,
        super(DiscoverLoading()) {
    on<DiscoverGetUsers>(_onDiscoverGetUsers);
  }

  FutureOr<void> _onDiscoverGetUsers(
      DiscoverEvent event, Emitter<DiscoverState> emit) async {
    loggy.debug("START getting users");
    emit(DiscoverLoading());
    await Future.delayed(const Duration(milliseconds: 1000));
    List<User> users = await _getUsersUsecase(NoParams());
    emit(DiscoverLoaded(users: users));
  }
}
