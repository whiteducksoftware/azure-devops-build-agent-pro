# Build Agent SCALABLE - setup

## Connect to Azure DevOps agent pool

After deployment it is required to connect the newly created scale set with Azure DevOps. Azure DevOps will take care of installing the agents and scaling the VM's in and out.

## Create a scale set agent pool

- Open the *Organisation Settings* or *Project Settings* in Azure DevOps
- Navigate to **Agent pools** under the **Pipelines** section and click **Add pool**

![agent_pools](img/agent_pools.png)

- in the *Pool type* dropdown field select **Azure virtual machine scale set**
- Select the correct Azure Subscription and scale set name
- Input a name for the new agent pool
- Set the pool options based on your needs and preferences
- Click **Create**

After creation, Azure DevOps will start provisioning build VM's according to the specified pool settings

Helpful links: [Create a scale set agent pool](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops#create-the-scale-set-agent-pool)