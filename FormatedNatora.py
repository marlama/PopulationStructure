import pandas as pd
import numpy as np

Database=pd.read_csv('Target_ReferenceData_LD0.4.fam', sep=" ", header=None, low_memory=False)
Database2Remove=pd.read_csv('Natora_king_TargetReference_LD0.4_toRemove.txt', sep="\t", header=None, low_memory=False)

column_list=[0, 1]
Database[Database[1].isin(Database2Remove[0])].to_csv("TargetReference_NatoraKing2Remove_LD0.4_Formated.txt", sep="\t", columns = column_list ,index=False)
