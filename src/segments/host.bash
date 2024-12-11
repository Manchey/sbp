#! /usr/bin/env bash

user_id="$(id -u)"

segments::host() {
  # 检测是否在Docker环境中
  if [ -f /.dockerenv ] || grep -q 'docker\|lxc' /proc/1/cgroup 2>/dev/null; then
    docker_icon="🐳 "  # Docker whale emoji
  else
    docker_icon=""
  fi

  if [[ -n $SSH_CLIENT ]]; then
    host_value="${USER}@${HOSTNAME}"
  else
    host_value="$USER"
  fi

  host_value="${docker_icon}${host_value}"

  if [[ $user_id -eq 0 ]]; then
    print_themed_segment 'highlight' "$host_value"
  else
    print_themed_segment 'normal' "$host_value"
  fi

}
