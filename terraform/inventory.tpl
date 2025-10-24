[controller]
${controller_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}

[manager]
${manager_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path} private_ip=${manager_private_ip}

[workers]
${worker_a_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}
${worker_b_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
