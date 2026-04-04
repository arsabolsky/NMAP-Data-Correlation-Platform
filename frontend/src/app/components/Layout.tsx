import { Outlet } from "react-router";
import { Building2, MapPin } from "lucide-react";
import { useEffect, useState } from "react";

export function Layout() {
  const [companies, setCompanies] = useState<any[]>([]);
  const [selectedIndex, setSelectedIndex] = useState(0);

  useEffect(() => {
    fetch("http://localhost:3000/companies_and_locations")
      .then(res => res.json())
      .then(data => {
        setCompanies(data);
        setSelectedIndex(0); // default to first
      });
  }, []);

  const company = companies[selectedIndex];

  return (
    <div className="min-h-screen bg-neutral-50">
      <header className="bg-white border-b border-neutral-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-start justify-between">
          
          {/* Title */}
          <div>
            <h1 className="text-xl font-semibold text-neutral-900">
              NMAP Data Correlation System
            </h1>
            <p className="text-sm text-neutral-600 mt-1">
              Network Inventory & Security Analysis
            </p>
          </div>

          {/* Dropdown + Info */}
          <div className="flex flex-col items-end gap-2">

            {/* SIMPLE DROPDOWN */}
            <select
              className="border rounded px-2 py-1 text-sm"
              value={selectedIndex}
              onChange={(e) => setSelectedIndex(Number(e.target.value))}
            >
              {companies.map((c, index) => (
                <option key={index} value={index}>
                  {c.companyname}
                </option>
              ))}
            </select>

            {/* Selected Company Info */}
            {company && (
              <>
                <div className="flex items-center gap-2 text-sm font-medium text-neutral-900">
                  <Building2 className="h-4 w-4 text-neutral-600" />
                  {company.companyname}
                </div>
                <div className="flex items-center gap-2 text-sm text-neutral-600">
                  <MapPin className="h-4 w-4" />
                  {company.address}
                </div>
              </>
            )}

          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-8">
        <Outlet />
      </main>
    </div>
  );
}