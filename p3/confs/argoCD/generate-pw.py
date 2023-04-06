import bcrypt
from dotenv import load_dotenv
from pathlib import Path
from os import getenv

load_dotenv(Path(__file__).parent / '.env')
# Generate a random password
password = getenv('ARGOCD_PASSWORD').encode('utf-8')

# Hash the password using bcrypt
hashed_password = bcrypt.hashpw(password, bcrypt.gensalt())
print("Bcrypt hashed password:", hashed_password.decode('utf-8'))