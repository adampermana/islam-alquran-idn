const { Router } = require('express');

const { caching } = require('../middlewares/middlewares');
const SurahHandler = require('../handlers/surah');
const JuzHandler = require('../handlers/juz');

const routes = Router();

routes.use((req, res, next) => {
  res.setHeader('Cache-Control', 'public, max-age=0, s-maxage=86400, stale-while-revalidate');
  next();
});

routes.get('/', (req, res) => res.status(200).send({
  surah: {
    listSurah: '/surah',
    spesificSurah: {
      pattern: '/surah/{surah}',
      example: '/surah/18'
    },
    spesificAyahInSurah: {
      pattern: '/surah/{surah}/{ayah}',
      example: '/surah/18/60'
    },
    spesificJuz: {
      pattern: '/juz/{juz}',
      example: '/juz/30'
    }
  },
  maintaner: 'Adam Permana <adampermana111@gmail.com>',
  source: 'https://github.com/adampermana/islam-alquran-idn.git'
}));

routes.get('/surah', caching, SurahHandler.getAllSurah);

routes.get('/surah/:surah', caching, SurahHandler.getSurah);
routes.get('/surah/:surah/:ayah', caching, SurahHandler.getAyahFromSurah);
routes.get('/juz/:juz', caching, JuzHandler.getJuz);

// fallback routes
routes.all('*', (req, res) => res.status(404).send({
  code: 404,
  status: 'Not Found.',
  message: `Resource "${req.url}" is not found.`
}));

module.exports = routes;