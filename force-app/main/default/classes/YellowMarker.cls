public class YellowMarker extends Marker {
    
        public YellowMarker(String name,String color,String message){
            super(name,color);

        }
    public void main(){
        super.markerName='Yellow';
        super.write();
        super.paint();
    }
        
        public override void write(){
            System.debug('Marker color is'+super.markerName);
        }     
       // write();
    

}