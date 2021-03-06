# dnscrypt-proxy for Android

![Build](https://github.com/adit/dnscrypt-proxy/workflows/build/badge.svg) [![DNSCrypt-Proxy Android Magisk Release](https://img.shields.io/github/release/adit/dnscrypt-proxy.svg?label=latest%20release&style=popout)](https://github.com/adit/dnscrypt-proxy/releases/latest)

A flexible DNS proxy, with support for modern encrypted DNS protocols such as [DNSCrypt v2](https://github.com/DNSCrypt/dnscrypt-protocol/blob/master/DNSCRYPT-V2-PROTOCOL.txt) and [DNS-over-HTTP/2](https://tools.ietf.org/html/draft-ietf-doh-dns-over-https-03).

## Features
- arm, arm64, x86 and x86_64 are supported.
- ipv4 and ipv6 are supported.
- All binary files are downloaded from [https://github.com/DNSCrypt/dnscrypt-proxy/releases](https://github.com/DNSCrypt/dnscrypt-proxy/releases)


## Installation
- Download the module, and flash it in Magisk Manager App or in Recovery.

## Usage
- open terminal then type: 
```
su
dcp {start|stop|restart|enable|disable|log}
```

- `start | stop | restart` : manage the dnscrypt-proxy service.
- `enable | disable` : enable/disable automatically dns redirection at startup.
- `log` : view logging information.

### Set DNS server manually with 3rd-party app (not included in this module)
- DNS server address is 127.0.0.1:5354 for ipv4 and [::1]:5354 for ipv6
- If you use AfWall, you can write this enter custom script
  ```
  iptables -t nat -A OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  iptables -t nat -A OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  ip6tables -t nat -A OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:5354
  ip6tables -t nat -A OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:5354
   ```
  and this shutdown script
  ```
  iptables -t nat -D OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  iptables -t nat -D OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination 127.0.0.1:5354
  ip6tables -t nat -D OUTPUT -p tcp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:5354
  ip6tables -t nat -D OUTPUT -p udp ! -d 9.9.9.9 --dport 53 -j DNAT --to-destination [::1]:5354
    ```

## Configuration (post-installing)
- Configuration located on `/sdcard/dnscrypt-proxy/dnscrypt-proxy.toml` [or /data/media/0/dnscrypt-proxy/dnscrypt-proxy.toml]
- For more detailed configuration please refer to [official documentation](https://github.com/DNSCrypt/dnscrypt-proxy/wiki/Configuration)

## Credits
- DNSCrypt-Proxy2 upstream | [DNSCrypt](https://github.com/DNSCrypt/dnscrypt-proxy)
- [bluemeda](https://github.com/bluemeda) for the original module
- [All contributor](https://github.com/adit/dnscrypt-proxy/graphs/contributors)
