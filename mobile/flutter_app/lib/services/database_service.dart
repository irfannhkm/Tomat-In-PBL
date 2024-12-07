import 'package:postgres/postgres.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();

  late Connection _connection;

  DatabaseService._internal();

  Future<void> init() async {
    _connection = await Connection.open(
      Endpoint(
        host: '127.0.0.1',
        database: 'postgres',
        username: 'postgres',
        password: 'Growbeyond2711',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    print('Koneksi ke Database berhasil!');
    await _createHistoryTable();
  }

  Future<void> _createHistoryTable() async {
    const createTableQuery = '''
    CREATE TABLE IF NOT EXISTS detection_history (
      id SERIAL PRIMARY KEY,
      image_path TEXT NOT NULL,
      disease_name TEXT NOT NULL,
      accuracy REAL NOT NULL,
      detection_date TIMESTAMP NOT NULL
    );
    ''';
    await _connection.execute(createTableQuery);
  }

  Future<void> insertHistory(Map<String, dynamic> data) async {
    const insertQuery = '''
    INSERT INTO detection_history (image_path, disease_name, accuracy, detection_date)
    VALUES (@image_path, @disease_name, @accuracy, @detection_date);
    ''';

    await _connection.execute(
      Sql(insertQuery),
      parameters: {
        'image_path': data['imagePath'],
        'disease_name': data['diseaseName'],
        'accuracy': data['accuracy'],
        'detection_date': data['date'],
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchHistory() async {
    const fetchQuery =
        'SELECT * FROM detection_history ORDER BY detection_date DESC';
    final results = await _connection.execute(Sql(fetchQuery));
    return results.map((row) => row.toColumnMap()).toList();
  }

  Future<void> close() async {
    await _connection.close();
    print('Koneksi ke Database ditutup.');
  }
}
