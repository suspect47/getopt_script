!/bin/bash
echo "This is a test"
function add_rules {
iptables -F
iptables -P INPUT ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 9000 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 5000:6000 -j ACCEPT
iptables -A INPUT -p tcp --dport 6500 -j ACCEPT
iptables -A INPUT -p tcp --dport 6556 -j ACCEPT
iptables -A INPUT -p tcp --dport 3702 -j ACCEPT
iptables -A INPUT -p tcp --dport 7800 -j ACCEPT
iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
iptables -A INPUT -p tcp --dport 123 -j ACCEPT
iptables -A INPUT -p tcp --dport 23 -j ACCEPT
iptables -A INPUT -p tcp --dport 554 -j ACCEPT
iptables -A INPUT -p udp -j ACCEPT
iptables -P INPUT DROP
}
ARGS=$(getopt -o f --long firewall -- "$@")
if [ $? != 0 ] ; then
  echo "Terminating..." >&2;
  exit 1;
fi
eval set -- "$ARGS"
while true; do
  case "$1" in
  -f | --firewall ) add_rules; echo "Rules added!"; shift ;;
  -- ) shift; break ;;
  * ) echo "Error"; break ;;
  esac
done
echo "Test is complete"
exit 0
