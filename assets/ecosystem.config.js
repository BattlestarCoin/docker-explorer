module.exports = {
  apps: [
    {
      name: 'explorer',
	  cwd: '/home/iquidus/',
      script: 'rm -f tmp/* && npm start',
      instances: 1,
      exec_mode: 'fork',
      watch: false,
      autorestart: true
    },
    {
      name: 'index update',
	  cwd: '/home/iquidus/',
      script: "node scripts/sync index update",
      instances: 1,
      exec_mode: 'fork',
      exp_backoff_restart_delay: 60000,
      watch: false,
      autorestart: true
    },
    {
      name: 'cron market update',
	  cwd: '/home/iquidus/',
      script: "node scripts/sync market > /dev/null 2>&1",
      instances: 1,
      exec_mode: 'fork',
      cron_restart: "*/2 * * * *",
      watch: false,
      autorestart: false
    },
    {
      name: 'cron peers update',
	  cwd: '/home/iquidus/',
      script: "node scripts/peers > /dev/null 2>&1",
      instances: 1,
      exec_mode: 'fork',
      cron_restart: "*/5 * * * *",
      watch: false,
      autorestart: false
    }
  ]
};