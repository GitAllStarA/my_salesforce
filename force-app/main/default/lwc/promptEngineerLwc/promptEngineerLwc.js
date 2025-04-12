import { LightningElement, wire } from 'lwc';
import createChat from '@salesforce/apex/ModelsAPIChat.createChat';
import { subscribe, MessageContext } from 'lightning/messageService';
import COMPONENT_PUB_SUB from '@salesforce/messageChannel/ComponentPubSub__c';


export default class PromptEngineerLwc extends LightningElement {
    system_prompt = 'Think about it in small, simple steps.';
    user_prompt = '';
    response = '';
    subMsg = 'no message yet';

    @wire(MessageContext)
    messageContext;

    subscription = null;

    connectedCallback() {
        if (!this.subscription) {
            this.subscription = subscribe(this.messageContext,
                 COMPONENT_PUB_SUB, 
                (payload) => this.handlePubMsg(payload))
        }
    }

    handlePubMsg(payload) {
        console.log('In handlePubMsg:', payload);
        this.subMsg = payload.message;
    }

    handleSystemPromptChange(event) {
        // Update the system prompt when a new option is selected in the combobox
        this.system_prompt = event.target.value;
    }

    handleUserPromptChange(event) {
        // Update the user prompt when a new option is selected in the combobox
        this.user_prompt = event.target.value;
    }

    handleClick(event) {
        this.response = 'Processing your question… One moment.';
        createChat({ systemPrompt: this.system_prompt, userPrompt: this.user_prompt })
            .then(result => {
                this.response = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.accounts = undefined;
            })
    }


}