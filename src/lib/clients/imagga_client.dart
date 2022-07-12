import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ipm_p2/locale/localization.i18n.dart';
import 'package:ipm_p2/models/models.dart';

class ImaggaClient {
  const ImaggaClient();

  Future<List<Faces>> loadFaceDataURL(String imagePath) async {
    String header =
        "Basic YWNjXzkyYmVhMzhhYjFhNmYwNjpkODllODgzYTM4YWE5NTE3ZTk0OGEzNjQzOWFkMWMyMA==";
    String url =
        "https://api.imagga.com/v2/faces/detections?return_face_attributes=1";
    String img = base64Encode(new File(imagePath).readAsBytesSync());

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: header,
      },
      body: {"image_base64": img},
    );

    if (response.statusCode != 200) {
      throw 'Error uploading the image.'.i18n;
    }

    String success = json.decode(response.body.toString())['status']['type'];

    if (success != "success") {
      throw 'There was an error processing the image.'.i18n;
    }

    List faces = json.decode(response.body.toString())['result']['faces'];
    List<Faces> faceList = faces.map((face) => Faces.fromJson(face)).toList();

    if (faceList.isEmpty) {
      throw 'No face was found on the photo.'.i18n;
    }
    return faceList;
  }
}
