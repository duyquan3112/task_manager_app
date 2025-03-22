enum FilterType {
  all(2, "All"),
  uncompleted(0, "Uncompleted");

  final int id;
  final String value;

  const FilterType(this.id, this.value);
}
