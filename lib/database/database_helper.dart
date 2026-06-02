import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jucai.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        user_id TEXT PRIMARY KEY,
        username TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE asset_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT,
        has_depreciation INTEGER DEFAULT 0,
        depreciation_rate REAL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE assets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        asset_type_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        current_value REAL NOT NULL,
        purchase_value REAL,
        purchase_date TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE liabilities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        name TEXT NOT NULL,
        amount REAL NOT NULL,
        interest_rate REAL,
        monthly_payment REAL,
        remaining_months INTEGER,
        remaining_amount REAL,
        start_date TEXT,
        end_date TEXT,
        liability_type TEXT DEFAULT 'other'
      )
    ''');

    await db.execute('''
      CREATE TABLE cash_flows (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT,
        frequency TEXT DEFAULT 'once',
        start_date TEXT,
        end_date TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE asset_value_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        asset_id INTEGER NOT NULL,
        value REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE investment_returns (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        asset_id INTEGER NOT NULL,
        return_amount REAL NOT NULL,
        return_date TEXT NOT NULL,
        notes TEXT
      )
    ''');

    // 创建索引
    await db.execute('CREATE INDEX idx_assets_user ON assets(user_id)');
    await db.execute('CREATE INDEX idx_liabilities_user ON liabilities(user_id)');
    await db.execute('CREATE INDEX idx_cash_flows_user ON cash_flows(user_id)');
    await db.execute('CREATE INDEX idx_cash_flows_type ON cash_flows(user_id, type)');
    await db.execute('CREATE INDEX idx_asset_history_user ON asset_value_history(user_id)');
    await db.execute('CREATE INDEX idx_asset_history_asset ON asset_value_history(asset_id)');
    await db.execute('CREATE INDEX idx_investment_returns_user ON investment_returns(user_id)');
    await db.execute('CREATE INDEX idx_investment_returns_asset ON investment_returns(asset_id)');

    // 插入默认用户
    final now = DateTime.now().toIso8601String();
    await db.insert('users', {
      'user_id': AppConstants.defaultUserId,
      'username': '默认用户',
      'created_at': now,
      'updated_at': now,
    });

    // 插入默认资产类型
    for (final type in AppConstants.defaultAssetTypes) {
      await db.insert('asset_types', {
        'user_id': AppConstants.defaultUserId,
        'name': type['name'],
        'category': type['category'],
        'description': type['description'],
        'has_depreciation': type['has_depreciation'] ? 1 : 0,
        'depreciation_rate': type['depreciation_rate'],
      });
    }
  }

  // ============ 通用 CRUD ============

  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
  }) async {
    final db = await database;
    return db.query(table, where: where, whereArgs: whereArgs, orderBy: orderBy);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return db.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values,
    String where,
    List<Object?> whereArgs,
  ) async {
    final db = await database;
    return db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String where, List<Object?> whereArgs) async {
    final db = await database;
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<Object?>? arguments]) async {
    final db = await database;
    return db.rawQuery(sql, arguments);
  }

  // ============ 资产统计 ============

  Future<double> getTotalAssets() async {
    final results = await rawQuery(
      'SELECT COALESCE(SUM(current_value), 0) as total FROM assets WHERE user_id = ?',
      [AppConstants.defaultUserId],
    );
    return (results.first['total'] as num).toDouble();
  }

  Future<double> getTotalLiabilities() async {
    final results = await rawQuery(
      'SELECT COALESCE(SUM(remaining_amount), 0) as total FROM liabilities WHERE user_id = ?',
      [AppConstants.defaultUserId],
    );
    return (results.first['total'] as num).toDouble();
  }

  Future<Map<String, double>> getMonthlyCashFlow(int year, int month) async {
    final monthStr = '$year-${month.toString().padLeft(2, "0")}';
    final results = await rawQuery(
      '''SELECT type, COALESCE(SUM(ABS(amount)), 0) as total
         FROM cash_flows
         WHERE user_id = ? AND date LIKE ?
         GROUP BY type''',
      [AppConstants.defaultUserId, '$monthStr%'],
    );

    double income = 0;
    double expense = 0;
    for (final row in results) {
      if (row['type'] == 'income') {
        income = (row['total'] as num).toDouble();
      } else {
        expense = (row['total'] as num).toDouble();
      }
    }
    return {'income': income, 'expense': expense};
  }

  Future<List<Map<String, dynamic>>> getAssetDistribution() async {
    return rawQuery('''
      SELECT at.name as type_name, at.category, SUM(a.current_value) as total
      FROM assets a
      JOIN asset_types at ON a.asset_type_id = at.id
      WHERE a.user_id = ?
      GROUP BY a.asset_type_id
      ORDER BY total DESC
    ''', [AppConstants.defaultUserId]);
  }

  Future<List<Map<String, dynamic>>> getAssetReturns() async {
    return rawQuery('''
      SELECT a.id, a.name, a.current_value, a.purchase_value,
        CASE WHEN a.purchase_value > 0
          THEN (a.current_value - a.purchase_value) / a.purchase_value * 100
          ELSE 0 END as return_rate
      FROM assets a
      WHERE a.user_id = ? AND a.purchase_value IS NOT NULL AND a.purchase_value > 0
      ORDER BY return_rate DESC
    ''', [AppConstants.defaultUserId]);
  }

  Future<List<Map<String, dynamic>>> getMonthlyTrend(int months) async {
    return rawQuery('''
      SELECT strftime('%Y-%m', date) as month,
        SUM(CASE WHEN type = 'income' THEN ABS(amount) ELSE 0 END) as income,
        SUM(CASE WHEN type = 'expense' THEN ABS(amount) ELSE 0 END) as expense
      FROM cash_flows
      WHERE user_id = ? AND date IS NOT NULL
      GROUP BY month
      ORDER BY month DESC
      LIMIT ?
    ''', [AppConstants.defaultUserId, months]);
  }

  // ============ 删除资产时级联删除关联数据 ============

  Future<void> deleteAsset(int assetId) async {
    final uid = AppConstants.defaultUserId;
    await delete('asset_value_history', 'asset_id = ? AND user_id = ?', [assetId, uid]);
    await delete('investment_returns', 'asset_id = ? AND user_id = ?', [assetId, uid]);
    await delete('assets', 'id = ? AND user_id = ?', [assetId, uid]);
  }

  // ============ 数据导出 ============

  Future<Map<String, dynamic>> exportAllData() async {
    final uid = AppConstants.defaultUserId;
    return {
      'assets': await query('assets', where: 'user_id = ?', whereArgs: [uid]),
      'liabilities': await query('liabilities', where: 'user_id = ?', whereArgs: [uid]),
      'cash_flows': await query('cash_flows', where: 'user_id = ?', whereArgs: [uid]),
      'asset_types': await query('asset_types', where: 'user_id = ?', whereArgs: [uid]),
      'asset_value_history': await query('asset_value_history', where: 'user_id = ?', whereArgs: [uid]),
      'investment_returns': await query('investment_returns', where: 'user_id = ?', whereArgs: [uid]),
    };
  }
}
