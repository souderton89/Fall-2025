param(
    [Parameter(Mandatory=$true)][string]$prefix,   # e.g. 192.168.3
    [Parameter(Mandatory=$true)][string]$dns       # e.g. 192.168.4.5
)

Write-Output "DNS resolution for $prefix.0/24 using DNS server $dns"

for ($i = 1; $i -le 254; $i++) {
    $ip = "$prefix.$i"
    try {
        # Expand the NameHost property into plain strings
        $ptrs = Resolve-DnsName -DnsOnly -Type PTR -Name $ip -Server $dns -ErrorAction Stop `
                | Select-Object -ExpandProperty NameHost -ErrorAction SilentlyContinue

        if ($ptrs) {
            # ensure each entry is a string, then join multiple entries (if any)
            $names = ($ptrs | ForEach-Object { [string]$_ }) -join ", "
            Write-Output "$ip`t$names"
        }
    }
    catch {
        # no PTR or lookup failed - ignore silently
    }
}

