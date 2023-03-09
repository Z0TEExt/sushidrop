const WebSocket = require('ws');

const ws = new WebSocket('http://127.0.0.1/ws');

ws.on('error', console.error);

ws.on('open', function open() {
  ws.send('something');
});

ws.on('message', function message(data) {
  console.log('received: %s', data);
});