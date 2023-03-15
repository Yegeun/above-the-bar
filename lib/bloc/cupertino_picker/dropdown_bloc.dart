import 'dart:async';

class DropdownBloc<T> {
  final List<T> items;
  final _selectedItemController = StreamController<T>();

  DropdownBloc(this.items);

  Stream<T> get selectedItemStream => _selectedItemController.stream;

  void setSelectedItem(T item) {
    _selectedItemController.add(item);
  }

  void dispose() {
    _selectedItemController.close();
  }
}
