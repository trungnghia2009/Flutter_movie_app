import 'package:flutterpackagemath/flutterpackagemath.dart' as Math;

main(List<String> arguments) {
  List a = [1, 2, 3, 4, 5, 6, 7, 1, 3, 4, 5, 6, 7];
  a = Set.of(a).toList();
  print(a);
}
