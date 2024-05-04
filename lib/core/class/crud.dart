import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:my_ecommerce_delivery/core/class/request_status.dart';
import 'package:my_ecommerce_delivery/core/functions/check_internet_connection.dart';
import 'package:path/path.dart';

class CRUD {
  static Future<Either<RequestStatus, Map>> post(
      String url, Map<String, String> data) async {
    if (await checkInternet()) {
      try {
        http.Response response = await http.post(Uri.parse(url), body: data);
        // connected to the server and everything is ok
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(response.body));
        }
        // connected but there is an exception in the endpoint code
        else {
          return const Left(RequestStatus.serverException);
        }
      } catch (e) {
        // have internet connection but failed to connect to the server
        return const Left(RequestStatus.serverError);
      }
    } else {
      // if you don't have internet connection
      return const Left(RequestStatus.internetConnectionError);
    }
  }

  static Future<Either<RequestStatus, Map<String, dynamic>>> uploadSingleFile(
      File? file, Map<String, String> data, String link) async {
    if (await checkInternet()) {
      var uri = Uri.parse(link);
      http.MultipartRequest multipartRequest =
          http.MultipartRequest("POST", uri);

      if (file != null) {
        int fileLength = await file.length();
        http.MultipartFile multipartFile = http.MultipartFile(
          "image",
          file.openRead(),
          fileLength,
          filename: basename(file.path),
        );
        multipartRequest.files.add(multipartFile);
      }

      multipartRequest.fields.addAll(data);

      try {
        http.StreamedResponse streamedResponse = await multipartRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        }
        // connected but there is an exception in the endpoint code
        else {
          return const Left(RequestStatus.serverException);
        }
      } catch (e) {
        return const Left(RequestStatus.serverError);
      }
    } else {
      // if you don't have internet connection
      return const Left(RequestStatus.internetConnectionError);
    }
  }

  static Future<Either<RequestStatus, Map<String, dynamic>>>
      uploadMultipleFiles(
          List<File>? files, Map<String, String> data, String link) async {
    if (await checkInternet()) {
      try {
        Uri uri = Uri.parse(link);
        http.MultipartRequest multipartRequest =
            http.MultipartRequest("POST", uri);
        int fieldName = 1;
        if (files != null) {
          for (File file in files) {
            int fileLength = await file.length();
            http.MultipartFile multipartFile = http.MultipartFile(
              fieldName.toString(),
              file.openRead(),
              fileLength,
              filename: basename(file.path),
            );
            multipartRequest.files.add(multipartFile);
            fieldName++;
          }
        }

        multipartRequest.fields.addAll(data);

        http.StreamedResponse streamedResponse = await multipartRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 200) {
          return Right(jsonDecode(response.body));
        }
        // connected but there is an exception in the endpoint code
        else {
          return const Left(RequestStatus.serverException);
        }
      } catch (e) {
        return const Left(RequestStatus.serverError);
      }
    } else {
      // if you don't have internet connection
      return const Left(RequestStatus.internetConnectionError);
    }
  }
}
