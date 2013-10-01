package courses.alex.data;

public class Image {
    private String url       = "";
    private String effect    = "";
    private String contrast  = "";
    private String sharpness = "";
    private String moving  = "";
    private String scrollSpeed = "";

    public void setUrl(String url) {
        this.url = url;
    }

    public void setEffect(String effect) {
        this.effect = effect;
    }

    public void setContrast(String contrast) {
        this.contrast = contrast;
    }

    public void setSharpness(String sharpness) {
        this.sharpness = sharpness;
    }

    public void setMoving(String moving) {
        this.moving = moving;
    }
    
    public void setScrollSpeed(String scrollSpeed) {
        this.scrollSpeed = scrollSpeed;
    }
    
    public String getSrc() {
        return this.url;
    }

    public String getEffect() {
        return this.effect;
    }

    public String getContrast() {
        return this.contrast;
    }

    public String getSharpness() {
        return this.sharpness;
    }

    public String getMoving() {
        return this.moving;
    }

    public String getScrollSpeed() {
        return this.scrollSpeed;
    }

    public String toString() {
        String str = this.url;
        str += '-';
        str += this.effect;
        str += '-';
        str += this.contrast;
        str += '-';
        str += this.sharpness;
        str += '-';
        str += this.moving;
        str += '-';
        str += this.scrollSpeed;
        return str;
    }
}
