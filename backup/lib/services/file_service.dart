import 'dart:io';
import 'package:image_compression/image_compression.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static Future<File> compressFile(File file) async {
    if (!file.path.endsWith('.jpg') && !file.path.endsWith('.png')) {
      return file;
    }

    final result = await ImageCompression.compress(
      file: file,
      quality: 70,
      format: file.path.endsWith('.png') ? ImageFormat.png : ImageFormat.jpeg,
    );

    final dir = await getTemporaryDirectory();
    final compressedFile = File('${dir.path}/compressed_${file.path.split('/').last}');
    await compressedFile.writeAsBytes(result);

    return compressedFile;
  }

  static Future<String> saveReceivedFile(List<int> bytes, String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}