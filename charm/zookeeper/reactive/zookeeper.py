from charms.reactive import when, when_not, set_flag

def install_snap():
    snap_file = get_snap_file_from_charm()
    if not snap_file:
        snap_file = hookenv.resource_get('zk')
    if not snap_file:
        hookenv.status_set('blocked', 'missing zookeeper snap')
        return
    # Need to install the core snap explicit. If not, there's
    # no slots for removable-media on a bionic install.
    # Not sure if that's a snapd bug or intended behavior.
    check_call(['snap', 'install', 'core'])
    check_call(['snap', 'install', '--dangerous', snap_file])
    set_state('zookeeper.available')

def restart_zk():
    check_call(['snap', 'restart', 'zk'])

@when_not('zookeeper.installed')
def install_zookeeper():
    install_snap()
    set_flag('zookeeper.installed')

@when(
    'zookeeper.installed',
    'upgrade-charm'
)
def add_config():
    # TODO: Set up configs here
    restart_zk()