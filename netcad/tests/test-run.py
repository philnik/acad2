

import netcad.model as m

mRun = m.RUN()

def make_lot_of_circles(ncircles):
    mRun = m.RUN()
    for i in range(ncircles):
        mRun.Command(f'_circle 0,0 {i} ')

make_lot_of_circles(800)





