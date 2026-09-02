gitlab_rails["gitlab_shell_ssh_port"] = 2424
external_url "http://gitlab.blackbox.lab.p-exe.com"

# Trafik handles TLS, so leave it off here
letsencrypt["enable"] = false
nginx["listen_port"] = 80
nginx["listen_https"] = false

# Performance optimizations for small deployments
# These settings reduce resource usage but can lead to worse performance under high load
postgresql['shared_buffers'] = '256MB'
sidekiq['max_concurrency'] = 4
sidekiq['concurrency'] = 1
puma['worker_timeout'] = 120
puma['worker_processes'] = 1
# Disable prometheus for more performance at the cost of disabling monitoring
prometheus_monitoring['enable'] = true