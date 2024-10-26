import mysql.connector
from mysql.connector import Error

def load_sql_file(file_path):
    """Read the content of the SQL file."""
    with open(file_path, 'r') as file:
        return file.read()

def run_sql_script(host, user, password, sql_file):
    connection = None
    try:
        # Establish a connection to MySQL
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            charset='utf8mb4',
            collation='utf8mb4_general_ci'
        )

        if connection.is_connected():
            print("Connected to MySQL Server")

            # Create a cursor to execute SQL commands
            cursor = connection.cursor()

            # Load and execute SQL script
            sql_script = load_sql_file(sql_file)
            for statement in sql_script.split(';'):
                if statement.strip():
                    cursor.execute(statement)
                    print(f"Executed: {statement.strip()}")

            # Commit changes
            connection.commit()
            print("Database setup completed successfully.")

    except Error as e:
        print(f"Error: {e}")
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("MySQL connection closed.")

# Replace with your MySQL credentials
host = "localhost"
user = "root"  # Adjust if you have a different user
password = "dbuserdbuser"  # Replace with your MySQL password

# Specify the path to your SQL file
users = 'create_users.sql'
orders = 'create_users.sql'
products = 'create_products.sql'

run_sql_script(host, user, password, users)
run_sql_script(host, user, password, orders)
run_sql_script(host, user, password, products)
