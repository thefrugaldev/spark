import Foundation
import SQLite3

struct SparkSQLite {
    static func openDatabase() -> OpaquePointer? {
        let dbURL = try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("spark.sqlite")
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(dbURL.path, &db) == SQLITE_OK {
            return db
        } else {
            print("Unable to open database.")
        }
        
        return db
    }
}
