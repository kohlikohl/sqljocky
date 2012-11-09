part of sqljocky;

class Results implements Iterable {
  final OkPacket _okPacket;
  final List<Field> _fieldPackets;
  final List<DataPacket> _dataPackets;
  final ResultSetHeaderPacket _resultSetHeaderPacket;

  Results(OkPacket this._okPacket,
    ResultSetHeaderPacket this._resultSetHeaderPacket,
    List<Field> this._fieldPackets,
    List<DataPacket> this._dataPackets);
  
  int get insertId=> _okPacket.insertId;
  
  int get affectedRows => _okPacket.affectedRows;
  
  int get count => _dataPackets.length;
  
  List<Field> get fields => _fieldPackets;
  
  List<dynamic> operator [](int pos) => _dataPackets[pos].values;
  
  Iterator<List<dynamic>> iterator() => new ResultsIterator( this );
}

class ResultsIterator implements Iterator<dynamic> {
  Results _results;
  int i = 0;
  
  ResultsIterator( Results results ) {
    _results = results;
    
    print('ITERATOR');
    print( results.count );
    print( hasNext() );
  }
  
  bool hasNext () {
    return i < _results._dataPackets.length;
  }
  
  List<dynamic> next() => _results._dataPackets[i++].values;
}