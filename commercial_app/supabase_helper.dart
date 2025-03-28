import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> removeImage({required String bucket, required String path}) async{
  await supabase.storage.from(bucket).remove([path]);
}
Stream <List<T>> getDataStream<T>({
  required String table,
  required List<String> ids,
  required T Function(Map<String, dynamic> json) fromJson,
})
{
  var stream = supabase.from(table).stream(primaryKey: ids);
  return stream.map((mapList) =>
    mapList.map(
      (map) => fromJson(map),
    ).toList(),);
}

Future<Map<int, T>> getMapData<T>({
  required String table,
  required T Function(Map<String, dynamic> json) fromJson,
  required int Function(T t) getID,
}) async{
  final supabase = Supabase.instance.client;
  final data = await supabase.from(table).select();
  var iterable = data.map((e) => fromJson(e),);
  Map<int, T> _maps = Map.fromIterable(
    iterable,
    key: (t) => getID(t),
    value: (t) => t,
  );
  return _maps;
}

listenDataChange<T>(Map<int, T> maps, {
  Function()? updateUI,
  required String table,
  required String schema,
  required String channel,
  required T Function(Map<String, dynamic> json) fromJson,
  required int Function(T t) getID,
}){
    final supabase = Supabase.instance.client;
    supabase
        .channel(channel) //cái này là ID channel, ghi gì cũng đc
        .onPostgresChanges(
        event: PostgresChangeEvent.all, //lắng nghe tất cả
        schema: schema,
        table: table,
        callback: (payload) {
          print('Change received: ${payload.toString()}');
          switch(payload.eventType){
            case PostgresChangeEvent.update :{
              T t = fromJson(payload.newRecord);
              maps[getID(t)] = t;
              updateUI?.call();
              break;
            }
          // case "UPDATE":{
          //   Fruit f = Fruit.fromJson(payload.newRecord);
          //   maps[f.id] = f;
          //   updateUI?.call();
          // }
            case PostgresChangeEvent.insert :{
              T t = fromJson(payload.newRecord);
              maps[getID(t)] = t;
              updateUI?.call();
              break;
            }
            case PostgresChangeEvent.delete :{
              maps.remove(payload.oldRecord["id"]);
              updateUI?.call();
              break;
            }
            default: {}
          }
        })
        .subscribe();
  }