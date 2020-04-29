const nodeBlockchainServer = "http://192.168.0.105:8541"
const express = require('express');
const BlockchainService = require("./service/blockchain-service")

var blockchainService = new BlockchainService(nodeBlockchainServer)

const app = express();
const port = process.env.PORT || 5000;

app.get('/api/total-candidatos', async (req, res) => {
  const total = await blockchainService.totalCandidatos();
  res.send({ total });
});

app.get('/api/total-votos-por-candidato/:id', async (req, res) => {
  const total = await blockchainService.totalVotosPorCandidato(req.params.id);
  res.send({ total });
});

app.get('/api/vote/:idpu/:idcandidate/:votes', async (req, res) => {
  console.log(req.params)
  await blockchainService.vote(req.params.idpu, req.params.idcandidate, req.params.votes);
  res.send({ OK : true });
});

app.listen(port, () => console.log(`Listening on port ${port}`));