import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';

abstract interface class MeetingRoomRepository {
  Future<MeetingRoomListResponseEntity> getMeetingRoomList();
}
