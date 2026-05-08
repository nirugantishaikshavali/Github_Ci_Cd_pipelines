public virtual class Marker {
    
    protected String markerName;
    protected String color;
    
   
    public Marker(String name,String color){
        this.markerName=name;
        this.color=color;
    }
    
    protected virtual void write(){
        System.debug(this.markerName+' is Writing ' + this.color);
    }
    
     protected virtual void erasing(){
        System.debug(this.markerName+' is Erasing ' + this.color);
    }
 protected virtual void paint(){
        System.debug(this.markerName+' is Painting ' + this.color);
    }
}