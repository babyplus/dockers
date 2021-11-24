import yaml
import time

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
