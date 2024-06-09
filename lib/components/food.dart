import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String description;
  final String taste;
  final Map<String, String> components;
  final List<String> ingredients;
  final Map<String, String> nutritionalInfo;
  final List<String> allergenInfo;
  final List<String> pairings;

  const Food({
    this.name = "",
    this.image = "",
    this.price = 0,
    this.rating = 0,
    this.description = "",
    this.taste = "",
    this.components = const {},
    this.ingredients = const [],
    this.nutritionalInfo = const {},
    this.allergenInfo = const [],
    this.pairings = const [],
  });

  @override
  List<Object?> get props => [name];
}
