import { LightningElement, wire } from 'lwc';
import {subscribe, MessageContext} from 'lightning/messageService';
import COUNTING_UPDATE_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';

export default class SubLwc extends LightningElement {
    counter = 0;
    subscription = null;

    @wire(MessageContext)
    MessageContext;

    connectedCallback() {
        this.subscriptionToMessageChannel();
    }

    subscriptionToMessageChannel() {
        this.subscription = subscribe(
            this.MessageContext,
            COUNTING_UPDATE_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        // alert("message:" + JSON.stringify(message));

        if(message.operator == 'add') {
            this.counter += message.constant;
        }
        else if(message.operator == 'subtract') {
            this.counter -= message.constant;
        }
        else if(message.operator == 'multiply') {
            this.counter *= message.constant;
        }
    }
}