import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track result
    @track operation = ""
    @track showResult = false

    handleAdd(event) {
        this.operation = event.target.title
        this.result = parseFloat(this.template.querySelectorAll(".operand")[0].value) + parseFloat(this.template.querySelectorAll(".operand")[1].value);
        this.showResult = true;
    }
    handleSub(event) {
        this.operation = event.target.title
        this.result = parseFloat(this.template.querySelectorAll(".operand")[0].value) - parseFloat(this.template.querySelectorAll(".operand")[1].value);
        this.showResult = true;
    }
    handleMul(event) {
        this.operation = event.target.title
        this.result = parseFloat(this.template.querySelectorAll(".operand")[0].value) * parseFloat(this.template.querySelectorAll(".operand")[1].value);
        this.showResult = true;
    }
    handleDiv(event) {
        this.operation = event.target.title
        this.result = (parseFloat(this.template.querySelectorAll(".operand")[0].value) / parseFloat(this.template.querySelectorAll(".operand")[1].value)).toFixed(3);
        this.showResult = true;
    }
}