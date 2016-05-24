import glob

def process_name():
    return 'consul-agent'

def should_load():
    return len(glob.glob('/etc/consul/*'))
