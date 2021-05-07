# Final Project - Team 3

## Project Overview
For this final project, we had to work as a team to deploy a pre-made app as effectively as possible, using the tools and skills that we have been developing over the last 11 weeks. We would also be required to make a presentation to explain the app, all of the steps we took in deploying it and why we chose to do this way. This project allowed for much more freedom in deciding how to achieve the desired goal, and allowed us to make more executive decisions on automation and deployment.  

A secondary focus of this project was to experience working together as a team and managing the workload equally, as this is an invaluable DevOps trait that will not only help to prepare us for interviews, but it will also prepare us for future employment.

## Project Brief
You will need to plan, design and implement a solution for automating the development workflows and deployments of this application. As part of your final deliverable you will need to discuss the project in a presentation and demonstrate these workflows.

Using what you have learned, you must determine what tools will work best in the deployment of the application, how to test the application in a working enviroment before pushing any changes to the main branch, how to automatically build changes after they are pushed to the repository and assess the cost of running your application and what steps you can put in place to reduce them.

## Installation and Setup
In order to build the Docker images and containerise them using a Linux Ubuntu operating system (tested on Ubuntu 20.04), run the following:
1. (git init &&) git clone https://github.com/thomaslplant/team3-final-project.git
2. cd team3-final-project
3. sh scripts/docker-install-linux.sh
4. sh docker-compose-install-linux.sh
5. docker-compose build
6. docker-compose up

In order to setup the Docker containers within a cluster of Kubernetes (EKS) pods and deploy the infrastructure using Terraform on AWS, run steps 1-5 above, followed by:
1. sh scripts/awsconfigure.sh
2. sh scripts/install-tf.sh
3. aws configure [ENTER YOUR USER CREDENTIALS HERE]
4. sh scripts/eksctl.sh
5. Use AWS console to setup a VPC with subnets, an Internet Gateway, a NAT Gateway and configured route tables
6. Amend the terraform/main.tf file to reflect the subnet_ids of the subnets in your VPC
7. sh scripts/terraform.sh
8. sh scripts/deployapp.sh

## What tools will be used?
To complete this project to a high standard I will be using various programs, languages and systems and utilise all of the various tools that they offer. Some of which will be:  

|Tools               |Tools & programs    |Version         |
|--------------------|--------------------|----------------|
|Build tool          |Docker              |Version 20.10.5 |
|Containerisation    |Docker-compose      |Version 1.29.0  |
|Automation Tool     |Jenkins             |Version 2.287   |
|IDE                 |Visual Studio Code  |Version 1.55.0  |
|Infrastructure tool |Terraform           |Version 0.15.1  |
|Orchestration tool  |Kubernetes          |Version 1.21.0  |

## Risk Assessment

### Initial Assessment
Before we began the planning of project we first made an initial risk assessment to make sure that we had a solid plan of what issues we might face whilst completing the project. This would then be updated and added to during the process as there may be errors that we hadn't anticipated to begin with.

![risk_assessment1](https://user-images.githubusercontent.com/79214361/117330403-8e8a9280-ae8d-11eb-958d-913a3cfc77f5.png)


### Further Findings
Whilst we were working through the project, there were certain issues we encountered that we hadn't anticipated at the start. Some of which we managed to amend and got them to run with a little editing, and so we found it useful to document these as to avoid making the same mistakes again in future projects.  
			
![risk_assessment2](https://user-images.githubusercontent.com/79214361/117329833-f5f41280-ae8c-11eb-9565-08254c343864.png)


## Planning and Documentation
Over the duration of this project we planned each of the steps we needed to complete by using a Trello kanban board, which meant that everything is clearly laid out, and meant that it was easy to see what's finished and what's still yet to be finished. By doing this, it will ensure that time is managed well and all tasks will be completed in time.  

![Trello_board](https://user-images.githubusercontent.com/79214361/117205923-233bb480-adea-11eb-87a8-f13c7fcd684d.png)

Trello Board : https://trello.com/b/gFnT9NGS/project3

## CI/CD Pipeline
By creating a pipeline diagram it allowed us to get a clearer understanding of what each part of the project was doing, and the order in which the pipeline would be functioning. 

![Pipeline](https://user-images.githubusercontent.com/79214361/117265214-e6a0a500-ae4b-11eb-8e54-070bf9cea9e4.png)

## Cloud Infrastructure and Terraform
![image](https://user-images.githubusercontent.com/79214015/117448059-28a61580-af36-11eb-8463-0feaec4cca82.png)

![image](https://user-images.githubusercontent.com/79214015/117448146-45424d80-af36-11eb-9665-b294e5da7c62.png)

Pictured above is a basic overview of our cloud infrastructure used to deploy the application. It consists of a single VPC, with two subnets, each in a different availability zone. Each subnet has a route table, with routes to the internet gateway, making them public subnets.
The thinking behind the use of multiple availability zones was to allow greater connectivity to the application - less reliance on a single data center.

With the above infrastructure deployed, we then deployed our cluster across the two public subnets.

We used a CIDR block of 10.0.0.0/16 for our VPC, giving a range of 65534 hosts. These are divided up into smaller subnets with CIDR blocks of 10.0.1.0/24 and 10.0.2.0/24, resulting in 254 hosts in each subnet. Whilst this is small in scope, it can easily be scaled up to allow a greater number of hosts within each subnet.
 
We then had our development / Jenkins machine in a separate VPC, from which we deployed the cluster. This setup is clearly not ideal, and in the next section, we discuss our ideal infrastructure configuration.

### Ideal Cloud Infrastructure
![image](https://user-images.githubusercontent.com/79214015/117448263-702ca180-af36-11eb-8b08-f0ef87edea6a.png)

In an Ideal setup, we would have the whole deployment contained within a single VPC, split into multiple subnets:
* Private subnet
  * Has no routes connecting to the internet gateway.
  * Communicates with the public subnet via the NAT gateway (Allowing one-way communication from private to public subnet).
  * Contains any Jenkins / dev machines used to deploy the application.
  * Has a Security group, only allowing specific ports, such as ports for SSH, Jenkins, and testing.
* Public subnet
  * Has a route table, with a direct route to the internet gateway, allowing access to the user.
  * Contains the EKS cluster, and nodes running the application.
  * Contains a separate Nginx load balancer machine, which distributes the load across the EKS nodes.
  * Security group, that only allows connection to the ‘Nginx machine’ over port 80, making this the only way to access the app.

### Terraform
Terraform is an Orchestration tool that lets us define our AWS infrastructure as code.

When deploying an application, a potential problem is that the tools and infrastructure used to implement that deployment may change over time. For instance, updates to AWS services, or other unforeseen changes. Over time, these changes can build up and cause the deployment to fail. This problem, known as environment drift, is avoided by using Orchestration tools such as Terraform which let us implement immutable infrastructure.

Terraform lets us describe our desired cloud infrastructure in a declarative manner, and when applied, configures the infrastructure exactly as specified.

We use terraform to set up the following:
* Set up roles and policies for cluster.
* Set up EKS cluster.
* Setup roles and policies for node group
* Setup EKS node group

This approach is only a semi-automated configuration, as we are only using it to configure the Kubernetes cluster. Our initial attempts at full automation of cloud configuration were unsuccessful. As a result, we manually configured:

* VPC
* Two subnets
* Two route tables
* Two route table associations
* Internet gateway
* Elastic IPs
* NAT gateways
* Security group
* External Nginx Machine

Our attempts to configure the above can be found in the ‘Terraform-Failed-Attempt’ folder.

### Costing

![image](https://user-images.githubusercontent.com/79214015/117450162-c7cc0c80-af38-11eb-838b-0e41336503f8.png)


*ubuntu t3.medium, on demand instances, in eu-west-2 region 

* Total monthly cost of $178.41
* Note:
  * This is a small-scale deployment; larger scale deployments will cost more.
  * This Deployment does not make use of an AWS-managed database, which would increase the costs more.

## Testing
### Backend Testing:

![image](https://user-images.githubusercontent.com/79214361/117332501-d5798780-ae8f-11eb-818b-0984c68c47e1.png)

### Frontend Testing:
![image](https://user-images.githubusercontent.com/79214361/117332611-f4781980-ae8f-11eb-8bd8-154026c86d4b.png)


## Conclusion
To summerise, this project has been challenging and offered up many obstacles that we had to face, many of which presented valuable DevOps experience which emulated a real working environment. It was extremely useful to work as a team as we could utitlise each others strengths and allowed for us to complete tasks more effectively, as we were able to help one another where sections of the project proved difficult. Although parts of the application didn't end up working as we initially intended, this project has been extremely useful in providing oppertunities to troubleshoot existing code, solve deployment issues and apply best practices to our working processes. If we were to attempt this challenge again we would spend more time on configuring Kubernetes and Terraform to work collectively, and less time on testing and trying to get the app to work perfectly for us, as the deployment was more complex and proved to be more difficult.

## References
For the most part of this project, any knowledge and skills used had been taught to us by the QA teachers, specifically Vinesh Ghela, Dara Oladapo, Ben Hesketh, Harry Volker, Raji Kolluru, Peter Rhodes and Nathan Forester as well as information from the QA community website and Cloud Academy. On top of this we also used other sources of information on occasion, some of which include:

* https://registry.terraform.io/browse/modules
* https://docs.nginx.com/nginx/
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

On top of this, we also used [this](https://github.com/Kimovi/Spring_PetClinic_DevOps) demo repository,  to help us get an understanding about things such as file structure, an idea of what tools and programs handled each section of the project, and used it for inspiration as to how some of the tasks needed to be handled.

## Contributers

* Daniel Brownless (https://github.com/brownlessdaniel1)
* Raihan Ahmed (https://github.com/raihan1995)
* Robert Lewis (https://github.com/RobLewisQA)
* Thomas Plant (https://github.com/thomaslplant
