class Food {
  String name;
  double price;

  Food({this.name, this.price});

  @override
  String toString() {
    return '$name + $price';
  }
}
