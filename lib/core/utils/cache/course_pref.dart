import 'package:hive/hive.dart';

class CoursePref {
  static late final CoursePref _instance;

  static const _courseBox = 'courseBox';
  static const _courseKey = 'courses';
  static const _curriculumKey = 'curriculums';

  final Box<List<Map<String, dynamic>>> _box;
  CoursePref._(this._box);

  static Future<void> init() async {
    final box = await Hive.openBox<List<Map<String, dynamic>>>(_courseBox);
    _instance = CoursePref._(box);
  }

  static CoursePref get instance => _instance;
  Future clean() async => await _box.clear();

  List<Map<String, dynamic>> _getValue(dynamic key) =>
      _box.get(key, defaultValue: []) as List<Map<String, dynamic>>;

  Future<void> _setValue(dynamic key, List<Map<String, dynamic>> value) =>
      _box.put(key, value);

  (List<Map<String, dynamic>>, List<Map<String, dynamic>>) getAllCourses() =>
      (_getValue(_courseKey), _getValue(_curriculumKey));

  Future<void> setAllCourses({
    required List<Map<String, dynamic>> courses,
    required List<Map<String, dynamic>> curriculums,
  }) async {
    _setValue(_courseKey, courses);
    _setValue(_curriculumKey, curriculums);
  }

  Future<void> createCourse({
    required Map<String, dynamic> newCourse,
    required Map<String, dynamic> newCurriculum,
  }) async {
    await Future.wait([
      _createHelper(_courseKey, newCourse),
      _createHelper(_curriculumKey, newCurriculum),
    ]);
  }

  Future<void> _createHelper(
    String key,
    Map<String, dynamic> newElement,
  ) async {
    final allElements = _getValue(key);

    allElements.add(newElement);
    await _setValue(key, allElements);
  }

  Future<void> updateCourse({
    required String? courseId,
    required String? curriculumId,
    required Map<String, dynamic>? updatedCourse,
    required Map<String, dynamic>? updatedCurriculum,
  }) async {
    await Future.wait([
      if (courseId != null) _updateHelper(courseId, _courseKey, updatedCourse),
      if (curriculumId != null)
        _updateHelper(curriculumId, _curriculumKey, updatedCurriculum),
    ]);
  }

  Future<void> _updateHelper(
    String id,
    String key,
    Map<String, dynamic>? updatedContent,
  ) async {
    final allElements = _getValue(key);

    if (updatedContent == null) return;

    final index = allElements.indexWhere((element) => element['id'] == id);
    allElements[index] = updatedContent;
    await _setValue(key, allElements);
  }

  Future<void> deleteCourse({
    required String courseId,
    required String curriculumId,
  }) async {
    await Future.wait([
      _deleteHelper(courseId, _courseKey),
      _deleteHelper(curriculumId, _curriculumKey),
    ]);
  }

  Future<void> _deleteHelper(String id, String key) async {
    final allElement = _getValue(key);

    final index = allElement.indexWhere((element) => element['id'] == id);
    allElement.removeAt(index);
    await _setValue(key, allElement);
  }
}
