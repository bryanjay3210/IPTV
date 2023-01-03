import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iptv/core/models/program.dart';

class EmptyMapToStringConverter implements JsonConverter<String, Object> {
  const EmptyMapToStringConverter();

  @override
  String fromJson(Object json) {
    if (json is Map<String, dynamic>) return '';
    return json.toString();
  }

  @override
  Object toJson(String object) {
    if (object == '') return {};
    return object;
  }
}

class EpochConverter implements JsonConverter<DateTime, String> {
  const EpochConverter();

  @override
  DateTime fromJson(String date) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(date) * 1000);
  }

  @override
  String toJson(DateTime data) =>
      (data.millisecondsSinceEpoch / 1000).toString();
}

class TimeCodeConverter implements JsonConverter<DateTime, String> {
  const TimeCodeConverter();

  @override
  DateTime fromJson(String date) {
    return DateTime.parse(dateTimeStringConverter(date)).toUtc().toLocal();
  }

  @override
  String toJson(DateTime data) => data.toIso8601String();

  String dateTimeStringConverter(
    String date, {
    bool isUtc = false,
  }) {
    final year = int.parse(date.substring(0, 4));
    final month = int.parse(date.substring(4, 6));
    final day = int.parse(date.substring(6, 8));
    final hour = int.parse(date.substring(8, 10));
    final minute = int.parse(date.substring(10, 12));
    final second = int.parse(date.substring(12, 14));

    return '''$year-${month.toString().padLeft(2, '0')}-$day ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}Z''';
  }
}

class YNConverter implements JsonConverter<bool, String> {
  const YNConverter();

  @override
  bool fromJson(String json) {
    if (json == 'Y') return true;
    return false;
  }

  @override
  String toJson(bool object) {
    return object ? 'Y' : 'N';
  }
}

class TFConverter implements JsonConverter<bool, String> {
  const TFConverter();

  @override
  bool fromJson(String json) {
    if (json == 'T') return true;
    return false;
  }

  @override
  String toJson(bool object) {
    return object ? 'Y' : 'N';
  }
}

class EmptyMapToSingleProgramListConverter
    implements JsonConverter<List<Program>, Object> {
  const EmptyMapToSingleProgramListConverter();

  @override
  List<Program> fromJson(Object json) {
    if (json is! List<dynamic>) {
      return [Program.fromJson(json as Map<String, dynamic>)];
    }
    final listPrograms = <Program>[];
    for (final element in json) {
      listPrograms.add(Program.fromJson(element as Map<String, dynamic>));
    }

    return listPrograms;
  }

  @override
  Object toJson(List<Program> object) {
    return object;
  }
}

class GenreConverter implements JsonConverter<String, Object> {
  const GenreConverter();

  @override
  String fromJson(Object json) {
    if (json is Map<String, dynamic>) return 'Uncategorized';
    return json.toString();
  }

  @override
  Object toJson(String object) {
    if (object == 'Uncategorized') return {};
    return object;
  }
}
