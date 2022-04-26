QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = ESX.GetConfig().duty -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = ESX.Jobs