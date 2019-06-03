import 'package:flutter/material.dart';
import '../../bloc/bloc.dart';
import '../../bloc/provider.dart';

// Creates a input field
class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Material(
      child: Column(
        children: <Widget>[
          _renderTextInput(bloc),
        ],
      ),
    );
  }

  // Text in input field are sent via streams to bloc
  Widget _renderTextInput(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.searchedUserStream,
      builder: (context, snapshot) {
        return Container(
          color: Theme.of(context).primaryColor,
          child: TextField(
            autofocus: false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white),
            keyboardType: TextInputType.text,
            onChanged: bloc.changeSearchBarInput,
          ),
        );
      },
    );
  }
}
