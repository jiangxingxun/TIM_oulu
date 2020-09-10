import glob
import numpy as np
import pandas as pd
import shutil
import pdb

if __name__ == "__main__":
    clips_path = []
    folds = glob.glob("./TIM_224by224/*")
    folds.sort()
    for index_fold in range(len(folds)):
        clips_full_pth = glob.glob(folds[index_fold]+"/*")
        clips_full_pth.sort()
        len_clips      = len(clips_full_pth)
        clips_full_pth = [ele[15:] for ele in clips_full_pth]
        clips_path     = clips_path + clips_full_pth
    
    for index_clips in range(len(clips_path)):
        source_address = "./TIM_224by224/"+clips_path[index_clips]
        index          = "%05d"%(index_clips+1)
        dist_address   = "./TIM_224by224_need/"+index
        shutil.copytree(source_address, dist_address)
 

    #clips_path = np.array(clips_path)
    #lables     = np.array(labels)
    #output     = np.array([clips_path, labels])
    #output     = output.T
    #df         = pd.DataFrame(output, columns=['data','labels','train_flag'])
    #df.to_csv('./UCF101.csv')
 
    
    


