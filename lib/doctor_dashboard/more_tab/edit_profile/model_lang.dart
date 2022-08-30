// To parse this JSON data, do
//
//     final languages = languagesFromJson(jsonString);

import 'dart:convert';

List<ModelLanguages> languagesFromJson(String str) => List<ModelLanguages>.from(json.decode(str).map((x) => ModelLanguages.fromJson(x)));

String languagesToJson(List<ModelLanguages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelLanguages {
  ModelLanguages({
    this.language,
  });

  String? language;

  factory ModelLanguages.fromJson(Map<String, dynamic> json) => ModelLanguages(
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
  };
}

class ModelLanguages2{
  ModelLanguages2({
    this.language,
    this.index
  });
  String? language;
  String? index;
  Map toJson() => {
    'language': language,
    'index': index,
  };
}

