import java.util.LinkedList;
import processing.opengl.*;
import processing.sound.*;

LinkedList particles = new LinkedList();
int maxVelocity = 10;
int maxAdd = 5;
int numTrue = 0;
LinkedList colors = new LinkedList();
SoundFile file;
int mousePressedTime;

void setup()
{
    size(512,512,OPENGL);
    colorMode(RGB);
    colors.add(color(255, 0, 0));
    colors.add(color(0, 255, 0));
    colors.add(color(0, 0, 255));
    colors.add(color(128, 0, 0));
    colors.add(color(0, 128, 0));
    colors.add(color(0, 0, 128));
    colors.add(color(255, 255, 0));
    colors.add(color(255, 0, 255));
    colors.add(color(0, 255, 255));
    colors.add(color(128, 128, 0));
    colors.add(color(128, 0, 128));
    colors.add(color(0, 128, 128));
    file = new SoundFile(this, "/home/amirrj/Downloads/Multimedia-Systems/fireworks/fireworks.mp3");
}

void draw()
{
  background(0);
  color(255, 255, 255);
  if (numTrue < 1){
    for (int i = 0; i < (int)(random(maxAdd)); i++){
        addParticle(true, (int)(random(width)), height, 150, 15);
    }
  }
  for (int i = 0; i < particles.size(); i++)
  {
    Particle p = (Particle)particles.get(i);
    p.update();
    p.draw();
    if (! p.isAlive()){
        if (p.type){
            file.play();
            for (int j = 0; j < maxAdd * 5; j++){
                addParticle(false, (int)p.x, (int)p.y, 200, 6);
            }
            numTrue -= 1;
        }
        particles.remove(p);
        }
    }
}

void mousePressed(){
    mousePressedTime = millis();
}

void mouseReleased()
{
    int mouseTime = millis() - mousePressedTime;
    mouseTime = mouseTime / 100;
    addParticleByMouse(true, mouseX, mouseY, 150, 15, - mouseTime);
}
void addParticle(boolean type, int x, int y, int life_time, int size){
    int index = (int)random(12);
    color c = (color)colors.get(index);
    Particle p = new Particle(
        type,
        x,
        y, 
        (int)(random(maxVelocity)-maxVelocity/2),
        (int)(random(maxVelocity) + 1) * -1,
        size,
        c,
        life_time,
        0.25);
    if (type){
        numTrue += 1;
    }
    particles.add(p);
}

void addParticleByKey(boolean type, int x, int y, int life_time, int size, int speed){
    int index = (int)random(12);
    color c = (color)colors.get(index);
    Particle p = new Particle(
        type,
        x,
        y, 
        speed,
        (int)(random(maxVelocity) + 1) * -1,
        size,
        c,
        life_time,
        0.25);
    if (type){
        numTrue += 1;
    }
    particles.add(p);
}

void addParticleByMouse(boolean type, int x, int y, int life_time, int size, int speed){
    int index = (int)random(12);
    color c = (color)colors.get(index);
    Particle p = new Particle(
        type,
        x,
        y, 
        (int)(random(maxVelocity)-maxVelocity/2),
        speed,
        size,
        c,
        life_time,
        0.25);
    if (type){
        numTrue += 1;
    }
    particles.add(p);
}

void keyPressed()
{
    if (key == '1'){
        for (int i = 0; i < 10 + (int)random(10); i++){
            addParticle(true, (int)(random(width)), height, 150, 15);
        }
    }
    if (key == '3'){
        for (int i = 0; i < 10 + (int)random(10); i++){
            addParticleByKey(true, 0, (int)(random(height)), 150, 15, 5);
        }
    }
    if (key == '2'){
        for (int i = 0; i < 10 + (int)random(10); i++){
            addParticleByKey(true, width, (int)(random(height)), 150, 15, -5);
        }
    }
    if (key == 'q'){
        exit();
    }
}