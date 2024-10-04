import 'package:flutter/material.dart';
import '../../../shared/constants/app_constants.dart';
import '../../shared/widgets/scrollable_datatable.dart';

abstract class ModelDataTableUI extends StatelessWidget {
  final String title;
  final List listObjects;
  final List<String> listCols;

  List<DataColumn> get cols => _biuldDataTableColumns(listCols);
  List<DataRow> get rows => _buildDataTableRows(listObjects);

  const ModelDataTableUI({
    Key? key,
    required this.title,
    required this.listObjects,
    required this.listCols,
  }) : super(key: key);

  //build rows
  List<DataRow> _buildDataTableRows(List listObjects) {
    return listObjects.map((singleObject) {
      return DataRow(
        cells: buildDataTableCells(singleObject.toJson()),
      );
    }).toList();
  }

  //build columns
  List<DataColumn> _biuldDataTableColumns(List<String> cols) {
    return cols
        .map(
          (field) => DataColumn(
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                field,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        )
        .toList();
  }

  // return UI for table o model
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: MyCustomScrollBehavior(),
      slivers: [
        SliverAppBar(
          title: Text(title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onAddNewPressed();
                    },
                    child: const Row(children: [
                      Text("Add new"),
                      Icon(Icons.add),
                    ]),
                  ),
                ],
              ),
            ),
          ],
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: PaginatedDataTable(
              columns: cols,
              source: DTS(rows),
              rowsPerPage: 8,
              horizontalMargin: 5,
              columnSpacing: kSpacing,
              availableRowsPerPage: const [4, 8, 20, 40],
              onRowsPerPageChanged: (value) {
                // _rowsPerPage = value!;
              },
              initialFirstRowIndex: 0,
              onPageChanged: (rowIndex) {},
              sortColumnIndex: 1,
              sortAscending: true),
        ),
      ],
    );
  }

  //* to be defined upon each entity page *//

  // build rows cells .. render each object into row
  List<DataCell> buildDataTableCells(singleObject);
  // build options cell contains buttons
  DataCell buildOptionsCell(singleObject) {
    return DataCell(
      Row(
        children: [
          IconButton(
            iconSize: 25,
            icon: const Icon(Icons.edit),
            color: Colors.green,
            onPressed: () {
              onEditExistingPressed(singleObject);
            },
          ),
          IconButton(
            iconSize: 25,
            icon: const Icon(Icons.remove_red_eye),
            color: Colors.blue,
            onPressed: () {
              onViewExistingPressed(singleObject);
            },
          ),
          IconButton(
            iconSize: 25,
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              onDeleteExistingPressed(singleObject);
            },
          ),
        ],
      ),
    );
  }

  //* for CRUD Operations *//

  // add new object
  onAddNewPressed();
  // edit existing object
  onEditExistingPressed(singleObject);
  // view details
  onViewExistingPressed(singleObject);
  // delete object
  onDeleteExistingPressed(singleObject);
}

class DTS extends DataTableSource {
  late List _data;

  DTS(List rows) {
    _data = rows;
  }

  @override
  DataRow? getRow(int index) {
    return _data[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
