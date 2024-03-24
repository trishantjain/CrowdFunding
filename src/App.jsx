// import { ConnectWallet } from "@thirdweb-dev/react";
import React from 'react';
import { Route, Routes } from 'react-router-dom'
// import "./styles/Home.css";


import { Sidebar, Navbar } from './components';
import { CreateCampaign, CampaignDetails, Home, Profile } from './pages';

export default function App() {
  return (
    <div className="relative sm:-8 p-4 bg-[#13131a] min-h-screen flex flex-row">
      <div className='sm:flex hidden mr-10 relative'><Sidebar /></div>

      <div className="flex-1 max-sm:w-full max:w-[1200px] mx-auto s:pr-5"><Navbar />

        <Routes>
          <Route path='/' element={<Home />}></Route>
        </Routes>
      </div>
    </div>
  );
}
