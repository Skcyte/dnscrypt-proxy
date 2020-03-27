MODDIR=${0%/*}
CONFIG_FILE=/data/media/0/dnscrypt-proxy/dnscrypt-proxy.toml
LOG_FILE=/data/media/0/dnscrypt-proxy/dnscrypt-proxy.log
L_CONFIG_FILE=/data/media/0/dnscrypt-proxy/dnscrypt-proxy.conf

if [ -s $L_CONFIG_FILE ]; then
  . $L_CONFIG_FILE
fi

# dnscrypt-proxy service.sh
$MODDIR/system/bin/dnscrypt-proxy -config $CONFIG_FILE -logfile $LOG_FILE > /dev/null 2>&1 &

if [ "$AUTO_REDIRECTION" = "true" ]; then
  iptables -t nat -A OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  iptables -t nat -A OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  ip6tables -t nat -A OUTPUT -p tcp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination [::1]:5354
  ip6tables -t nat -A OUTPUT -p udp ! -d 1.1.1.1 --dport 53 -j DNAT --to-destination [::1]:5354
fi