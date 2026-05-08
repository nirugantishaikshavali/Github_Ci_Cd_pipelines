public class Mercedes implements IVehicle,IDML{
    public void start(){
        System.debug('start');
    }
    
    public void stop(){
                System.debug('stop');

    }
    
    public String changeGear(){
                System.debug('change gear');

        return '';
    }
    
    public Boolean openDoor(String doorType){
     return true;   
    }
    
    public void operators(){
        System.debug('Operators');
    }

}