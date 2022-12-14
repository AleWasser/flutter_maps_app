// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromMap(jsonString);

import 'dart:convert';

class PlacesResponseModel {
  PlacesResponseModel({
    required this.type,
    required this.features,
    required this.attribution,
  });

  final String type;
  final List<Feature> features;
  final String attribution;

  factory PlacesResponseModel.fromJson(String str) =>
      PlacesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponseModel.fromMap(Map<String, dynamic> json) =>
      PlacesResponseModel(
        type: json["type"],
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.textEn,
    required this.languageEn,
    required this.placeNameEn,
    required this.text,
    required this.language,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final Properties properties;
  final String textEn;
  final String? languageEn;
  final String placeNameEn;
  final String text;
  final String? language;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context> context;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromMap(json["properties"]),
        textEn: json["text_en"],
        languageEn: json["language_en"],
        placeNameEn: json["place_name_en"],
        text: json["text"],
        language: json["language"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromMap(json["geometry"]),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toMap(),
        "text_en": textEn,
        "language_en": languageEn,
        "place_name_en": placeNameEn,
        "text": text,
        "language": language,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toMap(),
        "context": List<dynamic>.from(context.map((x) => x.toMap())),
      };
}

class Context {
  Context({
    required this.id,
    required this.shortCode,
    required this.wikidata,
    required this.textEn,
    required this.languageEn,
    required this.text,
    required this.language,
  });

  final String id;
  final String? shortCode;
  final String? wikidata;
  final String? textEn;
  final String? languageEn;
  final String? text;
  final String? language;

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
        textEn: json["text_en"],
        languageEn: json["language_en"],
        text: json["text"],
        language: json["language"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "short_code": shortCode,
        "wikidata": wikidata,
        "text_en": textEn,
        "language_en": languageEn,
        "text": text,
        "language": language,
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  final String type;
  final List<double> coordinates;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    required this.wikidata,
    required this.foursquare,
    required this.landmark,
    required this.category,
    required this.address,
  });

  final String? wikidata;
  final String? foursquare;
  final bool? landmark;
  final String? category;
  final String? address;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        category: json["category"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "wikidata": wikidata,
        "foursquare": foursquare,
        "landmark": landmark,
        "category": category,
        "address": address,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
