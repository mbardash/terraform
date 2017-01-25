output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}
output "elb_instances" {
  value = "${aws_elb.example.instances}"
}
