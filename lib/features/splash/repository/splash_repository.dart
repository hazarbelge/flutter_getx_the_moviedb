import 'package:flutter_getx_the_moviedb/core/base/index.dart';
import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';

abstract class ISplashProvider {
  Future<Response<SessionData>> getSessionId(String path);
}

class SplashProvider extends BaseProvider implements ISplashProvider {
  @override
  InternalFinalCallback<void> get onStart {
    httpClient.defaultDecoder = (dynamic val) => SessionData.fromJson(val as Map<String, dynamic>);
    return super.onStart;
  }

  @override
  Future<Response<SessionData>> getSessionId(String path) => get(path);
}

abstract class ISplashRepository {
  Future<SessionData?> getSessionId();
}

class SplashRepository extends BaseRepository<SplashProvider> implements ISplashRepository {
  SplashRepository() : super(provider: SplashProvider());

  @override
  Future<SessionData?> getSessionId() async {
    final Response<SessionData> response = await provider.getSessionId(Url.sessionIdUrl);
    if (response.status.hasError) {
      return Future<SessionData>.error(response.statusText!);
    } else {
      Url.guestSessionId = response.body?.guestSessionId;
      return response.body;
    }
  }
}
