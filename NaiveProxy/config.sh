domain="mc01"
naive_port="4433"

# 设置代理用户和密码
data=$(curl https://jsonplaceholder.typicode.com/todos)
ids=($(echo $data | jq -r '.[].id'))
titles=($(echo $data | jq -r '.[].title'))

cat > caddy_config.json <<EOF
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
EOF

# 循环添加代理用户和密码
# 遍历数组
for i in "${!ids[@]}"; do

if [[ $i -ne 0 ]]; then
cat >> caddy_config.json <<EOF
                    ,
EOF
fi

cat >> caddy_config.json <<EOF
                    {
                      "handle": [{"handler": "forward_proxy", "hide_ip": true, "hide_via": true,"probe_resistance": {},"auth_user_deprecated": "${domain}${ids[$i]}", "auth_pass_deprecated": "${titles[$i]}"}]
                    }
EOF
done

cat >> caddy_config.json <<EOF
                    ,{
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
