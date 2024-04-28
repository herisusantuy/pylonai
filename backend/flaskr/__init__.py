import os
import urllib
from flask import Flask
from sqlalchemy import create_engine, text

server = 'pylonsample.database.windows.net'
database = 'PylonProductionData_ForTesting'
username = 'TestUser3'
password = 'T3stUs3r123!'
driver = '{ODBC Driver 17 for SQL Server}'


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    # conn = f"""Driver={driver};Server=tcp:{server},1433;Database={database};
    # Uid={username};Pwd={password};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"""
    #
    # params = urllib.parse.quote_plus(conn)
    # conn_str = 'mssql+pyodbc:///?autocommit=true&odbc_connect={}'.format(params)
    # engine = create_engine(conn_str, echo=True)
    # connection = engine.connect()
    # result = connection.execute("select 1+1 as res")
    # for row in result:
    #     print("res:", row['res'])
    # connection.close()
    from . import db
    db.init_app(app)

    return app
