import 'package:equatable/equatable.dart';

class LegsModels {
  final String leg_model;

  LegsModels({
    this.leg_model = ' ',
  });

  @override
  List<Object> get props => [leg_model];
}
