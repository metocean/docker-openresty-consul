import os
import importlib
import shutil
from glob import glob
import logging
from time import sleep
import xmlrpclib

start_rules_dir = '/etc/supervisor/start-rules/'


def is_process_running(supervisor, process_name):
    '''
    returns true if the supervisor process is running
    '''
    try:
        info = supervisor.getProcessInfo(process_name)
        return info and 'statename' in info and 'RUNNING' in info['statename']
    except xmlrpclib.Fault:
        return False
    except Exception, e:
        return False


def _check_rule_module(server, process_name):
    '''
    :param name:
    :return: True if supervisord needs to be updated.
    '''
    try:
        mod = importlib.import_module(name)
        process_name = getattr(mod, "process_name")()
        should_load = getattr(mod, "should_load")()

        if should_load and not is_process_running(server, process_name):
            supervisor.startProcess(process_name)

        if not should_load and is_process_running(server, process_name):
            supervisor.stopProcess(config_name)

    except KeyboardInterrupt:
        raise
    except:
        logging.exception('module {0} failed to be loaded'.format(name))


def main():
    try:
        server = xmlrpclib.Server('http://localhost:9001/RPC2')
        while True:
            for rule_module in sorted(glob(os.path.join(start_rules_dir, '*rule.py'))):
                _check_rule_module(server.supervisor, os.path.basename(rule_module).replace('.py', ''))
            sleep(1)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
