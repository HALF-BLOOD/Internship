from Connector import create_connection
import mysql.connector
from mysql.connector import Error

def fix_primary_key_auto_increment():
    connection = create_connection()
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)

            # Retrieve all table names in the database
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()

            for table in tables:
                table_name = list(table.values())[0]

                # Check primary key columns
                cursor.execute(f"""
                    SELECT COLUMN_NAME, EXTRA
                    FROM INFORMATION_SCHEMA.COLUMNS 
                    WHERE TABLE_SCHEMA = DATABASE() 
                    AND TABLE_NAME = '{table_name}' 
                    AND COLUMN_KEY = 'PRI';
                """)
                primary_keys = cursor.fetchall()

                # Skip if the primary key already has AUTO_INCREMENT or doesn't exist
                if len(primary_keys) == 1 and primary_keys[0]['EXTRA'] == 'auto_increment':
                    print(f"Table '{table_name}' already has a single AUTO_INCREMENT primary key.")
                    continue
                elif len(primary_keys) == 0:
                    print(f"Table '{table_name}' does not have a primary key to modify.")
                    continue

                # Temporarily disable foreign key checks
                cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")

                # Get foreign keys referencing this table
                cursor.execute(f"""
                    SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME
                    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                    WHERE REFERENCED_TABLE_SCHEMA = DATABASE()
                    AND REFERENCED_TABLE_NAME = '{table_name}';
                """)
                foreign_keys = cursor.fetchall()

                # Drop each foreign key constraint
                for fk in foreign_keys:
                    fk_table = fk['TABLE_NAME']
                    fk_constraint = fk['CONSTRAINT_NAME']
                    cursor.execute(f"ALTER TABLE `{fk_table}` DROP FOREIGN KEY `{fk_constraint}`;")
                    print(f"Dropped foreign key `{fk_constraint}` on `{fk_table}` referencing `{table_name}`.")

                # Drop existing primary key constraint if it exists
                cursor.execute(f"ALTER TABLE `{table_name}` DROP PRIMARY KEY;")

                # Modify primary key column to be AUTO_INCREMENT
                pk_column = primary_keys[0]['COLUMN_NAME']
                cursor.execute(f"""
                    ALTER TABLE `{table_name}` 
                    MODIFY COLUMN `{pk_column}` INT AUTO_INCREMENT PRIMARY KEY;
                """)
                print(f"Updated table '{table_name}': Column '{pk_column}' set to AUTO_INCREMENT.")

                # Re-add foreign key constraints
                for fk in foreign_keys:
                    fk_table = fk['TABLE_NAME']
                    fk_column = fk['COLUMN_NAME']
                    cursor.execute(f"""
                        ALTER TABLE `{fk_table}`
                        ADD CONSTRAINT `{fk['CONSTRAINT_NAME']}`
                        FOREIGN KEY (`{fk_column}`) REFERENCES `{table_name}`(`{pk_column}`);
                    """)
                    print(f"Re-added foreign key `{fk['CONSTRAINT_NAME']}` on `{fk_table}` referencing `{table_name}`.")

                # Re-enable foreign key checks
                cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")

            connection.commit()
            print("Primary key adjustments applied successfully.")

        except Error as e:
            print(f"Error: {e}")
            connection.rollback()
        finally:
            cursor.close()
            connection.close()

# Run the function to fix primary key auto-increment issues
fix_primary_key_auto_increment()
