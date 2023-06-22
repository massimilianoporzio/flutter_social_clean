import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/user.dart';

class LoggedInUser extends User with EquatableMixin {
  final String? email;
  const LoggedInUser({
    required super.id,
    required super.username,
    super.imagePath,
    super.followers,
    super.followings,
    this.email,
  });

  static const empty = LoggedInUser(
    id: '-',
    username: '-',
    email: '-',
  );

  @override
  List<Object?> get props => super.props..addAll([email]);

  @override
  bool? get stringify => true;
}
