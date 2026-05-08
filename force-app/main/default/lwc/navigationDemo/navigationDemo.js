import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationDemo extends NavigationMixin(LightningElement) {

 navigateToObjectHome() {
    // Navigate to the Account home page
    this[NavigationMixin.Navigate]({
      type: "standard__objectPage",
      attributes: {
        objectApiName: "Case",
        actionName: "home",
      },
    });
}

}