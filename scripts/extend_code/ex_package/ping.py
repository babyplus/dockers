import yaml

def get(status):
    with open('/tmp/test.txt', 'r') as f:
        y = yaml.load(f.read(), Loader=yaml.BaseLoader)
    return y
