import 'package:equatable/equatable.dart';

class LegsColors {
  final String leg_color;

  LegsColors({
    this.leg_color = ' ',
  });

  @override
  List<Object> get props => [leg_color];
}
