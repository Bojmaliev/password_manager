import 'package:password_manager/di.dart';
import 'package:password_manager/services/base_service.dart';
import 'package:password_manager/repository/local_data.dart';

class BaseServiceImpl<T> implements BaseService<T> {
  final LocalData<T> _localData = getIt<LocalData<T>>();

  @override
  Future<int> delete(int id) {
    return _localData.delete(id);
  }

  @override
  Future<List<T>> getAll() {
    return _localData.getAll();
  }

  @override
  Future<T> getOne(int id) {
    return _localData.getOne(id);
  }

  @override
  Future<int> insert(T entity) {
    return _localData.insert(entity);
  }

  @override
  Future<bool> update(T entity) {
    return _localData.update(entity);
  }
}
