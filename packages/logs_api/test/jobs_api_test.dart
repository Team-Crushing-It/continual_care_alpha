import 'package:test/test.dart';
import 'package:logs_api/logs_api.dart';

class TestLogsApi extends LogsApi {
  TestLogsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('LogsApi', () {
    test('can be constructed', () {
      expect(TestLogsApi.new, returnsNormally);
    });
  });
}
