# repeated ping  

## deployment  

### modify hosts file  

Modify the master group as appropriate to connect to the hosts via SSH.  

* file:    etc/ansible/hosts  

### set the peers  

* file:    etc/ansible/yml/common_ping.config  
* value:   peers  

### set the path of result  

* file:    etc/ansible/yml/common_ping.config  
* value:   result_file_path  
* default: /tmp  

### set the interval  

* file:    etc/ansible/yml/common_ping.config  
* value:   ping_interval  
* default: 30  

## scripts  

### startup   

```
cd scripts  
bash repeated_ping.sh  
```

#### running even if the terminal is closed 

```
cd scripts  
nohup bash repeated_ping.sh &>/dev/null &  
```

# repeated ping via publish via redis 

## deployment  

### modify hosts file  

Modify the master group as appropriate to connect to the hosts via SSH.  

* file:    etc/ansible/hosts  

### set the peers  

* file:    etc/ansible/yml/common_ping.config  
* value:   peers  

### set the path of result  

* file:    etc/ansible/yml/common_ping.config  
* value:   result_file_path  
* default: /tmp  

### set the interval  

* file:    etc/ansible/yml/common_ping.config  
* value:   ping_interval  
* default: 30  

### set the redis channel  

* file:    etc/ansible/yml/redis_ping.config
* value:   channel
* default: online

## scripts  

### startup   

```
cd scripts  
bash repeated_ping_and_publish_via_redis.sh  
```

#### running even if the terminal is closed 

```
cd scripts  
nohup bash repeated_ping_and_publish_via_redis.sh &>/dev/null &  
```
