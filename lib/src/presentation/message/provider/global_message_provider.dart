import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_message_provider.g.dart';

@Riverpod(keepAlive: true)
class GlobalMessageList extends _$GlobalMessageList {
  @override
  Future<List<MessageEntity>> build() async {
    final MessageUseCase useCase = ref.read(messageUseCaseProvider);
    final MessageListResponseEntity response = await useCase.getMessageList();
    return response.messages;
  }

  void addMessage(MessageEntity message) {
    state.whenData((messages) {
      final List<MessageEntity> updated = [message, ...messages]
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      state = AsyncData(updated);
    });
  }
}
