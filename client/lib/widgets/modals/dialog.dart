import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:adhara_socket_io/adhara_socket_io.dart';

// Model
import '../../model/user_model.dart';
// Widgets
import '../usercardInList/alert_Icon.dart';
import '../spinner/spinner.dart';
import './dialog_content.dart';

import '../../config/globals.dart' as globals;

// Creates all dialogs for contaction
class Dialog {
  // getters
  get getDialog => _showDialog;
  get getCancelDialog => _cancelDialog;
  get alternativeDialog => _alternativeDialog;

  // creates a dialog for specified contact
  Future<bool> _showDialog(
      BuildContext context, UserModel user, bool isKnownContact) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(globals.url);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: new Container(
            height: 350.0,
            width: 400.0,
            padding: const EdgeInsets.all(8.0),
            child: DialogContent(
                user: user, isKnownContact: isKnownContact, socket: socket),
          ),
        );
      },
    );
  }

  // Creates a alternate contact dialog for unspecified contact
  Future<bool> _alternativeDialog(
      BuildContext context, bool isKnownContact) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(globals.url);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: new Container(
            height: 350.0,
            width: 400.0,
            padding: const EdgeInsets.all(8.0),
            child:
                DialogContent(isKnownContact: isKnownContact, socket: socket),
          ),
        );
      },
    );
  }

  // Create a dialog to cancel contact
  Future<bool> _cancelDialog(
      BuildContext context, makeRequest, timer, setTimer, apiKey) async {
    // on direct contact the a request is sent and timer set to 0
    _contactDirect(BuildContext context) {
      makeRequest(apiKey);
      setTimer(0);
      Navigator.of(context).pop(true);
    }

    // on cancel the timer is reseted and the dialog is removed
    _cancelRequest(BuildContext context, timer) {
      timer.cancel();
      setTimer(3000);
      Navigator.of(context).pop(true);
    }

    Widget loadingSpinner() {
      return Positioned(
        child: Center(
          child: SpinKitRing1(
              duration: const Duration(milliseconds: 5500),
              color: Theme.of(context).accentColor,
              size: 135.0,
              lineWidth: 6.0),
        ),
      );
    }

    Widget contactDirectButton() {
      return Positioned(
        child: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: GestureDetector(
                  onTap: () => _contactDirect(context),
                  child: AlertIcon(size: 80, color: Colors.white)),
            ),
          ),
        ),
      );
    }

    Widget cancelRequestButton() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton.icon(
          color: Colors.white,
          textColor: Colors.black,
          onPressed: () => _cancelRequest(context, timer),
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          label: Text(globals.cancelText),
        ),
      );
    }

    _modalContainer(BuildContext context) {
      return WillPopScope(
        onWillPop: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[loadingSpinner(), contactDirectButton()],
            ),
            cancelRequestButton()
          ],
        ),
      );
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) => _modalContainer(context),
    );
  }
}

Dialog dialog = new Dialog();
