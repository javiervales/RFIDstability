# Stability of synchronous queued RFID networks

<p align="center">
<img src="https://ieeexplore.ieee.org/ielx7/6287639/8600701/8856209/graphical_abstract/access-gagraphic-2945396.jpg" alt="Graphical abstract" width="600">
</p>

<p>
<b> Published in: IEEE Access vol. 7, October 2019, <a href="https://doi.org/10.1109/ACCESS.2019.2945396"> DOI: 10.1109/ACCESS.2019.2945396 </a> </b> </p>

  
<b> Abstract </b>
<p>
<it>Queued Radio Frequency Identification (RFID) networks arise naturally in many applications, where tags are
grouped into batches, and each batch must be processed before the next reading job starts. In these cases, the
system must be able to handle all incoming jobs, keeping the queue backlogs bounded. This property is called
stability. Besides, in RFID networks, it is common that some readers cannot operate at the same time, due to mutual
interferences. This fact reduces the maximum traffic that readers can process since they have to share the channel.
Synchronous networks share the channel using a TDMA approach. The goal of this work is to analytically determine
whether a synchronous queued RFID network attains stable operation under a given incoming traffic. Stability
depends on the service rate, which is characterized in this paper using an exact numerical method based on a
recursive analytical approach, overcoming the limitations of previous works, which were based on simplifications.
We also address different flow optimization problems, such as computing the maximum joint traffic that a network
can process stably, selecting the minimal number of readers to process a given total load, or determining the
optimal timeslot duration, which are novel in the RFID literature.</it>
</p>


## Paper materials
<ul>
  <li> <b>b.nb</b>: Mathematica notebook for analytical computation of the batch identification procedure (general case)
  <li> <b>bDFSA.nb</b>: Mathematica notebook for analytical computation of the batch identification procedure (Dynamic-FSA case)
  <li> <b>bFSA.m</b>: Matlab script for Monte-Carlo evaluation of the batch identification procedure (Static-FSA case) suitable only for small populations and frame-lenghts
  <li> <b>bDFSA.m</b>: Matlab script for Monte-Carlo evaluation of the batch identification procedure (Dynamic-FSA case) suitable only for small populations and frame-lenghts
  <li> <b>*.zip</b>: precomputed batch identifacation probabilities matrices (analytical)
  <li> <b>*.m</b>: capacity analysis for different scenarios 
</ul>

Feel free to reach out the main author (javier.vales@upct.es).

Please, cite as:

Vales-Alonso, J., López-Matencio, P., Alcaraz, J. J., González-Castaño, F. J. (2019). </it>Stability of synchronous queued RFID networks</it>. <b>IEEE Access</b>, 7, 148828-148842.
