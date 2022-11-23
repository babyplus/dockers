# redis

## redis密码

```
[root@10 dockers]# grep redis-server docker-compose.yml 
    command: redis-server --requirepass "F31Vl%SE"

```

# ansible

## ssh登录

```
[root@10 dockers]# grep 172.19.0.1 ansible_ping_test/etc/ansible/hosts 
172.19.0.1       ansible_ssh_private_key_file=/etc/ansible/keys/my_ubuntu_key1 ansible_ssh_user=root ansible_ssh_common_args="-o StrictHostKeyChecking=no "

```

## redis密码

```
[root@10 dockers]# cat ansible_ping_test/etc/ansible/yml/redis_ping.config 
---
    channel: "CHANNEL_ONLINE"
    redis_password: "F31Vl%SE"

```

## 准备redis客户端容器

## 增加redis密码认证

```
[root@10 dockers]# grep redis_password ansible_ping_test/etc/ansible/yml/ping_and_publish_via_redis.yml
  - shell: "sudo docker run -it --network host --rm redis redis-cli -a {{ redis_password }} PUBLISH {{ channel }} {{ item.host }}"

```

## 其他配置文件

* ansible_ping_test/etc/ansible/yml/common_ping.config
* ansible_ping_test/etc/ansible/yml/redis_ping.config

