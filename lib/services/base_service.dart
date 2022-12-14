abstract class BaseService<T> {
  Future<List<T>> getAll();

  Future<T> getOne(int id);

  Future<int> insert(T entity);

  Future<bool> update(T id);

  Future<int> delete(int id);
}
