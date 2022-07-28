import 'package:flutter_getx_the_moviedb/core/base/index.dart';

class BaseRepository<P extends BaseProvider> {
  BaseRepository({
    required this.provider,
  });

  final P provider;
}
