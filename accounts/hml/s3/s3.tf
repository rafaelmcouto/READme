module "firstBucket" {
    source = "../../modules/s3"

    name = "testing-terraform-bucket-test"
    environment = "test"
    layer = "layer Name"
    project = "my-terraform-project"
    service = "EC2"

}