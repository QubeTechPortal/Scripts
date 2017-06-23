import xlrd

def subnetCalculation(subnets):
    host = 32 - int(subnets)
    hostDevices = 2 ** host
    return hostDevices - 1


def twoPower(subnets):
    return ((2 ** subnets) - 1)


def xmlFileCreation(fromList,toList,descriptionList):

        f= open("Gurgoan.xml","w+")

        xmlContent ="""<?xml version="1.0" encoding="utf-16"?>
        <AddressGroups xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns="http://tempuri.org/IPAddressGroupsSchema.xsd">\n"""

        for i in range(len(fromList)):
            xmlContent += """
        <AddressGroup enabled="true" description=\"""" + descriptionList[i] + """\">
            <Range from=\"""" + fromList[i] + """\" to=\"""" + toList[i] + """\"/>
        </AddressGroup>\n"""

        f.write(xmlContent)



workbook = xlrd.open_workbook('All location ips.xls', on_demand = True)
worksheet = workbook.sheet_by_name('Gurgoan')

descriptionList = list()
fromList = list()
toList = list()

for row in range(2, worksheet.nrows):
    ip_name = worksheet.cell(row,0).value
    location = worksheet.cell(row,2).value

    description = str(ip_name + " - " + location)
    ip = str(worksheet.cell(row,1).value)
    network = ""
    i = 0


    while(ip[i] != '/'):
        network += ip[i]
        i += 1
    i += 1
    subnets = ip[i:]

    fromIp = network

    if int(subnets) < 24:

        toRange = twoPower(24 - int(subnets))
        dots = i = 0
        twoOctets = ""

        while (dots != 2):
            if  network[i] == '.':
                dots += 1
            twoOctets += network[i]
            i += 1

        thirdOctet = ""
        dots = 0
        while(dots != 1):
            thirdOctet += network[i]
            i += 1
            if network[i] == '.':
                dots += 1
        toIp = twoOctets + str(int(thirdOctet) + toRange) + "." + "255"

        fromList.append(fromIp)
        toList.append(toIp)
        descriptionList.append(description)


    else:

        toRange = subnetCalculation(subnets)

        dots = i = 0
        threeOctets = ""

        while (dots != 3):
            if  network[i] == '.':
                dots += 1
            threeOctets += network[i]
            i += 1

        threeOctets = threeOctets[:len(threeOctets) - 1]
        toIp = threeOctets + "." + str(toRange)


        descriptionList.append(description)
        fromList.append(fromIp)
        toList.append(toIp)

xmlFileCreation(fromList, toList, descriptionList)
