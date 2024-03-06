import 'package:felinefacts/domain/entities/cat_trivia.dart';
import 'package:felinefacts/presentation/bloc/cat_trivia_bloc.dart';
import 'package:felinefacts/presentation/widgets/fact_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:felinefacts/injection_container.dart' as di;

class FactsScreen extends StatefulWidget {
  @override
  _FactsScreenState createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  late List<CatTrivia> _factsList = List.empty();
  int _factIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: BlocProvider(
        create: (_) => di.serviceLocator<CatTriviaBloc>(),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                BlocBuilder<CatTriviaBloc, CatTriviaState>(
                    builder: (context, state) {
                  if (state is Empty) {
                    // no stuff
                    BlocProvider.of<CatTriviaBloc>(context)
                        .add(GetCatTriviaListEvent());
                    return FactDisplay(
                      fact: "No facts",
                      index: 0,
                      totalFacts: 0,
                    );
                  } else if (state is Loading) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                      strokeWidth: 4.0,
                    );
                  } else if (state is Loaded) {
                    _factsList = state.triviaList;
                    return FactDisplay(
                        fact: _factsList[_factIndex].fact,
                        index: _factIndex,
                        totalFacts: _factsList.length);
                  }
                  return Text("Oops");
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.navigate_before),
            tooltip: "Previous fact",
            onPressed: _previousFact,
          ),
          SizedBox(
            width: 16.0,
          ),
          FloatingActionButton(
            child: Icon(Icons.navigate_next),
            tooltip: "Next fact",
            onPressed: _nextFact,
          ),
        ],
      ),
    );
  }

  void _previousFact() {
    setState(() {
      if (_factIndex - 1 < 0) {
        _factIndex = _factsList.length - 1;
      } else {
        _factIndex--;
      }
    });

    print("Fact ${_factIndex + 1} of ${_factsList.length}");
  }

  void _nextFact() {
    setState(() {
      if (_factIndex + 1 >= _factsList.length) {
        _factIndex = 0;
      } else {
        _factIndex++;
      }
    });

    print("Fact ${_factIndex + 1} of ${_factsList.length}");
  }
}
