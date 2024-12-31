import 'package:cutlink/features/shorten/controller/shorten_bindings.dart';
import 'package:cutlink/core/model/binding.dart';

List<Binding> bindings = [
  ShortenBindings(),
];

Future<void> initDependencies() async {
  for (var binding in bindings) {
    binding.init();
  }
}
