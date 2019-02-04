import os

# adopted from: https://github.com/apache/incubator-superset/blob/master/contrib/docker/superset_config.py

def get_env_variable(var_name, default=None):
    try:
        return os.environ[var_name]
    except KeyError:
        if default is not None:
            return default
        else:
            raise EnvironmentError('Please provide key: %s' % (var_name))

def construct_connection_string(driver, user, password, host, port, db_name):
    if driver == 'pg':
        return 'postgresql://%s:%s@%s:%s/%s' % (user, password, host, port, db_name)
    elif driver == 'sqlite':
        return 'sqlite:///{superset_home}/superset.db'.format(superset_home=os.environ.get('SUPERSET_HOME'))

    raise ValueError('Unrecognized driver, got: {}' % driver)

# Metadata database's configuration
DB_DRIVER = get_env_variable('DB_DRIVER', 'sqlite')
DB_USER = get_env_variable('DB_USER')
DB_PASSWORD = get_env_variable('DB_PASSWORD')
DB_HOST = get_env_variable('DB_HOST')
DB_PORT = get_env_variable('DB_PORT')
DB_NAME = get_env_variable('DB_NAME')
SQLALCHEMY_DATABASE_URI = construct_connection_string(DB_DRIVER, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME)

# Celery tasks configuration
CACHE_HOST = get_env_variable('CACHE_HOST')
CACHE_PORT = get_env_variable('CACHE_PORT')

class CeleryConfig(object):
    BROKER_URL = 'redis://%s:%s/0' % (CACHE_HOST, CACHE_PORT)
    CELERY_IMPORTS = ('superset.sql_lab')
    CELERY_RESULT_BACKEND = 'redis://%s:%s/1' % (CACHE_HOST, CACHE_PORT)
    CELERY_TASK_PROTOCOL = 1

CELERY_CONFIG = CeleryConfig
