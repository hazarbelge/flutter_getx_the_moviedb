import 'package:flutter_getx_the_moviedb/models/index.dart';
import 'package:flutter_getx_the_moviedb/network/index.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

abstract class IStartProvider {
  Future<Response<SessionData>> getSessionId(String path);
}

class StartProvider extends GetConnect implements IStartProvider {
  @override
  void onInit() {
    httpClient.defaultDecoder = (dynamic val) => SessionData.fromJson(val as Map<String, dynamic>);
    httpClient.baseUrl = Url.movieDbBaseUrl;

    httpClient.addRequestModifier((Request<dynamic> request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  @override
  Future<Response<SessionData>> getSessionId(String path) => get(path);
}

abstract class IStartRepository {
  Future<SessionData?> getSessionId();
}

class StartRepository implements IStartRepository {
  StartRepository({
    required this.provider,
  });

  final IStartProvider provider;

  @override
  Future<SessionData?> getSessionId() async {
    final Response<SessionData> response = await provider.getSessionId(Url.sessionIdUrl);
    if (response.status.hasError) {
      return Future<SessionData>.error(response.statusText!);
    } else {
      Url.sessionId = response.body?.guestSessionId;
      return response.body;
    }
  }
}
