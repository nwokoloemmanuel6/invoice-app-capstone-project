#!/usr/bin/env node

import axios from 'axios';

axios.get('http://localhost:5000/health-check')
  .then(response => {
    if (response.status === 200) {
      console.log("[OK] server is running");
      process.exit(0); // success
    } else {
      console.log("[BAD]  server is not running");
      process.exit(1); // failure
    }
  })
  .catch(error => {
    console.error(error.message);
    process.exit(1); // failure
  });
