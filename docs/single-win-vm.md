# Build Agent SINGLE WINDOWS VM

## File structure

- configureVM.ps1 - used for configuring the build agent and installing some tooling
- createUIDefinition.json - describes the UI for deployments via Azure Marketplace
- mainTemplate.json - ARM template describing the Azure resources
- mainTemplate.parameters.json - parameters file used for local deployment and testing purpose. **Adapt values according to your needs**
- agent/vsts-agent-win-x64-2.186.1.zip

