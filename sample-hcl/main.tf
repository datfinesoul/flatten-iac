resource "random_string" "this" {
  for_each = toset(["1", "2", "3"])
  special  = false
  upper    = false
  length   = 4
}
