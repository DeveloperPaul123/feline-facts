import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:meta/meta.dart';

class CatTriviaModel extends CatTrivia {
  CatTriviaModel({@required String fact, @required int factLength})
      : super(fact: fact, factLength: factLength);

  factory CatTriviaModel.fromMap(Map<String, dynamic> jsonMap) {
    int factLength = -1;
    if(jsonMap.containsKey('length')) {
      factLength = (jsonMap['length'] as num).toInt();
    }
    else {
      factLength = jsonMap['fact'].toString().length;
    }
    return CatTriviaModel(
      fact: jsonMap['fact'], 
      factLength: factLength
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fact': fact,
      'length': factLength 
    };
  }
}
