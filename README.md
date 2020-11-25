# Build Agent for Azure DevOps
An Azure Marketplace offering for our managed Build Agent for Azure DevOps 🚀 💥

## Build Agent SCALABLE
### Connect to a VM for troubleshooting
By default all VM's inside the scale set are not provisoined with a public ip, thus can not be reached from outside e.g. trough SSH. 
In case there is the need to connect to a VM you can use Vnet peering and Azure Bastion. There are a couple important steps, when creating the Vnet.
#### Deploy the Vnet:
- Start the creation of a Vnet inside a new resource group
- In the "Security" step, enable **BastionHost**
- Input a valid address space for the *AzureBastionSubnet* field according to the Vnet address space - e.g. 192.168.1.0/24
- Select "Create new" under the *Public IP address* field and give it a name
- Create the Vnet

#### Set up Vnet peering:
- Select the newly created Vnet
- In the **Peerings** blade under *Settings*, click **Add**
![peering](./img/peering.png)
- Input a Peering link name for this virtual network and for the remote virtual network
- Select the correct Subscription and virtual network (Vnet of the scale set)
- Click **Add** to create the peering

#### Connect to the VM
- Select the VM instance to connect to
- Click **Connect** and select the option **Bastion**
![peering](./img/connect.png)
- Click **Use Bastion** and input the login credentials for the VM
- Click **Connect**
