abstract class BaseService<T> {
  Future<List<T>> getAll();

  Future<T> getOne(int id);

  Future<T> insert();

  Future<T> update(int id);

  Future<bool> delete(int id);
}
