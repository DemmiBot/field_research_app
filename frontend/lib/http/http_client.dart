import 'package:http/http.dart' as http;

abstract class IClientHttp {
  Future post({required String url, required String body});
  Future get({required String url});
}

class HttpClient implements IClientHttp {
  final client = http.Client();
  

  @override
  Future post({required String url, required String body}) async {
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if(response.statusCode == 200) {
        return response;
      } else {
        throw Exception('failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error makin post request boi: $e');
    }

    return null;
  }

  @override
  Future get({required String url}) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }
}
