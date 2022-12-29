import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lv2_actual/common/model/cursor_pagination_model.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/provider/pagination_provider.dart';
import 'package:lv2_actual/common/utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  const PaginationListView(
      {required this.provider, required this.itemBuilder, super.key});

  @override
  ConsumerState<PaginationListView> createState() => PaginationListViewState<T>();
}

class PaginationListViewState<T extends IModelWithId> extends ConsumerState<PaginationListView> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(listner);
  }

  void listner() {
    PaginationUtils.paginate(controller: controller, provider: ref.read(widget.provider.notifier));
  }

  @override
  void dispose() {
    controller.removeListener(listner);
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(state.message),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {
            ref.read(widget.provider.notifier).paginate(forceRefetch: true);
          }, child: Text('다시 시도'),)
        ],
      );
      }

    // CursorPaggination || CursorPagginationFetchingMore || CursorPagginationRefetching 
    // 현재 데이터의 타입은 CursorPaginationBase임
    // 여기에서는 state를 정상적으로 받아왔을 경우이므로 state를 정상적으로 받아온 경우 Typedms CursorPagination임
    // 따라서 state를 CursorPagination으로 형변환을 해줌
    final cp = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Scrollbar(
        controller: controller,
        child: ListView.separated(
          controller: controller,
          itemCount: cp.data.length + 1, // +1은 로딩을 위해서 
          itemBuilder: (context, index) { 
            if(index == cp.data.length) {
              // 데이터가 FetchingMore(로딩 중)인 경우에만 ProgressIndicator를 보여줌
              return Center(child: cp is CursorPaginationFetchingMore ? const CircularProgressIndicator() : const SizedBox());
            }

            final pItem = cp.data[index];

            return widget.itemBuilder(
              context,
              index,
              pItem,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
        ),
      ),
    );;
  }
}