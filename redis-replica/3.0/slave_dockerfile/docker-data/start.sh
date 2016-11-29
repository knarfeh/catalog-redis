echo "slaveof" $REDIS_SLAVE_OF >> ./redis-conf/7000/redis.conf

supervisord
sleep 3

tail -f /var/log/supervisor/redis-1.log
