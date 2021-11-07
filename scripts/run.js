const main = async () => {
 
  const waveContractFactory = await hre.ethers.getContractFactory('WavePortal')
  const waveContract = await waveContractFactory.deploy()
  await waveContract.deployed()
  console.log('Contract deployed to:', waveContract.address)

  let waveCount
  waveCount = await waveContract.getTotalWaves()
  console.log(waveCount.toNumber())

  //  --- Send Waves ---//
  let waveTxn = await waveContract.wave('Hi Aaron', 'Monica')
  await waveTxn.wait() // wait on the miners
  waveCount = await waveContract.getTotalWaves()
  console.log(waveCount.toNumber())

  const [_, randomPerson] = await hre.ethers.getSigners()
  waveTxn = await waveContract.connect(randomPerson).wave(' Was up from the blockchain', 'Chandler')
  await waveTxn.wait()

  let allWaves = await waveContract.getAllWaves()
  console.log(allWaves)

  
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}

runMain()
