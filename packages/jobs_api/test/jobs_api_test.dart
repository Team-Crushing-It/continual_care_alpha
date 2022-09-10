import 'package:test/test.dart';
import 'package:jobs_api/jobs_api.dart';

class TestJobsApi extends JobsApi {
  TestJobsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('JobsApi', () {
    test('can be constructed', () {
      expect(TestJobsApi.new, returnsNormally);
    });
  });
}
