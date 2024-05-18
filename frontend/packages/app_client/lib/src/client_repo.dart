abstract class IClientHttp {
  Future post({required String url, required String body});
  Future get({required String url});
  Future delete({required String url});
}
