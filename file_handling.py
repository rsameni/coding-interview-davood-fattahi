"""
Created on Fri Nov 18 14:36:51 2022
As a part of coding interview, post doc application, Emory Univ
@author: Davood
"""
    
    
    
if __name__ == '__main__':
    import hashlib
    import os
    import time
    import pandas as pd
    import numpy as np
    import wfdb
#    import pickle
 
    
    DIR="training2017/A00/"
    df = pd.DataFrame()
    id=0
    readable_hash=[]
    path_info=[]
    file_size=[]
    m_time=[]
    c_time=[]
    samp_rate=[]
    for record in os.listdir(DIR):
        if record.endswith(".mat"):
#            id +=1
#            print(id)
            path_name="./"+DIR + record
            path_info.append(path_name)
            file_size.append(os.path.getsize(path_name))
            m_time.append(time.strftime("%Y%m%d",time.strptime(time.ctime(os.path.getmtime(path_name)))))
            c_time.append(time.strftime("%Y%m%d%H%M%S",time.strptime(time.ctime(os.path.getctime(path_name)))))
            with open(path_name,"rb") as f:
                bytes = f.read()
                readable_hash.append(hashlib.md5(bytes).hexdigest())
        if record.endswith(".hea"):
            path_name=DIR + record[:-4]
            h=wfdb.rdheader(path_name, pn_dir=None, rd_segments=False)
            samp_rate.append(h.fs)    
                
 
    recordsInfo = pd.DataFrame(np.transpose([path_info,readable_hash, file_size, c_time, m_time, samp_rate]),   columns=['path and name', 'MD5 hash', 'size', 'creation time', 'modification time', 'sampling rate']) 
    recordsInfo.to_csv('recordsInfo.csv', float_format='%f',  index = False)
    
# =============================================================================
#     f = open('GenericFeatures.pkl', 'wb')
#     pickle.dump(features, f, -1)
#     f.close()   
# 
# =============================================================================



