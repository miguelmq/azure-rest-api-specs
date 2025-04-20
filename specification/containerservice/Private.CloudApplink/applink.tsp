import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.CloudAppLink;

/** AppLink resource */
model AppLink is TrackedResource<AppLinkProperties> {
  ...ResourceNameParameter<AppLink>;
}

/** AppLink properties */
model AppLinkProperties {
  internalMetadata: AppLinkInternalMetadata;
  provisioningState?: ProvisioningState;
}

model AppLinkInternalMetadata {
  akvResource: ProvisionResource;
  rootCert: ProvisionResource;
  underlay: UnderlayMetadata;
}

@armResourceOperations
interface AppLinks {
  get is ArmResourceRead<AppLink>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLink>;
  update is ArmResourcePatchAsync<AppLink, AppLinkProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLink>;
  listByResourceGroup is ArmResourceListByParent<AppLink>;
}
