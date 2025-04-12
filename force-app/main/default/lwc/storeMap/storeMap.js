import { LightningElement } from 'lwc';

export default class StoreMap extends LightningElement {

    constructor() {
        super()
        console.log("creating the component");
    }

    connectedCallback(){
        console.log("connectedCallback");

    }
}