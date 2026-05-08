import { LightningElement } from 'lwc';

export default class LoopRendering extends LightningElement {
    carList = ["BMW", "Audi", "Kia", "Maruti", "Tata"];
    usersList = [
        {
            id: 1,
            name: "Shaik",
            age: 26
        },
        {
            id: 2,
            name: "Ankit",
            age: 28
        },
        {
            id: 3,
            name: "Raju",
            age: 25
        }
    ];

}