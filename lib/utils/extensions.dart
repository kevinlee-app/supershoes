extension StringExtensions on double {
  String toIDR() {
    return 'Rp. $this';
  }
}

extension IntExtensions on int {
  String toQuantity() {
    final unit = this > 1 ? 'Items' : 'Item';
    return '$this $unit';
  }
}