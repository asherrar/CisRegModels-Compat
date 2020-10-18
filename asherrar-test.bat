#!/bin/bash
set -e #make it so that the script exits completely if one command fails
echo "############################################"
echo "Creating One-Hot representation of sequences"
echo "############################################"
seqsToOHC.py -i asherrar-test/HighQuality.pTpA.Glu.test.txt.gz -m 110 -o asherrar-test/HighQuality.pTpA.Glu.test.OHC.gz

echo "############################################"
echo "learning model from known motifs, holding concentrations and motifs static"
echo "############################################"
makeThermodynamicEnhancosomeModel.py -i asherrar-test/HighQuality.pTpA.Glu.test.OHC.gz  -o asherrar-test/test.model.AP -eb -sl 110 -nm 250 -ml 30  -b 128 -v -v -v -se 100000 -dm asherrar-test/allTF_PKdMFiles_polyA_and_FZF1.txt  -ic asherrar-test/allTF_minKds_polyA_and_FZF1.txt -po -lr 0.04 -ntm -ntc -r 20 -ia 0.01 -ip 0.01

echo "############################################"
echo "now learning additional parameters: concentration and motif"
echo "############################################"
makeThermodynamicEnhancosomeModel.py -i asherrar-test/HighQuality.pTpA.Glu.test.OHC.gz  -o asherrar-test/test.model.APCM -eb -sl 110 -nm 250 -ml 30  -b 128 -v -v -v -se 100000 -dm asherrar-test/allTF_PKdMFiles_polyA_and_FZF1.txt  -ic asherrar-test/allTF_minKds_polyA_and_FZF1.txt -po -lr 0.001  -r 20 -ia 0.01 -ip 0.01 -res asherrar-test/test.model.AP.ckpt
