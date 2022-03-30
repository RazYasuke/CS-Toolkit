## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ELK Diagram](https://github.com/RazYasuke/CS-Toolkit/ELK/Diagrams/ELKStackNetworkDiagram.drawio.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Yaml source file may be used to install only certain pieces of it, such as Filebeat.

	- [Elk Install](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Ansible/INSTALL-ELK.yml)
	- [Docker Install](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Ansible/INSTALL-DOCKER.yml)
	- [Metricbeat Playbook](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Ansible/METRICBEAT-PLAYBOOK.yml)
	- [Filebeat Playbook](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Ansible/FILEBEAT-PLAYBOOK.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly accessible, in addition to restricting unauthorized access to the network.
- Load Balancing plays an important security role as computing moves evermore to the cloud. The off-loading function of a load balancer defends an organization against distributed denial-of-service (DDoS) attacks. 
- The JumpBox is the Admin access gate keeper of the cloud network, controlling administrative access to the cloud network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs.
- Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing.
- Metricbeat is a lightweight shipper that you can install on your servers to periodically collect metrics from the operating system and from services running on the server. Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash.

The configuration details of each machine may be found below.


| Name       | Function   | IP Address | Operating System                           |
|------------|------------|------------|--------------------------------------------|
| JumpBox    | Gateway    | 10.0.0.4   | Linux Standard B1s (1 vcpu, 1 GiB memory)  |
| ELK Server | Log Server | 10.1.0.4   | Linux Standard B2s (2 vcpus, 4 GiB memory) |
| WEB 1      | Web Server | 10.0.0.5   | Linux Standard B1ms (1 vcpu, 2 GiB memory) |
| WEB 2      | Web Server | 10.0.0.6   | Linux Standard B1ms (1 vcpu, 2 GiB memory) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the JumpBox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Authorized Device IP (confidential)

Machines within the network can only be accessed administratively by the JumpBox.
- You can only access the ELK Server via the JumpBox (10.0.0.4) using the ssh key stored in an Docker container.

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Addresses |
|---------------|---------------------|----------------------|
| JumpBox       | Yes                 | Authorized Device IP |
| Load Balancer | Yes                 | Open                 |
| ELK Server    | No                  | 10.0.0.4             |
| Web 1 & 2     | No                  | 10.0.0.4             |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it can be used for orchestration. 
	- Orchestration is the automated configuration, management, and coordination of computer systems, applications, and services.

The playbook implements the following tasks:
- Install docker.io
- Install python3-pip
- Install docker module
- Increase virtual memory
- Use more memory
- Download and launch a docker elk container
- Enable service docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[Docker Output](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web 1 (10.0.0.5)
- Web 2 (10.0.0.6)

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat is a log data shipper for local files. Installed as an agent on your servers, Filebeat monitors the log directories or specific log files, tails the files, and forwards them either to Elasticsearch or Logstash for indexing. An examle of such are the logs produced from the MySQL database supporting our application. 
- Metricbeat collects metrics and statistics on the system. An example of such is cpu usage, which can be used to monitor the system health.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the configuration file from your Ansible container to your Web VM's 
- Update the /etc/ansible/hosts file to include the IP address of the Elk Server VM and webservers.
- Run the playbook, and navigate to http://[Elk_VM_Public_IP]:5601/app/kibana to check that the installation worked as expected.


- Copy the /etc/ansible/files/filebeat-config.yml to /etc/filebeat/filebeat.yml
- Update the filebeat-config.yml file by specifying which machine(s) to install filebeat by updating the host files with ip addresses of web/elk servers and selecting which group to run on in ansible.
 
- Navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana in order to check that the ELK server is running.

Run my [ELK Setup](https://github.com/RazYasuke/CS-Toolkit/tree/main/ELK/Deployment/Linux/ELK_Setup.sh) script to deploy the ELK Stack and configure the network.
