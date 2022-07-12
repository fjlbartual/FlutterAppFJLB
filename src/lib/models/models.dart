import 'package:ipm_p2/locale/localization.i18n.dart';

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
