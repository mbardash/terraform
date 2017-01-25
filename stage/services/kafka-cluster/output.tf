#Output

output "kafka_user"         { value = "${module.kafka.user}" }
output "kafka_private_ip"   { value = "${module.kafka.private_ip}" }
output "kafka_public_ip"    { value = "${module.kafka.public_ip}" }
output "kafka_public_dns"   { value = "${module.kafka.public_dns}" }
