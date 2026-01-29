import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/per_page_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';

abstract class DataTableModel {
  int get id;
  List<String> get values;
}

abstract class MainDataTableCallbacks {
  void onFirstPageTap();
  void onNextPageTap();
  void onPreviousPageTap();
  void onLastPageTap();
  void onPerPageSelected(PerPageEnum? perPage);
}

class MainDataTable<T extends DataTableModel> extends StatefulWidget {
  const MainDataTable({
    super.key,
    required this.titles,
    required this.items,
    required this.onPageChanged,
    this.onEditTap,
    this.onDeleteTap,
    this.onShowDetailsTap,
    this.emptyMessage,
    this.header,
    this.searchHint = "search",
    this.onSearchChanged,
    this.bottomHeight = 100,
    this.filters = const [],
    this.customButtons = _emptyButtons,
    this.onSelected,
    this.onLongPress,
    this.checkSelected,
    this.showCheckboxColumn = false,

    /// ✅ يبني Widget مخصص لخلية معينة (شكل فقط)
    /// columnIndex ضمن item.values (بدون عمود event/actions).
    this.cellBuilder,

    /// ✅ NEW: يحدد إن كانت خلية معينة قابلة للضغط (بدون كسر ضغط الصف)
    this.isCellTappable,

    /// ✅ NEW: ينفذ الإجراء عند ضغط الخلية
    this.onCellTap,
  });

  final String? header;
  final List<String> titles;
  final PaginatedModel<T> items;
  final String? emptyMessage;
  final String searchHint;
  final double bottomHeight;
  final List<Widget> filters;
  final List<Widget> Function(T item) customButtons;
  final bool showCheckboxColumn;
  final void Function(String input)? onSearchChanged;
  final void Function(int page, int perPage) onPageChanged;
  final void Function(T item)? onLongPress;
  final bool Function(T item)? checkSelected;
  final void Function(T item)? onSelected;
  final void Function(T item)? onShowDetailsTap;
  final void Function(T item)? onEditTap;
  final void Function(T item)? onDeleteTap;

  /// rowIndex: index ضمن items.data
  /// columnIndex: index ضمن item.values
  /// value: نص الخلية الافتراضي
  final Widget? Function(
      BuildContext context,
      T item,
      int rowIndex,
      int columnIndex,
      String value,
      )? cellBuilder;

  /// ✅ NEW
  /// إذا true: نضيف onTap على DataCell نفسها (بدون InkWell داخل الخلية)
  final bool Function(
      T item,
      int rowIndex,
      int columnIndex,
      )? isCellTappable;

  /// ✅ NEW
  final void Function(
      T item,
      int rowIndex,
      int columnIndex,
      )? onCellTap;

  static List<Widget> _emptyButtons(DataTableModel item) => const [];

  @override
  State<MainDataTable<T>> createState() => _MainDataTableState<T>();
}

class _MainDataTableState<T extends DataTableModel> extends State<MainDataTable<T>>
    implements MainDataTableCallbacks {
  late int page = widget.items.meta.currentPage;
  late int perPage = widget.items.meta.perPage;

  @override
  void onFirstPageTap() => widget.onPageChanged(1, perPage);

  @override
  void onLastPageTap() =>
      widget.onPageChanged(widget.items.meta.totalPages, perPage);

  @override
  void onNextPageTap() {
    if (page != widget.items.meta.totalPages) {
      widget.onPageChanged(page + 1, perPage);
    }
  }

  @override
  void onPreviousPageTap() {
    if (page != 1) {
      widget.onPageChanged(page - 1, perPage);
    }
  }

  @override
  void onPerPageSelected(PerPageEnum? perPage) {
    if (perPage != null) {
      widget.onPageChanged(1, perPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.onPageChanged(page, perPage),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            if (widget.header != null) _buildHeader(),
            ...widget.filters,
            const SizedBox(height: 4),
            _buildSearch(),
            const SizedBox(height: 4),
            _buildTable(),
            _buildEmptyWidget(),
            _buildPaginator(),
            SizedBox(height: widget.bottomHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(widget.header!, style: context.tt.headlineSmall);
  }

  Widget _buildSearch() {
    if (widget.onSearchChanged == null) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Expanded(
          child: MainTextField(
            borderRadius: AppConstants.borderRadius10,
            onChanged: widget.onSearchChanged,
            hintText: widget.searchHint.tr(),
            prefixIcon: Icon(
              Icons.search,
              color: context.cs.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    final titles = widget.titles;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: widget.showCheckboxColumn,
        dividerThickness: 1,
        headingRowColor: WidgetStatePropertyAll(context.cs.primary),
        border: TableBorder.all(width: 1),
        columns: List.generate(titles.length, (index) {
          final title = titles[index];
          return DataColumn2(
            headingRowAlignment: MainAxisAlignment.center,
            label: Text(
              title,
              style: context.tt.titleLarge?.copyWith(
                color: context.cs.onTertiary,
              ),
            ),
          );
        }),
        rows: List.generate(widget.items.data.length, (rowIndex) {
          final item = widget.items.data[rowIndex];

          // ✅ خلايا القيم (بدون event/actions)
          final values = item.values;
          final cells = List<DataCell>.generate(values.length, (colIndex) {
            final value = values[colIndex];

            final custom = widget.cellBuilder?.call(
              context,
              item,
              rowIndex,
              colIndex,
              value,
            );

            final tappable =
                widget.isCellTappable?.call(item, rowIndex, colIndex) ?? false;

            return DataCell(
              Center(child: custom ?? Text(value)),
              // ✅ هنا الحل: onTap للخلية نفسها بدون InkWell
              onTap: tappable
                  ? () => widget.onCellTap?.call(item, rowIndex, colIndex)
                  : null,
            );
          });

          // ✅ عمود event/actions كما هو
          cells.add(
            DataCell(
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.onShowDetailsTap != null)
                      IconButton(
                        onPressed: () => widget.onShowDetailsTap!(item),
                        icon: Icon(
                          Icons.visibility,
                          color: context.cs.onPrimaryFixed,
                        ),
                      ),
                    if (widget.onEditTap != null)
                      IconButton(
                        onPressed: () => widget.onEditTap!(item),
                        icon: Icon(Icons.edit, color: context.cs.primary),
                      ),
                    if (widget.onDeleteTap != null)
                      IconButton(
                        onPressed: () => widget.onDeleteTap!(item),
                        icon: Icon(Icons.delete, color: context.cs.error),
                      ),
                    ...widget.customButtons(item),
                  ],
                ),
              ),
            ),
          );

          return DataRow2(
            color: WidgetStatePropertyAll(
              widget.checkSelected?.call(item) ?? false
                  ? context.cs.primary.withValues(alpha: 0.2)
                  : context.cs.surface,
            ),
            selected: widget.checkSelected?.call(item) ?? false,
            onLongPress: () => widget.onLongPress?.call(item),
            onSelectChanged: (value) => widget.onSelected?.call(item),
            cells: cells,
          );
        }),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    final emptyMessage = widget.emptyMessage;
    if (emptyMessage != null) {
      return MainErrorWidget(error: emptyMessage, isRefresh: true);
    }
    return const SizedBox.shrink();
  }

  Widget _buildPaginator() {
    final perPage = this.perPage < 10 ? "10" : this.perPage.toString();
    final meta = widget.items.meta;

    return Row(
      textDirection: TextDirection.rtl,
      children: [
        PopupMenuButton<PerPageEnum>(
          offset: const Offset(0, 30),
          initialValue: PerPageEnum.ten,
          padding: AppConstants.padding0,
          constraints: const BoxConstraints(maxWidth: 60),
          itemBuilder: (context) {
            return PerPageEnum.values.map((perPageItem) {
              return PopupMenuItem<PerPageEnum>(
                height: 30,
                child: Text(
                  perPageItem.displayName,
                  style: context.tt.bodyMedium,
                ),
                onTap: () => onPerPageSelected(perPageItem),
              );
            }).toList();
          },
          child: Row(
            children: [
              Text(perPage),
              const SizedBox(width: 5),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        IconButton(
          onPressed: onLastPageTap,
          icon: const Icon(Icons.keyboard_double_arrow_right),
        ),
        IconButton(
          onPressed: onNextPageTap,
          icon: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: page != meta.totalPages
                ? context.cs.secondary
                : context.cs.onSecondaryFixed,
          ),
        ),
        const Spacer(),
        Text("${meta.currentPage} ${"of".tr()} ${meta.totalPages}"),
        const Spacer(),
        IconButton(
          onPressed: onPreviousPageTap,
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 30,
            color:
            page != 1 ? context.cs.secondary : context.cs.onSecondaryFixed,
          ),
        ),
        IconButton(
          onPressed: onFirstPageTap,
          icon: const Icon(Icons.keyboard_double_arrow_left),
        ),
      ],
    );
  }
}
