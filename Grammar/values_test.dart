void main() {
  List<String> alphbet = [ 'a', 'b', 'c' ];
  print(PriceType.values); // [ PriceType.fixed, PriceType.variable ]

  // values.name들 중에서 'fixed'와 같은 첫 번째 값을 찾아서 반환
  print(PriceType.values.firstWhere((e) => e.name == 'fixed')); 
}

enum PriceType {
  fixed,
  variable,
}