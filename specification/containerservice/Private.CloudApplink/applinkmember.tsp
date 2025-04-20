import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.CloudAppLink;

/** AppLinkMember resource */
@parentResource(AppLink)
model AppLinkMember is ProxyResource<AppLinkMemberProperties> {
  ...ResourceNameParameter<AppLinkMember>;
}

/** AppLink properties */
model AppLinkMemberProperties {
  type: string;
  metadata: Metadata;
  internalMetadata: AppLinkMemberInternalMetadata;
  upgradeProfile: UpgradeProfile;
  provisioningState?: ProvisioningState;
}

model Metadata {
  resourceID: string;
}

enum ReleaseChannel {
  Rapid: "Rapid",
  Stable: "Stable",
  legacy: "Legacy",
}

enum UpgradeMode {
  AutoUpgrade: "AutoUpgrade",
  Disabled: "Disabled",
}

model UpgradeProfile {
  releaseChannel: ReleaseChannel;
  mode: UpgradeMode;
}

model AppLinkMemberInternalMetadata {
  umiResource: UMIResource;
  dnsRecordSet: ProvisionResource;
  extension: ProvisionResource;
  underlay: UnderlayMetadata;
  mcpNameSpace: string;
}

model UMIResource {
  umi: ProvisionResource;
  roleAssignments: ProvisionResource[];
}

@armResourceOperations
interface AppLinkMembers {
  get is ArmResourceRead<AppLinkMember>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AppLinkMember>;
  update is ArmResourcePatchAsync<AppLinkMember, AppLinkMemberProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AppLinkMember>;
  listByAppLink is ArmResourceListByParent<AppLinkMember>;
}
