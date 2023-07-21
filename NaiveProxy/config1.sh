# 设置变量
domain="example"
naive_port="3080"
proxy_handler="forward_proxy"

# 构建 JSON 配置对象
config=$(cat <<EOF
{
  "admin": {
    "disabled": true
  },
  "apps": {
    "http": {
      "servers": {
        "srv0": {
          "listen": [":$naive_port"],
          "routes": [
            # 创建 10 个代理路由
            $(for i in {1..10}; do
              cat <<ROUTE
              {
                "handle": [{
                  "auth_user_deprecated": "${domain}$(printf '%02d' $i)",
                  "auth_pass_deprecated": "Han.20$(printf '%02d' $i)",
                  "handler": "$proxy_handler",
                  "hide_ip": true,
                  "hide_via": true,
                  "probe_resistance": {}
                }]
              },
              ROUTE
            done
            )
            # 添加文件服务器路由
            {
              "match": [{"host": ["$domain.hellotk.me"]}],
              "handle": [{
                "handler": "file_server",
                "root": "/var/www/html",
                "index_names": ["index.html"]
              }],
              "terminal": true
            }
          ],
          "tls_connection_policies": [{
            "match": {"sni": ["$domain.hellotk.me"]}
          }],
          "automatic_https": {"disable": true}
        }
      }
    },
    "tls": {
      "certificates": {
        "load_files": [{
          "certificate": "/etc/letsencrypt/live/$domain.hellotk.me/fullchain.pem",
          "key": "/etc/letsencrypt/live/$domain.hellotk.me/privkey.pem"
        }]
      }
    }
  }
}
EOF
)

# 将配置对象写入文件
echo "$config" > /etc/caddy/caddy_config.json