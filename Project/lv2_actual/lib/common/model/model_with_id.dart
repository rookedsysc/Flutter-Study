
// pagination 할 때 쓸 수 있는 class들이 implement하는 interface
abstract class IModelWithId {
  // 이 모델을 implement하는 모든 클래스는 id를 가져야 함
  final String id;
  IModelWithId({required this.id});
}