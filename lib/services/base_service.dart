abstract class BaseService<T> {
  Future<List<T>> getAll();

  Future<T> getOne(int id);

  Future<int> insert(T entity);

  Future<T> update(int id);

  Future<bool> delete(int id);
}
