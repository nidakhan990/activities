output "profile-0ut" {
  description = "ID of project VPC"
  value       = "${aws_iam_instance_profile.test_profile.name}"
}
