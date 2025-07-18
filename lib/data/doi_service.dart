import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
final dio = Dio();

class DoiService {

  Future<void> getArticle() async {
    final apiUrl = "https://example.com/article";
    final header = {'Content-Type': 'application/json'};
    try {
      final response = await dio.get(apiUrl, options: Options(
        headers: header
      ));
      print('Success: ${response.data}');
    } catch (e) {
      print('Failed: $e');
    }
  }

  Future<void> createArticle() async {
    final apiUrl = "https://example.com/article";
    final header = {'Content-Type': 'application/json'};
    final dataRequest = {
      'title': 'New Article',
      'body': 'Article content'
    };
    try {
      final response = await dio.post(apiUrl, options: Options(headers: header),
        data: dataRequest,
      );
      print('Success: ${response.data}');
    } catch (e) {
      print('Failed: $e');
    }
  }



  Future<void> updateArticle() async {
    final apiUrl = "https://example.com/article/1";
    final header = {'Content-Type': 'application/json'};
    final dataRequest = {
      'title': 'Updated Article',
      'body': 'Article content'
    };
    try {
      final response = await dio.put(apiUrl, options: Options(headers: header),
        data: dataRequest,
      );
      print('Success: ${response.data}');
    } catch (e) {
      print('Failed: $e');
    }
  }

  Future<void> deleteArticle() async {
    final apiUrl = "https://example.com/article";
    final header = {'Content-Type': 'application/json'};
    try {
      final response = await dio.delete(apiUrl, options: Options(headers: header));
      print('Success: ${response.statusCode}');
    } catch (e) {
      print('Failed: $e');
    }
  }

  Future<void> uploadFile(String filePath) async {
    final dio = Dio();
    final apiUrl = "https://example.com/upload";
    final fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
    });
    try {
      final response = await dio.post(apiUrl,data: formData,
        onSendProgress: (sent, total) {
          print("Uploading: ${(sent / total * 100).toStringAsFixed(0)}%");
        },
      );
      print("Upload complete: ${response.data}");
    } catch (e) {
      print("Upload error: $e");
    }
  }

  Future<void> downloadFile(String filename) async {
    final dio = Dio();
    final apiUrl = "https://example.com/upload";
    final dir = await getApplicationDocumentsDirectory();
    final filePath = "${dir.path}/$filename";
    try {
      await dio.download(
        apiUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );
      print("Download saved to: $filePath");
    } catch (e) {
      print("Download error: $e");
    }
  }


}