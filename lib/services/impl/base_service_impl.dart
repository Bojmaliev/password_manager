import 'package:password_manager/di.dart';
import 'package:password_manager/services/base_service.dart';
import 'package:password_manager/repository/local_data.dart';


class BaseServiceImpl<T> implements BaseService<T>{
  final LocalData<T> _localData = getIt<LocalData<T>>();
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
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
  Future<T> update(int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

}