import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/model/pagination_params.dart';

// IBasePaginationRepository를 impelement할 때마다 
// 어떤 타입의 데이터를 paginate할지 정할 수 있음
abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}