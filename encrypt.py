import mysql.connector
from werkzeug.security import generate_password_hash

# Database connection information now directly included in the script
dbuser = "root"
dbpass = "123456"
dbhost = "localhost"
dbname = "plantzzz"

# Connect to the database
try:
    connection = mysql.connector.connect(
        user=dbuser,
        password=dbpass,
        host=dbhost,
        database=dbname,
        autocommit=False
    )
    cursor = connection.cursor()

    # Query all users for their passwords
    cursor.execute("SELECT UserID, Password FROM Users")
    users = cursor.fetchall()

    # Generate a hash for each user's password and update the database
    for user_id, plain_password in users:
        hashed_password = generate_password_hash(plain_password)  # Uses default method 'pbkdf2:sha256'
        cursor.execute(
            "UPDATE Users SET Password = %s WHERE UserID = %s",
            (hashed_password, user_id)
        )

    # Commit the changes
    connection.commit()
    print("All passwords have been hashed successfully.")

except mysql.connector.Error as err:
    print(f"Error: {err}")
    if connection and connection.is_connected():
        connection.rollback()  # Roll back all changes in case of error
finally:
    if connection and connection.is_connected():
        cursor.close()
        connection.close()
