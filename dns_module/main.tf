
data "aws_route53_zone" "zone" {
  name         = "${var.dns_zone}."
  private_zone = "${var.is_dns_zone_private}"
}

resource "aws_route53_record" "record" {
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${var.elb_dns_name}"
  type    = "A"

  alias {
    name                   = "${aws_alb.main.dns_name}"
    zone_id                = "${aws_alb.main.zone_id}"
    evaluate_target_health = true
  }
}
