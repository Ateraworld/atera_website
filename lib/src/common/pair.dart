import "package:equatable/equatable.dart";

class Pair<T, T1> extends Equatable {
  const Pair(this.first, this.second);
  final T first;
  final T1 second;

  @override
  List<Object?> get props => [first, second];
}
