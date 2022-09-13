import { LightningElement, wire } from 'lwc';
import {publish, MessageContext} from 'lightning/messageService';
import COUNTING_UPDATE_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';

export default class PubLwc extends LightningElement {
    @wire(MessageContext)
    messageContext;

    handleIncreament() {
        const payload = {
            operator:'add',
            constant:1
        };

        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payload);
    }

    handleDecreament() {
        const payload = {
            operator:'subtract',
            constant:1
        };

        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payload);
    }

    handleMultiply() {
        const payload = {
            operator:'multiply',
            constant:2
        };

        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payload);
    }
}