import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static bool _factoryInitialized = false;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (!_factoryInitialized && kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      _factoryInitialized = true;
    }

    if (kIsWeb) {
      return await databaseFactory.openDatabase(
        'jucai.db',
        options: OpenDatabaseOptions(
          version: 3,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        ),
      );
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'jucai.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
    await _seedDefaultData(db);
    await _seedSampleData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // v1 -> v2: no schema changes, just add sample data if tables are empty
      final assets = await db.query('assets', where: 'user_id = ?', whereArgs: [AppConstants.defaultUserId]);
      if (assets.isEmpty) {
        await _seedSampleData(db);
      }
    }
    if (oldVersion < 3) {
      // v2 -> v3: add new asset types (外汇、数字货币、保险、养老金、收藏品、商业地产、定期存款、股权投资)
      final existingNames = (await db.query('asset_types', columns: ['name'], where: 'user_id = ?',
          whereArgs: [AppConstants.defaultUserId])).map((r) => r['name'] as String).toSet();

      final newTypes = AppConstants.defaultAssetTypes.where((t) => !existingNames.contains(t['name'])).toList();
      for (final type in newTypes) {
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
  }

  Future<void> _createTables(Database db) async {
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
  }

  Future<void> _seedDefaultData(Database db) async {
    final uid = AppConstants.defaultUserId;

    // 插入默认用户
    final now = DateTime.now().toIso8601String();
    await db.insert('users', {
      'user_id': uid,
      'username': '默认用户',
      'created_at': now,
      'updated_at': now,
    });

    // 插入默认资产类型
    for (final type in AppConstants.defaultAssetTypes) {
      await db.insert('asset_types', {
        'user_id': uid,
        'name': type['name'],
        'category': type['category'],
        'description': type['description'],
        'has_depreciation': type['has_depreciation'] ? 1 : 0,
        'depreciation_rate': type['depreciation_rate'],
      });
    }
  }

  Future<void> _seedSampleData(Database db) async {
    final uid = AppConstants.defaultUserId;
    final now = DateTime.now();

    // 插入示例资产 (asset_type_id 1-18 对应 defaultAssetTypes 顺序)
    // 1:现金, 2:定期存款, 3:股票, 4:基金, 5:债券, 6:外汇, 7:数字货币,
    // 8:贵金属, 9:保险, 10:股权投资, 11:房产, 12:商业地产, 13:养老金,
    // 14:汽车, 15:电子产品, 16:家具, 17:收藏品, 18:其他
    final sampleAssets = [
      {'name': '自住房产', 'asset_type_id': 11, 'current_value': 2500000.0, 'purchase_value': 2000000.0, 'purchase_date': _yearsAgo(now, 5), 'description': '市区三居室'},
      {'name': '股票投资', 'asset_type_id': 3, 'current_value': 380000.0, 'purchase_value': 300000.0, 'purchase_date': _yearsAgo(now, 2), 'description': 'A股组合'},
      {'name': '基金定投', 'asset_type_id': 4, 'current_value': 150000.0, 'purchase_value': 120000.0, 'purchase_date': _yearsAgo(now, 3), 'description': '指数基金定投'},
      {'name': '活期存款', 'asset_type_id': 1, 'current_value': 85000.0, 'purchase_value': null, 'purchase_date': null, 'description': '银行活期'},
      {'name': '比特币', 'asset_type_id': 7, 'current_value': 260000.0, 'purchase_value': 180000.0, 'purchase_date': _yearsAgo(now, 1), 'description': 'BTC长期持有'},
      {'name': '代步车', 'asset_type_id': 14, 'current_value': 120000.0, 'purchase_value': 180000.0, 'purchase_date': _yearsAgo(now, 2), 'description': '家用轿车'},
    ];

    for (final a in sampleAssets) {
      await db.insert('assets', {
        'user_id': uid,
        'asset_type_id': a['asset_type_id'],
        'name': a['name'],
        'current_value': a['current_value'],
        'purchase_value': a['purchase_value'],
        'purchase_date': a['purchase_date'],
        'description': a['description'],
      });
    }

    // 插入示例负债
    final sampleLiabilities = [
      {
        'name': '房贷',
        'amount': 1800000.0,
        'interest_rate': 3.8,
        'monthly_payment': 8400.0,
        'remaining_months': 216,
        'remaining_amount': 1500000.0,
        'start_date': _yearsAgo(now, 5),
        'end_date': _yearsFromNow(now, 13),
        'liability_type': 'mortgage',
      },
      {
        'name': '车贷',
        'amount': 80000.0,
        'interest_rate': 4.5,
        'monthly_payment': 3500.0,
        'remaining_months': 15,
        'remaining_amount': 45000.0,
        'start_date': _yearsAgo(now, 2),
        'end_date': _yearsFromNow(now, 1),
        'liability_type': 'car_loan',
      },
    ];

    for (final l in sampleLiabilities) {
      await db.insert('liabilities', {
        'user_id': uid,
        ...l,
      });
    }

    // 插入示例现金流 (近3个月)
    for (int m = 0; m < 3; m++) {
      final monthDate = DateTime(now.year, now.month - m, 1);
      final monthStr = _fmt(monthDate);

      // 月度工资收入
      await db.insert('cash_flows', {
        'user_id': uid, 'type': 'income', 'category': 'salary',
        'amount': 15000.0, 'description': '月工资',
        'frequency': 'monthly',
        'start_date': _fmt(DateTime(now.year, now.month - 5, 1)),
        'end_date': _fmt(DateTime(now.year, now.month + 6, 1)),
        'date': monthStr,
      });

      // 月度住房支出
      await db.insert('cash_flows', {
        'user_id': uid, 'type': 'expense', 'category': 'housing',
        'amount': 4000.0, 'description': '房租',
        'frequency': 'monthly',
        'start_date': _fmt(DateTime(now.year, now.month - 5, 1)),
        'end_date': _fmt(DateTime(now.year, now.month + 6, 1)),
        'date': monthStr,
      });

      // 餐饮
      await db.insert('cash_flows', {
        'user_id': uid, 'type': 'expense', 'category': 'food',
        'amount': 2500.0, 'description': '日常餐饮',
        'frequency': 'monthly',
        'start_date': _fmt(DateTime(now.year, now.month - 5, 1)),
        'end_date': _fmt(DateTime(now.year, now.month + 6, 1)),
        'date': monthStr,
      });

      // 交通
      await db.insert('cash_flows', {
        'user_id': uid, 'type': 'expense', 'category': 'transport',
        'amount': 800.0, 'description': '通勤交通',
        'frequency': 'monthly',
        'start_date': _fmt(DateTime(now.year, now.month - 5, 1)),
        'end_date': _fmt(DateTime(now.year, now.month + 6, 1)),
        'date': monthStr,
      });
    }

    // 一次性：奖金
    await db.insert('cash_flows', {
      'user_id': uid, 'type': 'income', 'category': 'bonus',
      'amount': 30000.0, 'description': '年终奖金',
      'frequency': 'once',
      'start_date': null, 'end_date': null,
      'date': _fmt(DateTime(now.year, now.month - 1, 15)),
    });

    // 一次性：购物
    await db.insert('cash_flows', {
      'user_id': uid, 'type': 'expense', 'category': 'shopping',
      'amount': 3500.0, 'description': '电子产品',
      'frequency': 'once',
      'start_date': null, 'end_date': null,
      'date': _fmt(DateTime(now.year, now.month - 1, now.day - 14 < 1 ? 1 : now.day - 14)),
    });
  }

  String _fmt(DateTime d) => d.toIso8601String().split('T').first;
  String _yearsAgo(DateTime now, int years) => DateTime(now.year - years, now.month, now.day).toIso8601String().split('T').first;
  String _yearsFromNow(DateTime now, int years) => DateTime(now.year + years, now.month, now.day).toIso8601String().split('T').first;

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
