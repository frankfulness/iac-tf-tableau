# Provider configuration
terraform {
  required_providers {
    tableau = {
      source  = "GtheSheep/tableau"
      version = "0.0.23"
    }
  }
}

provider "tableau" {
  server_url     = var.server_url
  server_version = "3.19"
  username       = var.username
  password       = var.password
  site          = var.site_name
}

# Add project resource
resource "tableau_project" "test_project" {
  name                = "Terraform Test Project"
  description         = "Testing Terraform connectivity"
  content_permissions = "ManagedByOwner"
}

# Create a new user
resource "tableau_user" "test_user" {
  name        = var.test_user_email    # This will be the user's email
  site_role   = "Explorer"            # Explorer role for standard access
  auth_setting = "SAML"               # Using SAML authentication
  email        = var.test_user_email
  full_name    = var.test_user_name
}

# Create a group
resource "tableau_group" "test_group" {
  name              = "Test Analysis Group"
  minimum_site_role = "Viewer"         # Minimum role required for group members
}

# Add user to group
resource "tableau_group_user" "test_group_membership" {
  group_id = tableau_group.test_group.id
  user_id  = tableau_user.test_user.id
}

# Set project permissions for the group
resource "tableau_project_permission" "test_group_permissions" {
  project_id      = tableau_project.test_project.id
  group_id      = tableau_group.test_group.id
  capability_name = "Write"           # Allows group members to write to the project
  capability_mode = "Allow"
}
