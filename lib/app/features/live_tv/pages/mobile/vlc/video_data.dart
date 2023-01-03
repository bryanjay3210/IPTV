enum VideoType {
  asset,
  file,
  network,
  recorded,
}

class VideoData {
  VideoData(this.name, this.path, this.type);
  final String name;
  final String path;
  final VideoType type;
}
