import { LightningElement, api } from 'lwc';
import getContactTile from '@salesforce/apex/ContactController.getContactTile';
export default class tileViewLwc extends LightningElement {
    contacts;
    error;
    connectedCallback() {
		this.loadContact();
	}
	loadContact() {
	    getContactTile()
		.then(result => {
			this.contacts = result;
		});
	}

}