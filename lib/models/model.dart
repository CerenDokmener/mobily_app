import 'package:equatable/equatable.dart';
import 'package:mobily_app/models/leg_color.dart';
import 'package:mobily_app/models/leg_model.dart';
import 'package:mobily_app/models/product.dart';

class Models {
  final String model_name;
  final List<String> products;
  final List<String> fabric;
  final List<String> legColors;
  final List<String> legModels;
  Models(
      {required this.products,
      required this.fabric,
      required this.legColors,
      required this.legModels,
      required this.model_name});

  @override
  List<Object> get props => [model_name];
}
