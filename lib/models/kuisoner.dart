import 'package:hive/hive.dart';
import 'checklits.dart';

part 'kuisoner.g.dart';

@HiveType(typeId: 5)
class Kuisioner {
  @HiveField(0)
  Check question;
  @HiveField(1)
  dynamic value;

  Kuisioner({required this.question, this.value});
}