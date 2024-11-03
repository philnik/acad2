import netcad.model as m
import math

def add_lot_of_lines():
    Add = m.ADD()
    for i in range(50):
        c = 4
        angle = c*i/100.0*math.pi*2
        r = 10+i
        x = r*i*math.sin(angle*0.5)
        y = r*i*math.cos(angle)
        Add.Line(x,0,0,y)

//add_lot_of_lines()





