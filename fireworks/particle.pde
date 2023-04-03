import java.util.LinkedList;

class Particle{
    float x, y;             // position
    float vx, vy;           // velocity
    float size;             // size
    int life_time = 200;    // life time
    int clr;                // color
    float gravity;
    boolean type;
    LinkedList xlocs = new LinkedList();
    LinkedList ylocs = new LinkedList();

    public Particle(boolean type,int x, int y, int vx, int vy, int size, int c, int life_time, float g){
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.size = size;
        this.clr = c;
        this.life_time = life_time;
        gravity = g;
        this.type = type;
    }

    public void update(){
        life_time -= 5;
        if (xlocs.size() == 10) {
          xlocs.remove(xlocs.get(0));
          ylocs.remove(ylocs.get(0));
        }
        xlocs.add(x);
        ylocs.add(y);
        x += vx;
        y += vy;
        vy += gravity;
        if ((x >= width) || (x <= 0)){
            vx = -vx;
        }
        if ((y >= height) || (y <= 0)){
            vy = -vy;
        }
    }
    public void draw(){
        fill(clr, life_time);
        ellipse(x, y, size, size);
        int xlocs_size = xlocs.size();
        for (int i = 0; i < xlocs_size; i++){
          ellipse((float)xlocs.get(i), (float)ylocs.get(i), size - xlocs_size + i, size - xlocs_size + i);
        }
        fill(255);
    }
    public boolean isAlive(){
        return life_time >= 0;
    }
}
