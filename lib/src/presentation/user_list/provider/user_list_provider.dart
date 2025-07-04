import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';

@Riverpod(keepAlive: true)
final class UserList extends _$UserList {
  @override
  Future<UserListResponseEntity> build() async {
    return await _fetchUserList();
  }

  Future<UserListResponseEntity> _fetchUserList({
    UserUseCase? userUseCase,
  }) async {
    final UserUseCase useCase = userUseCase ?? ref.read(userUseCaseProvider);
    return await useCase.getUserList();
  }

  Future<void> getUserList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUserList());
  }
}
