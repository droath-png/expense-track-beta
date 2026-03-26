import 'dart:async';
import '../classes/input_model.dart';

/// In-memory database stub for web platform.
abstract class DB {
  static List<Map<String, dynamic>> _rows = [];
  static int _nextId = 1;

  static Future<void> init() async {
    // no-op for web
  }

  static Future<List<InputModel>> inputModelList() async {
    return _rows.map((item) => InputModel.fromMap(item)).toList();
  }

  static Future<int> insert(InputModel model) async {
    final map = model.toMap();
    map['id'] = _nextId++;
    _rows.add(map);
    return map['id'] as int;
  }

  static Future<int> update(InputModel model) async {
    final idx = _rows.indexWhere((r) => r['id'] == model.id);
    if (idx >= 0) {
      _rows[idx] = model.toMap();
    }
    return 1;
  }

  static Future<int> delete(int id) async {
    _rows.removeWhere((r) => r['id'] == id);
    return 1;
  }

  static Future<int> deleteAll() async {
    _rows.clear();
    return 1;
  }
}
