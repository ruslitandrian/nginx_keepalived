# 监控nginx进程，若nginx主进程不存在则启动nginx
# 若5s后nginx进程还是不存在的话kill掉keepalived进程,防止nginx没运行该主机的keepalived还接管虚拟IP
# chmod +x nginx.sh
#!/bin/bash
status=$(ss -lnp | grep -c 'nginx')
if [ ${status} == 0 ]; then
    systemctl nginx restart
    sleep 2
    status=$(ss -lnp | grep -c 'nginx')
    if [ ${status} == 0 ]; then
        systemctl stop keepalived
    fi
fi