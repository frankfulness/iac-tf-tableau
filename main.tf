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

# Main project (keeping existing configuration)
resource "tableau_project" "test_project" {
  name                = "Terraform Test Project"
  description         = "Testing Terraform connectivity"
  content_permissions = "ManagedByOwner"
}

# Create test user
resource "tableau_user" "test_user" {
  name         = var.test_user_email
  site_role    = "Explorer"
  auth_setting = "SAML"
  email        = var.test_user_email
  full_name    = "Test User"  # Set the correct name directly
}

# Create group
resource "tableau_group" "test_group" {
  name              = "Test Analysis Group"
  minimum_site_role = "Viewer"
}

# Add user to group
resource "tableau_group_user" "test_group_membership" {
  group_id = tableau_group.test_group.id
  user_id  = tableau_user.test_user.id
}

# Set main project permissions for group
resource "tableau_project_permission" "test_group_permissions" {
  project_id      = tableau_project.test_project.id
  group_id        = tableau_group.test_group.id
  capability_name = "Write"
  capability_mode = "Allow"
}

# Public access project with default visibility
resource "tableau_project" "public_project" {  # Renamed to avoid state conflicts
  name                = "TF Test Project - Public Access"
  description         = "Project accessible to all users"
  content_permissions = "LockedToProject"  # Set during creation
}

# Restricted access project
resource "tableau_project" "restricted_project" {  # Renamed to avoid state conflicts
  name                = "TF Test Project - Restricted Access"
  description         = "Project accessible only to test group members"
  content_permissions = "ManagedByOwner"
}

# Set permissions for restricted project
resource "tableau_project_permission" "group_restricted_project_access" {
  project_id      = tableau_project.restricted_project.id
  capability_name = "Read"
  capability_mode = "Allow"
  group_id        = tableau_group.test_group.id
}
