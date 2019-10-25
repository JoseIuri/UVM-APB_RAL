class apb_agent extends uvm_agent;
   `uvm_component_utils (apb_agent)

   uvm_analysis_port #(apb_tr) ag_ap;

   apb_driver                  m_drvr;
   apb_monitor                 m_mon;
   reg2apb_adapter             reg2apb;
   uvm_sequencer #(apb_tr)     m_seqr; 
   
   function new (string name="apb_agent", uvm_component parent);
      super.new (name, parent);
      ag_ap = new("ag_ap", this);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      m_drvr = apb_driver::type_id::create ("m_drvr", this);
      m_seqr = uvm_sequencer#(apb_tr)::type_id::create ("m_seqr", this);
      m_mon = apb_monitor::type_id::create ("m_mon", this);
      reg2apb = reg2apb_adapter::type_id::create("reg2apb", this);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      m_drvr.seq_item_port.connect(m_seqr.seq_item_export);
      m_mon.mon_ap.connect(ag_ap);
   endfunction
endclass