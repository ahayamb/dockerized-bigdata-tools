import os

def get_pub(container_id):
    return os.popen("docker exec {} cat /root/.ssh/id_rsa.pub".format(container_id)).read().strip()

def get_authorized_keys(container_id):
    return os.popen("docker exec {} cat /root/.ssh/authorized_keys".format(container_id)).read().strip()

containers = os.popen("docker-compose images | awk '{print $1}' | tail -n +3").read().strip().split('\n')
id_pubs = dict([(c, get_pub(c)) for c in containers])
authorizeds = dict([(c, get_authorized_keys(c)) for c in containers ])

total_authorized = '\n'.join([t.strip() for t in set(authorizeds.values())]) + "\n"

_ = os.popen("rm -rf authorized_keys").read()

open('authorized_keys', 'w').write(total_authorized)
_ = os.popen("chmod 400 authorized_keys").read()

for c in containers:
    _ = os.popen("docker cp authorized_keys {}:/root/.ssh/".format(c)).read()
    os.popen('docker exec {} bash -c "chown root:root /root/.ssh/authorized_keys"'.format(c)).read()

_ = os.popen("rm -rf authorized_keys").read()
