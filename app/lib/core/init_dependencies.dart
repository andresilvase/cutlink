import 'package:app/features/shorten/controller/shorten_bindings.dart';
import 'package:app/core/model/binding.dart';

List<Binding> bindings = [
  ShortenBindings(),
];

Future<void> initDependencies() async {
  for (var binding in bindings) {
    binding.init();
  }
}
