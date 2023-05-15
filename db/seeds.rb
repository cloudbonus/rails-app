NetworkDevice.create([{
                       name: 'Xiaomi Mi router 4a',
                       d_type: 'router',
                       ports: 2,
                       bandwidth: 1000,
                       price: 118.79,
                       sfp: 0,
                       sfp_plus: 0
                     },
                      {
                        name: 'D-Link DIR-825',
                        d_type: 'router',
                        ports: 4,
                        bandwidth: 10_000,
                        price: 280,
                        sfp: 1,
                        sfp_plus: 0
                      },
                      {
                        name: 'Huawei HG232f',
                        d_type: 'router',
                        ports: 4,
                        bandwidth: 300,
                        price: 28,
                        sfp: 0,
                        sfp_plus: 0
                      },
                      {
                        name: 'TP-Link Archer C6 V2',
                        d_type: 'router',
                        ports: 4,
                        bandwidth: 1000,
                        price: 124.58,
                        sfp: 0,
                        sfp_plus: 0
                      },
                      {
                        name: 'ASUS RT-AX89X',
                        d_type: 'router',
                        ports: 10,
                        bandwidth: 10_000,
                        price: 1307.03,
                        sfp: 0,
                        sfp_plus: 1
                      },
                      {
                        name: 'TP-Link TL-SF1005D',
                        d_type: 'switch',
                        ports: 5,
                        bandwidth: 100,
                        price: 30.97,
                        sfp: 0,
                        sfp_plus: 0
                      },
                      {
                        name: 'TP-Link TL-SG105E v3',
                        d_type: 'switch',
                        ports: 5,
                        bandwidth: 10_000,
                        price: 73.76,
                        sfp: 0,
                        sfp_plus: 0
                      },
                      {
                        name: 'D-Link DGS-1016D/I2A',
                        d_type: 'switch',
                        ports: 16,
                        bandwidth: 1000,
                        price: 175.79,
                        sfp: 0,
                        sfp_plus: 0
                      },
                      {
                        name: 'TP-Link ER8411',
                        d_type: 'switch',
                        ports: 8,
                        bandwidth: 1000,
                        price: 1872,
                        sfp: 1,
                        sfp_plus: 2
                      },
                      {
                        name: 'D-Link DMC-G01LC/C1A',
                        d_type: 'switch',
                        ports: 1,
                        bandwidth: 1000,
                        price: 69,
                        sfp: 1,
                        sfp_plus: 0
                      },
                      {
                        name: 'Rexant 18-1012 ',
                        d_type: 'cable',
                        ports: 2,
                        bandwidth: 100,
                        price: 26.4,
                        sfp: 1,
                        sfp_plus: 0
                      },
                      {
                        name: '5bites PUT50-200A ',
                        d_type: 'cable',
                        ports: 2,
                        bandwidth: 1000,
                        price: 5.7,
                        sfp: 1,
                        sfp_plus: 0
                      },
                      {
                        name: 'ATcom AT9173',
                        d_type: 'cable',
                        ports: 2,
                        bandwidth: 10_000,
                        price: 17.6,
                        sfp: 1,
                        sfp_plus: 1
                      }])

p "Created #{NetworkDevice.count} Network Devices"
