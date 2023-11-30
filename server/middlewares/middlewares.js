const cache = {};

const caching = (req, res, next) => {
  const key = `${req.method}_${req.url}`;

  if (req.method !== 'GET') {
    // Jangan cache permintaan yang bukan metode GET
    return next();
  }

  if (cache[key]) {
    return res.status(200).send(cache[key]);
  }

  res.sendResponse = res.send;
  res.send = (body) => {
    cache[key] = body;
    res.sendResponse(body);
  };

  next();
};

module.exports = {
  caching,
};
