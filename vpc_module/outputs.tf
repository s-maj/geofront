output "id" {
  value = "${(aws_vpc.vpc.id)}"
}

output "subnet_list" {
  value = ["${aws_subnet.public.*.id}"]
}
