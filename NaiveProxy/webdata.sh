#!/bin/bash

# 使用 curl 获取数据
data=$(curl https://jsonplaceholder.typicode.com/todos)

# 将数据格式化为数组
ids=($(echo $data | jq -r '.[].id'))
titles=($(echo $data | jq -r '.[].title'))
completed=($(echo $data | jq -r '.[].completed'))

# 遍历数组
for i in "${!ids[@]}"; do
    echo "ID: ${ids[i]}, Title: ${titles[i]}, Completed: ${completed[i]}"
done