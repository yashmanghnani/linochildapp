import 'package:http/http.dart' as http;

class Repository {
  Future<bool> AiCall(String user) async {
    final url = Uri.parse('http://technoparticles.cloud:4000/call-ai/$user');

    final response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ("not connect ");
    }
  }
}
