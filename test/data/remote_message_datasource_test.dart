import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';

import 'package:mocktail/mocktail.dart';

class _MockLocalMessageDatasource extends Mock implements LocalMessageDatasource {}

class _MockRemoteMessageDatasource extends Mock implements RemoteMessageDatasource {}

void main() {
  group('RemoteMessageRepositoryImpl', () {
    late _MockLocalMessageDatasource mockLocalMessageDatasource;
    late _MockRemoteMessageDatasource mockRemoteMessageDatasource;

    late MessageRepositoryImpl repository;
    setUp(() {
      mockLocalMessageDatasource = _MockLocalMessageDatasource();
      mockRemoteMessageDatasource = _MockRemoteMessageDatasource();
      repository = MessageRepositoryImpl(
          localMessageDatasource: mockLocalMessageDatasource,
          remoteMessageDatasource: mockRemoteMessageDatasource);
    });
    test('getMessageList returns data on success', () async {
      const MessageListResponseModel expected = MessageListResponseModel(messages: []);
      when(() => mockRemoteMessageDatasource.getRemoteMessageList())
          .thenAnswer((_) async => expected);

      final MessageListResponseEntity result = await repository.getRemoteMessageList();

      expect(result, MessageMapper.messageListModelToEntity(expected));
      verify(() => mockRemoteMessageDatasource.getRemoteMessageList()).called(1);
    });

    test('getMessageList throws when datasource fails', () async {
      final Exception exception = Exception('Datasource error');
      when(() => mockRemoteMessageDatasource.getRemoteMessageList()).thenThrow(exception);

      expect(
        () => repository.getRemoteMessageList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockRemoteMessageDatasource.getRemoteMessageList()).called(1);
    });
  });
}
