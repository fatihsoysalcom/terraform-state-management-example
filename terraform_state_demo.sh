#!/bin/bash

# This script demonstrates basic Terraform state management concepts.
# It simulates creating, inspecting, and potentially moving Terraform state.
# This is a simplified example and does not involve actual cloud resources.

# --- Configuration ---
# In a real-world scenario, this would be a remote backend like S3, GCS, or Azure Blob Storage.
# For this demo, we'll use a local file for simplicity.
STATE_FILE="terraform.tfstate"

# --- Helper Functions ---
function echo_step() {
  echo "\n--------------------------------------------------"
  echo "$1"
  echo "--------------------------------------------------"
}

# --- Script Logic ---

# 1. Initialize Terraform (simulated)
# In a real scenario, 'terraform init' would configure the backend.
# For this demo, we'll just create a dummy state file.
echo_step "Simulating Terraform Initialization and State Creation"

# Create a dummy initial state file
cat <<EOF > "$STATE_FILE"
{
  "version": 4,
  "terraform_version": "1.0.0",
  "serial": 1,
  "lineage": "some-uuid",
  "modules": [
    {
      "path": ["root"],
      "outputs": {},
      "resources": {},
      "depends_on": []
    }
  ],
  "outputs": {},
  "resources": {},
  "providers": {},
  "dep_graph": {}
}
EOF

echo "Created dummy state file: $STATE_FILE"

# 2. Inspect Terraform State
echo_step "Inspecting Terraform State (Simulated)"

# In a real scenario, you would use 'terraform state list' or 'terraform show'
# For this demo, we'll just display the content of our dummy state file.
cat "$STATE_FILE"

# 3. Simulate Applying Changes and Updating State
echo_step "Simulating Terraform Apply and State Update"

# In a real scenario, 'terraform apply' would create resources and update the state.
# We'll manually edit the state file to reflect a hypothetical resource.

# Create a backup of the current state
cp "$STATE_FILE" "${STATE_FILE}.bak"

# Simulate adding a resource to the state
# This is a highly simplified representation of a resource in the state file.
cat <<EOF >> "$STATE_FILE"
,
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web_server",
      "provider": "provider.aws",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0abcdef1234567890",
            "instance_type": "t2.micro",
            "tags": {
              "Name": "HelloWorld"
            }
          },
          "sensitive_attributes": []
        }
      ]
    }
  ]
}
EOF

# Fix the JSON structure by removing the trailing comma from the previous section if it exists
# This is a crude fix for demonstration purposes.
sed -i 's/\n}\n,/\n}/' "$STATE_FILE"

echo "Simulated adding 'aws_instance.web_server' to state."

# Show the updated state
echo "Updated Terraform State:"
cat "$STATE_FILE"

# 4. Simulate Moving State (e.g., to a remote backend)
echo_step "Simulating Moving State to Remote Backend (Conceptual)"

# In a real scenario, this would involve 'terraform init -reconfigure' and potentially
# manual migration steps or using specific backend migration tools.
# For this demo, we'll just acknowledge the concept.
echo "In a real-world scenario, you would configure a remote backend (e.g., S3, GCS) in your Terraform configuration."
echo "Then, you would run 'terraform init' to switch to the remote backend."
echo "Terraform automatically handles moving the state to the configured remote backend."

# Clean up dummy state file
echo_step "Cleaning up dummy state file"
rm "$STATE_FILE" "${STATE_FILE}.bak"
echo "Removed $STATE_FILE and its backup."

echo "\nDemo finished."
