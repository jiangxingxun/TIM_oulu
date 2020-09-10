import glob
import numpy as np
import pandas as pd
import pdb

if __name__ == "__main__":
    clips_path, labels = [], []
    folds = glob.glob("./TIM_224by224/*")
    folds.sort()
    for index_fold in range(len(folds)):
        clips_full_pth = glob.glob(folds[index_fold]+"/*")
        clips_full_pth.sort()
        len_clips      = len(clips_full_pth)
        clips_full_pth = [ele[15:] for ele in clips_full_pth]
        clips_path     = clips_path + clips_full_pth
        labels         = labels + [index_fold+1]*len_clips
    
    with open("./ucfTrainTestlist/testlist01.txt", "r") as f:
        test_01 = f.readlines()
    test_01 = [ele[:-5] for ele in test_01]
    train_flag = [1]*len(clips_path)
    for index_clip in range(len(clips_path)):
        if clips_path[index_clip] in test_01:
            train_flag[index_clip] = 0


    clips_path = np.array(clips_path)
    lables     = np.array(labels)
    train_flag = np.array(train_flag)
    output     = np.array([clips_path, labels, train_flag])
    output     = output.T
    df         = pd.DataFrame(output, columns=['data','labels','train_flag'])
    df.to_csv('./UCF101.csv')
 
    
    


