import { LightningElement, api } from 'lwc';

export default class StoreMapBuyFlow extends LightningElement {

    @api recordId;

    flowApiName = "flowFromStoreMap";

    isFlowRendered = false;

    get flowInputVariables() {
        return [
            {
                name: 'accountId',
                type: 'String',
                value: this.recordId,
            }
        ];
    }

    connectedCallback() {
        
        if (this.recordId) {
            console.log("yes recordId after connected " + this.recordId);
            this.isFlowRendered = true;
        }
        else {
            setTimeout(() => {
                if(this.recordId){
                    console.log("loaded afteer the delay");
                    this.isFlowRendered = true;
                } else {
                    console.log("not yet after the delay");
                    this.isFlowRendered = false;
                }
            }, 300);
        }
    }



    handleFlowStatusChange(event) {
        console.log("flow status", event.detail.status);
    }

    handleClick() {
        console.log('rec id ->>>' + this.recordId);
        this.isFlowRendered = true;
    }

}