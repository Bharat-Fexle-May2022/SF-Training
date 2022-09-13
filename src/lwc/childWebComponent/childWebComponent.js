import { LightningElement, track,api } from "lwc";

export default class ChildWebComponent extends LightningElement {
  @track value='Good Morning'; //reactive in nature 
  //public method
  @api handleValueChange() {
    alert('This is childWebComponent Method');
    this.value='Good Night';
  }
}