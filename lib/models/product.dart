import 'package:equatable/equatable.dart';

class Products {
  final String numbers;
  final String ad;
  Products({this.numbers = '', this.ad = ' '});

  @override
  List<Object> get props => [numbers];
}
