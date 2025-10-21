return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {
        {
            name = 'iwhalecloud',
            username = '0027026800',
            remote_address = '10.20.50.1',
            ssh_option = {
                HostKeyAlgorithms = '+ssh-dss'
            },
        }
    },
}
