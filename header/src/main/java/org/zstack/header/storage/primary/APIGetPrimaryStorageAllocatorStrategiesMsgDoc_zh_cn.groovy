package org.zstack.header.storage.primary

import org.zstack.header.storage.primary.APIGetPrimaryStorageAllocatorStrategiesReply

doc {
    title "GetPrimaryStorageAllocatorStrategies"

    category "storage.primary"

    desc "在这里填写API描述"

    rest {
        request {
			url "GET /v1/primary-storage/allocators/strategies"


            header (OAuth: 'the-session-uuid')

            clz APIGetPrimaryStorageAllocatorStrategiesMsg.class

            desc ""
            
			params {

				column {
					name "systemTags"
					enclosedIn ""
					desc ""
					location "query"
					type "List"
					optional true
					since "0.6"
					
				}
				column {
					name "userTags"
					enclosedIn ""
					desc ""
					location "query"
					type "List"
					optional true
					since "0.6"
					
				}
			}
        }

        response {
            clz APIGetPrimaryStorageAllocatorStrategiesReply.class
        }
    }
}