variable "GO_VERSION" {
  default = "1.23"
}

target "_common" {
  args = {
    GO_VERSION = GO_VERSION
  }
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {}


group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["_common", "docker-metadata-action"]
    output = ["type=image"]
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-cross" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
