
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  await dotenv.load(fileName: ".env");
}

String get AWS_ACCESS_KEY_ID => dotenv.env['AWS_ACCESS_KEY_ID'] ?? '';
String get AWS_SECRET_ACCESS_KEY => dotenv.env['AWS_SECRET_ACCESS_KEY'] ?? '';
String get AWS_REGION => dotenv.env['AWS_REGION'] ?? '';
String get AWS_BUCKET_NAME => dotenv.env['AWS_BUCKET_NAME'] ?? '';
