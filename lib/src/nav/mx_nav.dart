import 'i_mx_nav.dart';

mixin MxNav {
  static HistoryProvider? historyProvider;

  static void setPathUrlStrategy() {
    throw UnsupportedError('Only supported on web');
  }

  static void replaceUrl(Uri route) {
    throw UnsupportedError('Only supported on web');
  }

  static void setHashUrlStrategy() {
    throw UnsupportedError('Only supported on web');
  }

  static String makeUrl({
    required String path,
    Map<String, String>? queryParameters,
  }) {
    throw UnsupportedError('Only supported on web');
  }
}
