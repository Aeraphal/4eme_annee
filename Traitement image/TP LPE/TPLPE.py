import numpy as np
import cv2
from matplotlib import pyplot as plt

smarties = cv2.imread("smarties.png",0)
#plt.figure(1)
#plt.imshow(smarties,'gray')
#plt.title('smarties en niveau de gris')
#plt.show()

[ret,thresh]= cv2.threshold(smarties,250 , 255, cv2.THRESH_BINARY_INV)
#plt.figure(2)
#plt.imshow(thresh,'gray')
#plt.show()

S = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(6,4))
dist=cv2.distanceTransform(thresh,cv2.DIST_L2,3)


smartieserode=cv2.erode(dist, S, iterations = 6)
distinv = abs(255-dist*255/np.max(dist))
#plt.figure(3)
#plt.imshow(distinv,'gray')
#plt.show()

[num_labels, labels]=cv2.connectedComponents(smartieserode.astype(np.uint8))
print("Il y a "  + str (num_labels-1) + " smarties")
marq=abs(255-smartieserode)
[retmar,marqueurs]= cv2.threshold(marq, 254, 255, cv2.THRESH_BINARY)
smartiesmarques=np.multiply(distinv,thresh)
#plt.figure(4)
#plt.imshow(smartiesmarques,'gray')
#plt.show()

n = len(smartiesmarques)
p = len(smartiesmarques[1])

FAH_x = [[]]*256
FAH_y = [[]]*256

niv_act = 0
while FAH_x != [[]]*256:
    Jeton = smartiesmarques(FAH_x[0][0].pop,FAH_y[0][0].pop)
    New_Jetons = [Jeton[0]+1,Jeton[1], Jeton[0]-1,Jeton[1],Jeton[0],Jeton[1]+1, Jeton[0],Jeton[1]-1]
    for i in range(3,-1):
        Jeton_encours = New_Jetons.pop()
        if Jeton_encours != 0:
            label = smartiesmarques[Jeton_encours[1]][Jeton_encours[0]]
            if niv_act > FAH_x[0][0]:
                FAH_x(0).append(Jeton_encours[1])
                FAH_y(0).append(Jeton_encours[0])
            else :
                FAH_x(label-niv_act).append(Jeton_encours[1])
                FAH_y(label-niv_act).append(Jeton_encours[0])
    niv_act =+ 1