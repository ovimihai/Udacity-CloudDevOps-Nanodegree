resource "null_resource" "extract_site" {
  provisioner "local-exec" {
    command = "mkdir site & unzip udacity-starter-website.zip -d site"
  }
  provisioner "local-exec" {
    when = destroy
    command = "rm -fr site"
  }
}

//https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "create_bucket" {
  bucket = var.pj_bucket
  acl = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }

  lifecycle {
    prevent_destroy = false
  }

  depends_on = [null_resource.extract_site]

}

// very slow
//resource "aws_s3_bucket_object" "test" {
//  for_each = fileset("site", "**/*")
//
//  bucket = var.pj_bucket
//  key    = each.value
//  source = "site/${each.value}"
//}

locals{
  env = {
      AWS_ACCESS_KEY_ID = var.aws_access_key
      AWS_SECRET_ACCESS_KEY = var.aws_secret_key
      AWS_SESSION_TOKEN = var.aws_session_token
      AWS_DEFAULT_REGION = var.aws_region
      PJ_BUCKET = var.pj_bucket
    }
}

resource "null_resource" "upload_to_s3" {

  provisioner "local-exec" {
    environment = local.env
    command = "aws s3 sync site s3://${local.env.PJ_BUCKET}"
  }

  provisioner "local-exec" {
    when = destroy
    # @todo - make it work with variables
    command = "aws s3 rm --recursive s3://my-209409592105-bucket"
  }

  depends_on = [aws_s3_bucket.create_bucket]
}

# https://www.alexhyett.com/terraform-s3-static-website-hosting

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.create_bucket.bucket_regional_domain_name
    origin_id = "S3-${aws_s3_bucket.create_bucket.bucket}"

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled = true
  is_ipv6_enabled = true
  comment = "Ovidiu's Travel Blog"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["GET","HEAD"]
    cached_methods = ["GET","HEAD"]

    target_origin_id = "S3-${aws_s3_bucket.create_bucket.bucket}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  depends_on = [null_resource.upload_to_s3]
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

