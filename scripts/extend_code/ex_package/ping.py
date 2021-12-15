import yaml
import time
import os

def get(date):
    y = []
    for day in date:
        try:
            with open('/tmp/test_{}.txt'.format(day), 'r') as f:
                y.extend(yaml.load(f.read(), Loader=yaml.BaseLoader))
        except FileNotFoundError:
            pass
    return y

def latest_get():
    y = []
    try:
        with open('/tmp/test_latest.txt', 'r') as f:
            y.extend(yaml.load(f.read(), Loader=yaml.BaseLoader))
    except FileNotFoundError:
        pass
    return y[-1]["results"]

def statistic_get(begin, end):
    val = os.popen("sh /usr/src/app/openapi_server/ex_package/statistics.sh \"{}|{}\" ".format(begin, end))
    try:
        y = yaml.load(val.read(), Loader=yaml.BaseLoader)
    except:
        pass
    return y
