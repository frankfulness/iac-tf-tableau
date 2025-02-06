# iac-tf-tableau

🏗️ IaC PoC using a Terraform provider for Tableau Server (14-day Trial) to provision Users, User Groups, Projects, &amp; Permissions.

### Notes:

Initially ran into an issue utilizing the Tableau trial site admin user/pass strangely it wouldn't put the subdirectories inside the parent. I reported it:
https://github.com/GtheSheep/terraform-provider-tableau/issues/34

The owner was responsive. I was able to test the provider with a real service account creds that uses SAML and had 0 issues with user, user group, project, sub directories in the project, user group assignment, and permissions. There is some nuance regarding the Tableau API to determine for advanced cases, that may deem a Python or Go script necessary.

Overall, this is the best available Tableau Terraform Provider for IaC I've seen. Unless you want to write scripts that parse a JSON file for semi-automation.

`terraform init`

<img width="810" alt="Screenshot 2025-01-29 at 9 43 36 AM" src="https://github.com/user-attachments/assets/ee465f5a-9220-4b72-aec7-8ce04ed12817" />

`terraform apply`

<img width="1257" alt="Screenshot 2025-01-29 at 9 51 48 AM" src="https://github.com/user-attachments/assets/5b446bc1-c4f6-45bf-a384-77eaf9473b1b" />

`terraform plan`

<img width="1263" alt="Screenshot 2025-01-29 at 10 07 19 AM" src="https://github.com/user-attachments/assets/f184934e-09d8-4e1b-af1c-828eb782895e" />

# DEMO Clip

https://github.com/user-attachments/assets/87e3b274-d0a7-47f7-a685-250eea65b2fb
