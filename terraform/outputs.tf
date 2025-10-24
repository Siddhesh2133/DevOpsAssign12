output "controller_public_ip" {
  description = "Public IP of Controller node"
  value       = aws_instance.controller.public_ip
}

output "manager_public_ip" {
  description = "Public IP of Swarm Manager (EIP)"
  value       = aws_eip.manager_eip.public_ip
}

output "manager_private_ip" {
  description = "Private IP of Swarm Manager"
  value       = aws_instance.swarm_manager.private_ip
}

output "worker_a_public_ip" {
  description = "Public IP of Worker A (EIP)"
  value       = aws_eip.worker_a_eip.public_ip
}

output "worker_b_public_ip" {
  description = "Public IP of Worker B (EIP)"
  value       = aws_eip.worker_b_eip.public_ip
}

output "ssh_private_key_path" {
  description = "Path to SSH private key"
  value       = local_file.private_key.filename
}

output "ansible_inventory_path" {
  description = "Path to generated Ansible inventory"
  value       = local_file.ansible_inventory.filename
}

output "jenkins_url" {
  description = "Jenkins URL"
  value       = "http://${aws_instance.controller.public_ip}:8080"
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_eip.manager_eip.public_ip}"
}

output "ssh_commands" {
  description = "SSH commands to connect to nodes"
  value = {
    controller = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_instance.controller.public_ip}"
    manager    = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_eip.manager_eip.public_ip}"
    worker_a   = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_eip.worker_a_eip.public_ip}"
    worker_b   = "ssh -i ${local_file.private_key.filename} ubuntu@${aws_eip.worker_b_eip.public_ip}"
  }
}
