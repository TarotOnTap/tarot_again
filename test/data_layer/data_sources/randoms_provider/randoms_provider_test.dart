// this gets us GetIt/WatchIt packages

import 'package:tarot_again/util/util.dart' hide test;
import 'package:test/test.dart';

Stream<int> getNRandomInts({
  required AsyncRandoms source,
  required int count,
  int rangeLow = 0,
  required int rangeHigh,
}) async* {
  for (var i = rangeLow; i < rangeHigh; i++) {
    yield await source.getNextInt(rangeHigh: rangeHigh, rangeLow: rangeLow);
  }
}

void main() async {
  initializeLoggingService();

  // initializeDataLayer();

  AsyncRandoms randoms = sl<AsyncRandoms>();

  test("Test RandomsProvider's initializer", () async {
    expect(randoms, isA<AsyncRandoms>());
  });

  group("AsyncRandom getNextInt using default range-low of zero, and"
      "with various ranges", () {
    test("test that random number ranges start at 0 by default", () async {
      final Stream<int> randomStream = getNRandomInts(
        source: randoms,
        count: 1000,
        rangeHigh: 500,
      );

      bool testResult = await randomStream.every((int elem) => elem >= 0);

      expect(testResult, true);
    });

    test(
      "test that random number ranges produce numbers less than their upper limit",
      () async {
        final Stream<int> randomStream = getNRandomInts(
          source: randoms,
          count: 1000,
          rangeHigh: 357,
        );

        bool testResult = await randomStream.every((int elem) => elem < 357);
      },
    );
    test(
      "test that random numbers over a range stay within their limits",
      () async {
        final Stream<int> randomStream = getNRandomInts(
          source: randoms,
          count: 1000,
          rangeLow: -852,
          rangeHigh: 922,
        );

        bool testResult = await randomStream.every(
          (int elem) => elem >= -852 && elem < 922,
        );
      },
    );
  });

  group("Testing AsyncRandoms shuffleIterableStream", () {});
}
