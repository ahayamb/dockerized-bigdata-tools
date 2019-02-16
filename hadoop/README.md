# How to Run
1. Execute `docker-compose up --build -d --scale worker=<number of workers>`
1. Setup passwordless ssh & worker registration to the master node by executing `python inject_keys.py`
1. Execute `docker-compose exec master ./entrypoint master`

# Notes
1. Add container to ip resolving statement to `/etc/hosts`
