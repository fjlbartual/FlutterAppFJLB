import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ipm_p2/locale/localization.i18n.dart';

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

class Faces {
  final List<Attributes> attributes;
  final Coordinates coordinates;

  Faces({this.attributes, this.coordinates});

  factory Faces.fromJson(Map<String, dynamic> json) {
    var list = json['attributes'] as List;
    List<Attributes> attributesList =
        list.map((i) => Attributes.fromJson(i)).toList();
    return Faces(
      attributes: attributesList,
      coordinates: json['coordinates'] != null
          ? new Coordinates.fromJson(json['coordinates'])
          : null,
    );
  }
}

class Attributes {
  final String label;
  final String type;

  Attributes({this.label, this.type});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      label: json['label'] != null ? json['label'] : 'Indeterminado'.i18n,
      type: json['type'] != null ? json['type'] : 'Unknown'.i18n,
    );
  }
}

class Coordinates {
  final int height;
  final int width;
  final int xmax;
  final int xmin;
  final int ymax;
  final int ymin;

  Coordinates(
      {this.height, this.width, this.xmax, this.xmin, this.ymax, this.ymin});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      height: json['height'] != null ? json['height'] : 0,
      width: json['width'] != null ? json['width'] : 0,
      xmax: json['xmax'] != null ? json['xmax'] : 0,
      xmin: json['xmin'] != null ? json['xmin'] : 0,
      ymax: json['ymax'] != null ? json['ymax'] : 0,
      ymin: json['ymin'] != null ? json['ymin'] : 0,
    );
  }
}

class Status {
  final String text;
  final String type;

  Status({this.text, this.type});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      text: json['text'] != null ? json['text'] : 'Unknown'.i18n,
      type: json['type'] != null ? json['type'] : 'Unknown'.i18n,
    );
  }
}
