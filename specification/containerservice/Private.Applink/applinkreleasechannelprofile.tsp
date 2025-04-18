import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.CloudAppLink;

/** Location */
@subscriptionResource
model Location is ProxyResource<LocationProperties> {
  ...ResourceNameParameter<Location>;
}

/** Location Properties */
model LocationProperties {
}

/** AppLink Release Channel Profile */
@parentResource(Location)
model AppLinkReleaseChannelProfile is ProxyResource<AppLinkReleaseChannelProfileProperties> {
  ...ResourceNameParameter<AppLinkReleaseChannelProfile>;
}

/** AppLink Revision Channel Profile Properties */
model AppLinkReleaseChannelProfileProperties {
  AppLinkReleaseChannels: AppLinkReleaseChannel[];
}

/** AppLink Revision Channel */
model AppLinkReleaseChannel{
  releaseChannel: string;
  revision: string;
  compatibleWith: CompatibleWith[];
}

/** Compatible With*/
model CompatibleWith{
  name: string;
  versions: string[];
}

/** Location operations */
@armResourceOperations
interface Locations {
}

/** AppLinkReleaseChannelProfiles operations */
@armResourceOperations
interface AppLinkReleaseChannelProfiles {
  listByLocation is ArmResourceListByParent<AppLinkReleaseChannelProfile>;
}
