   naive_port=4433
   domain="bw01.hellotk.me"
    cat > /root/test.json << EOF
{
  "admin": {
    "disabled": true
  },
  "apps": {
    "http": {
      "servers": {
        "srv0": {
          "listen": [
            ":$naive_port"
          ],
          "routes": [
            {
              "handle": [
                {
                  "handler": "subroute",
                  "routes": [
                    {
                      "handle": [
                        {
                          "auth_user_deprecated": "${domain}01",
                          "auth_pass_deprecated": "Han.2001",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        }
                        ]
                    },
                    {
                      "handle": [
                         {
                          "auth_user_deprecated": "${domain}02",
                          "auth_pass_deprecated": "Han.2002",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [
                         {
                          "auth_user_deprecated": "${domain}03",
                          "auth_pass_deprecated": "Han.2003",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [
                         {
                          "auth_user_deprecated": "${domain}04",
                          "auth_pass_deprecated": "Han.2004",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [
                         {
                          "auth_user_deprecated": "${domain}05",
                          "auth_pass_deprecated": "Han.2005",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [ {
                          "auth_user_deprecated": "${domain}06",
                          "auth_pass_deprecated": "Han.2006",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [{
                          "auth_user_deprecated": "${domain}07",
                          "auth_pass_deprecated": "Han.2007",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [{
                          "auth_user_deprecated": "${domain}08",
                          "auth_pass_deprecated": "Han.2008",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [{
                          "auth_user_deprecated": "${domain}09",
                          "auth_pass_deprecated": "Han.2009",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        } ]
                    },
                    {
                      "handle": [
                        {
                          "auth_user_deprecated": "${domain}10",
                          "auth_pass_deprecated": "Han.2010",
                          "handler": "forward_proxy",
                          "hide_ip": true,
                          "hide_via": true,
                          "probe_resistance": {}
                        },
                      ]
                    },
                    {
                      "match": [
                        {
                          "host": [
                            "$domain.hellotk.me"
                          ]
                        }
                      ],
                      "handle": [
                        {
                          "handler": "file_server",
                          "root": "/var/www/html",
                          "index_names": [
                            "index.html"
                          ]
                        }
                      ],
                      "terminal": true
                    }
                  ]
                }
              ]
            }
          ],
          "tls_connection_policies": [
            {
              "match": {
                "sni": [
                  "$domain.hellotk.me"
                ]
              }
            }
          ],
          "automatic_https": {
            "disable": true
          }
        }
      }
    },
    "tls": {
      "certificates": {
        "load_files": [
          {
            "certificate": "/etc/letsencrypt/live/$domain.hellotk.me/fullchain.pem",
            "key": "/etc/letsencrypt/live/$domain.hellotk.me/privkey.pem"
          }
        ]
      }
    }
  }
}
EOF