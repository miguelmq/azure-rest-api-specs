import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Private.CloudAppLink;

union ProvisioningState {
  string,
  ResourceProvisioningState,
  Provisioning: "Provisioning",
  Updating: "Updating",
  Deleting: "Deleting",
  Accepted: "Accepted",
}

model ProvisionResource {
  name: string;
  type: string;
  resourceID: string;
}

model UnderlayMetadata {
  name: string;
  tenantID: string;
  location: string;
  resourceProvisionSubID: string;
  resourceProvisionRG: string;
  ingressGatewayIP: string;
  meshManagerAddress: string;
}
