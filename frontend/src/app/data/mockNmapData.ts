export interface NmapResult {
  id: string;
  dateTime: string;
  ipAddress: string;
  operatingSystem: string;
  openPorts: string;
  hostname?: string;
}

export const mockNmapData: NmapResult[] = [
  {
    id: "NMAP-001",
    dateTime: "2026-03-11 08:15:23",
    ipAddress: "192.168.1.10",
    operatingSystem: "Windows 10 Professional",
    openPorts: "80, 443, 3389, 5985",
    hostname: "WKS-FINANCE-01"
  },
  {
    id: "NMAP-002",
    dateTime: "2026-03-11 08:16:45",
    ipAddress: "192.168.1.15",
    operatingSystem: "Ubuntu Linux 22.04",
    openPorts: "22, 80, 443",
    hostname: "SRV-WEB-PROD"
  },
  {
    id: "NMAP-003",
    dateTime: "2026-03-11 08:18:12",
    ipAddress: "192.168.1.20",
    operatingSystem: "macOS Ventura 13.2",
    openPorts: "22, 445, 548",
    hostname: "MAC-DESIGN-03"
  },
  {
    id: "NMAP-004",
    dateTime: "2026-03-11 08:20:33",
    ipAddress: "192.168.1.25",
    operatingSystem: "Windows Server 2022",
    openPorts: "53, 88, 135, 389, 445, 636, 3389",
    hostname: "DC-PRIMARY-01"
  },
  {
    id: "NMAP-005",
    dateTime: "2026-03-11 08:22:01",
    ipAddress: "192.168.1.30",
    operatingSystem: "CentOS 8",
    openPorts: "22, 3306, 8080",
    hostname: "DB-MYSQL-01"
  },
  {
    id: "NMAP-006",
    dateTime: "2026-03-11 09:05:44",
    ipAddress: "192.168.1.35",
    operatingSystem: "Debian 11",
    openPorts: "22, 25, 587, 993",
    hostname: "MAIL-SERVER-01"
  },
  {
    id: "NMAP-007",
    dateTime: "2026-03-11 09:12:18",
    ipAddress: "192.168.1.40",
    operatingSystem: "Windows 10 Home",
    openPorts: "135, 139, 445",
    hostname: "WKS-SUPPORT-02"
  },
  {
    id: "NMAP-008",
    dateTime: "2026-03-11 09:25:55",
    ipAddress: "192.168.1.45",
    operatingSystem: "Red Hat Enterprise Linux 9",
    openPorts: "22, 80, 443, 8443",
    hostname: "APP-SERVER-01"
  },
  {
    id: "NMAP-009",
    dateTime: "2026-03-11 10:08:22",
    ipAddress: "192.168.1.50",
    operatingSystem: "FreeBSD 13.1",
    openPorts: "22, 53, 123",
    hostname: "DNS-SECONDARY"
  },
  {
    id: "NMAP-010",
    dateTime: "2026-03-11 10:15:37",
    ipAddress: "192.168.1.55",
    operatingSystem: "iOS 16.3",
    openPorts: "62078",
    hostname: "iPhone-Executive"
  },
  {
    id: "NMAP-011",
    dateTime: "2026-03-10 14:22:11",
    ipAddress: "192.168.1.60",
    operatingSystem: "Android 13",
    openPorts: "5555",
    hostname: "Galaxy-S23-Dev"
  },
  {
    id: "NMAP-012",
    dateTime: "2026-03-10 14:45:33",
    ipAddress: "192.168.1.65",
    operatingSystem: "Ubuntu Linux 20.04",
    openPorts: "22, 443, 5432",
    hostname: "DB-POSTGRES-01"
  },
  {
    id: "NMAP-013",
    dateTime: "2026-03-10 15:10:08",
    ipAddress: "192.168.1.70",
    operatingSystem: "Windows 11 Pro",
    openPorts: "80, 443, 3389",
    hostname: "WKS-DEV-05"
  },
  {
    id: "NMAP-014",
    dateTime: "2026-03-10 16:33:29",
    ipAddress: "192.168.1.75",
    operatingSystem: "Fedora 37",
    openPorts: "22, 80, 8080",
    hostname: "TEST-SERVER-02"
  },
  {
    id: "NMAP-015",
    dateTime: "2026-03-09 11:20:45",
    ipAddress: "192.168.1.80",
    operatingSystem: "Windows Server 2019",
    openPorts: "135, 445, 3389, 5985, 5986",
    hostname: "FILE-SERVER-01"
  },
  {
    id: "NMAP-016",
    dateTime: "2026-03-09 11:55:12",
    ipAddress: "192.168.1.85",
    operatingSystem: "macOS Monterey 12.6",
    openPorts: "22, 88, 548",
    hostname: "MAC-ADMIN-01"
  },
  {
    id: "NMAP-017",
    dateTime: "2026-03-09 13:08:33",
    ipAddress: "192.168.1.90",
    operatingSystem: "Arch Linux",
    openPorts: "22, 80, 443",
    hostname: "NGINX-PROXY-01"
  },
  {
    id: "NMAP-018",
    dateTime: "2026-03-09 14:25:19",
    ipAddress: "192.168.1.95",
    operatingSystem: "Kali Linux 2023.1",
    openPorts: "22",
    hostname: "SEC-AUDIT-TOOL"
  },
  {
    id: "NMAP-019",
    dateTime: "2026-03-08 09:40:02",
    ipAddress: "192.168.1.100",
    operatingSystem: "pfSense 2.7.0",
    openPorts: "22, 80, 443",
    hostname: "FIREWALL-01"
  },
  {
    id: "NMAP-020",
    dateTime: "2026-03-08 10:12:44",
    ipAddress: "192.168.1.105",
    operatingSystem: "ESXi 7.0",
    openPorts: "22, 80, 443, 902, 5989",
    hostname: "HYPERVISOR-01"
  }
];
