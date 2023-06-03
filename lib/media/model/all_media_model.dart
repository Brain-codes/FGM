// To parse this JSON data, do
//
//     final allMediaModel = allMediaModelFromJson(jsonString);

import 'dart:convert';

AllMediaModel allMediaModelFromJson(String str) =>
    AllMediaModel.fromJson(json.decode(str));

String allMediaModelToJson(AllMediaModel data) => json.encode(data.toJson());

class AllMediaModel {
  AllMediaModel({
    this.title,
    this.name,
    this.image,
    this.audio,
    this.id,
    this.date,
    this.progress,
    this.isPlaying,
  });

  String? title;
  String? name;
  ImageClass? image;
  ImageClass? audio;
  String? id;
  String? date;
  double? progress;
  bool? isPlaying;

  factory AllMediaModel.fromJson(Map<String, dynamic> json) => AllMediaModel(
        title: json["title"],
        name: json["name"],
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
        audio:
            json["audio"] == null ? null : ImageClass.fromJson(json["audio"]),
        id: json["id"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "image": image?.toJson(),
        "audio": audio?.toJson(),
        "id": id,
        "date": date,
      };
}

class ImageClass {
  ImageClass({
    this.assetId,
    this.publicId,
    this.version,
    this.versionId,
    this.signature,
    // this.width,
    // this.height,
    this.format,
    this.resourceType,
    this.createdAt,
    this.tags,
    // this.pages,
    // this.bytes,
    this.type,
    this.etag,
    this.placeholder,
    this.url,
    this.secureUrl,
    this.playbackUrl,
    this.folder,
    this.accessMode,
    this.existing,
    this.audio,
    this.isAudio,
    this.bitRate,
    this.duration,
    this.originalFilename,
  });

  String? assetId;
  String? publicId;
  int? version;
  String? versionId;
  String? signature;
  // int? width;
  // int? height;
  String? format;
  String? resourceType;
  DateTime? createdAt;
  List<dynamic>? tags;
  // int? pages;
  // int? bytes;
  String? type;
  String? etag;
  bool? placeholder;
  String? url;
  String? secureUrl;
  String? playbackUrl;
  String? folder;
  String? accessMode;
  bool? existing;
  AudioAudio? audio;
  bool? isAudio;
  int? bitRate;
  double? duration;
  String? originalFilename;

  factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
        assetId: json["asset_id"],
        publicId: json["public_id"],
        version: json["version"],
        versionId: json["version_id"],
        signature: json["signature"],
        // width: json["width"],
        // height: json["height"],
        format: json["format"],
        resourceType: json["resource_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        tags: json["tags"] == null
            ? []
            : List<dynamic>.from(json["tags"]!.map((x) => x)),
        // pages: json["pages"],
        // bytes: json["bytes"],
        type: json["type"],
        etag: json["etag"],
        placeholder: json["placeholder"],
        url: json["url"],
        secureUrl: json["secure_url"],
        playbackUrl: json["playback_url"],
        folder: json["folder"],
        accessMode: json["access_mode"],
        existing: json["existing"],
        audio:
            json["audio"] == null ? null : AudioAudio.fromJson(json["audio"]),
        isAudio: json["is_audio"],
        bitRate: json["bit_rate"],
        duration: json["duration"]?.toDouble(),
        originalFilename: json["original_filename"],
      );

  Map<String, dynamic> toJson() => {
        "asset_id": assetId,
        "public_id": publicId,
        "version": version,
        "version_id": versionId,
        "signature": signature,
        // "width": width,
        // "height": height,
        "format": format,
        "resource_type": resourceType,
        "created_at": createdAt?.toIso8601String(),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        // "pages": pages,
        // "bytes": bytes,
        "type": type,
        "etag": etag,
        "placeholder": placeholder,
        "url": url,
        "secure_url": secureUrl,
        "playback_url": playbackUrl,
        "folder": folder,
        "access_mode": accessMode,
        "existing": existing,
        "audio": audio?.toJson(),
        "is_audio": isAudio,
        "bit_rate": bitRate,
        "duration": duration,
        "original_filename": originalFilename,
      };
}

class AudioAudio {
  AudioAudio({
    this.codec,
    this.bitRate,
    this.frequency,
    this.channels,
    this.channelLayout,
  });

  String? codec;
  String? bitRate;
  int? frequency;
  int? channels;
  String? channelLayout;

  factory AudioAudio.fromJson(Map<String, dynamic> json) => AudioAudio(
        codec: json["codec"],
        bitRate: json["bit_rate"],
        frequency: json["frequency"],
        channels: json["channels"],
        channelLayout: json["channel_layout"],
      );

  Map<String, dynamic> toJson() => {
        "codec": codec,
        "bit_rate": bitRate,
        "frequency": frequency,
        "channels": channels,
        "channel_layout": channelLayout,
      };
}
