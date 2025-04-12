import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COMPONENT_PUB_SUB from '@salesforce/messageChannel/ComponentPubSub__c';


const columns = [{ label: 'name', fieldName: 'name' },
{ label: 'status', fieldName: 'status' },
]
const statuses = ["Available", "In Use", "Offline", "In Use", "Discontinued", "Updating"];

export default class Billing extends LightningElement {

    columns = columns;
    statuses = statuses;
    billingPeripherals = [];

    @wire(MessageContext)
    messageContext;

    subscription = null;

    connectedCallback() {
        if (!this.subscription) {
            this.subscription = subscribe(this.messageContext, COMPONENT_PUB_SUB, (payload) => this.handleBillingPeripherals(payload));
        }
    }


    // Pick a random status
    handleBillingPeripherals(payload) {
        console.log('payload.billing')
        if (payload.billing != null && payload.billing.length > 0) {
            if(this.billingPeripherals.length > 0 ){
                this.billingPeripherals = [];
            }
            this.billingPeripherals = payload.billing.map(billingDevice => {
                return {
                    ...billingDevice,
                    status: this.statuses[Math.floor(Math.random() * statuses.length)],
                }
            });
        }
        console.log('added billing peripherals status');
        console.log(this.billingPeripherals);
    }
}