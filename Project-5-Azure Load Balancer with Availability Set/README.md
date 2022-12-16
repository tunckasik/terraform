# Terraform Project -5: Azure Load Balancer with Availability Set
### Scenario
We are tasked with provisioning an Azure Load Balancer for the HTTP and HTTPS requests with an availability set as the backend pool. We are also tasked to output subnet IDs and the load balancer's frontend IP. Lastly we will keep the tfstate file in a separate storage account remotely.

### Objectives
In this lab, we will:
- Task 1: Provision the required lab environment.
- Task 2: Provision the load balancer.
- Task 3: Output subnet IDs and load balancer's frontend IP.
- Task 4: Configure the tfstate file remote storage.

### Instructions

#### Task 1: Provision the required lab environment

In this task, we are required provisioning the lab environment, we create:
- a resource group named **tf-bronze-rg1**,
- a virtual network named **tf-vnet1**,
- two subnets named **frontend_subnet** and **backend_subnet**,
- a storage account with a unique name,
- two virtual machines named **tf-vm-0** and **tf-vm-1** in an availability set named **tf-a_set**.

#### Task 2: Provision the load balancer
In this task, we create the load balancer with the name **frontend_lb**. 
In order to create the load balancer, we will need to create:

- a frontend public IP,
- a backend pool (our availability set),
- a health probe for HTTP,
- a load balancing rule for HTTP,
- a health probe for HTTPS,
- a load balancing rule for HTTPS.

#### Task 3: Output subnet IDs and load balancer's frontend IP
For this task, we create an ```outputs.tf``` file with the content subnet IDs and load balancer's frontend IP.

### Task 4: Configure the tfstate file on remote storage
For this task, we use an already created resource group and an existing storage account with a container named ```terraform```.

