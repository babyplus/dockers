import yaml

def get(date):
    y = []
    for day in date:
        try:
            with open('/tmp/test_{}.txt'.format(day), 'r') as f:
                y.extend(yaml.load(f.read(), Loader=yaml.BaseLoader))
        except FileNotFoundError:
            pass
    return y
