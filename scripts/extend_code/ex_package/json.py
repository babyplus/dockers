import yaml

def get(query):
    with open('/tmp/yaml/{}.yml'.format(query[0]), 'r') as f:
        y = yaml.load(f.read(), Loader=yaml.BaseLoader)
    return y
