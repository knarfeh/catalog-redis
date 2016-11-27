supervisord
sleep 3

echo "yes" | ruby /redis/src/redis-trib.rb create --replicas 1 $REDIS_TRIB_PARA

tail -f /var/log/supervisor/redis-1.log
