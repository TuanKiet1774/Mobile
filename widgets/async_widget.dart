import 'package:flutter/material.dart';

class AsyncWidget extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final Widget Function()? loading;
  String? errorMessage;
  final Widget Function()? error;
  final Widget Function(BuildContext context, AsyncSnapshot snapshot) builder;
  AsyncWidget({
    super.key,
    required this.snapshot,
    this.error,
    this.errorMessage = "Lỗi rồi",
    this.loading,
    required this.builder
  });

  @override

  Widget build(BuildContext context) {
    if(snapshot.hasError){
      return error == null ? Center(child: Text(errorMessage!,
        style: TextStyle(
            color: Colors.red),)) : error!();
    }
    if(!snapshot.hasData){
      return loading == null ? const Center(
        child: CircularProgressIndicator(),) :
      loading!();
    }
    return builder(context, snapshot);
  }
}