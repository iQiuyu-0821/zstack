package org.zstack.sdk;

import org.zstack.sdk.DataCenterInventory;

public class AddDataCenterFromRemoteResult {
    public DataCenterInventory inventory;
    public void setInventory(DataCenterInventory inventory) {
        this.inventory = inventory;
    }
    public DataCenterInventory getInventory() {
        return this.inventory;
    }

}
