import { Outlet } from "react-router";
import { Building2, MapPin } from "lucide-react";
import { useEffect, useState } from "react";
export function Layout() {
  // These would typically come from user authentication/context
  const [company, setCompany] = useState(null);

  useEffect(() => {
    fetch("http://localhost:3000/companies_and_locations")
      .then(res => res.json())
      .then(data => {
        setCompany(data[0]); 
      });
  }, []);

  return (
    <div className="min-h-screen bg-neutral-50">
      <header className="bg-white border-b border-neutral-200 px-6 py-4">
        <div className="max-w-7xl mx-auto flex items-start justify-between">
          <div>
            <h1 className="text-xl font-semibold text-neutral-900">NMAP Data Correlation System</h1>
            <p className="text-sm text-neutral-600 mt-1">Network Inventory & Security Analysis</p>
          </div>
          <div className="flex flex-col items-end gap-1">
            <div className="flex items-center gap-2 text-sm font-medium text-neutral-900">
              <Building2 className="h-4 w-4 text-neutral-600" />
              {company?.companyname}
            </div>
            <div className="flex items-center gap-2 text-sm text-neutral-600">
              <MapPin className="h-4 w-4" />
              {company?.address}
            </div>
          </div>
        </div>
      </header>
      <main className="max-w-7xl mx-auto px-6 py-8">
        <Outlet />
      </main>
    </div>
  );
}