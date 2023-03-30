import 'dart:async';

class DropdownBloc<String> {
  final List<String> items;
  final _selectedItemController = StreamController<String>();

  DropdownBloc(this.items);

  Stream<String> get selectedItemStream => _selectedItemController.stream;

  void setSelectedItem(String item) {
    _selectedItemController.add(item);
  }

  void dispose() {
    _selectedItemController.close();
  }
}
