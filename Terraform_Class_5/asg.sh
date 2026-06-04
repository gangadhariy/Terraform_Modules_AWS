#!/bin/bash

apt update -y
apt install nginx curl -y
systemctl enable nginx
systemctl start nginx

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600" -s)

PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
-s http://169.254.169.254/latest/meta-data/local-ipv4)

PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
-s http://169.254.169.254/latest/meta-data/public-ipv4)

sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>AWS Auto Scaling Dashboard</title>

<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,sans-serif;
}

body{
background:linear-gradient(-45deg,#020617,#0f172a,#1e293b,#0ea5e9);
background-size:400% 400%;
animation:bg 15s ease infinite;
color:white;
overflow-x:hidden;
perspective:1400px;
}

@keyframes bg{
0%{background-position:0% 50%;}
50%{background-position:100% 50%;}
100%{background-position:0% 50%;}
}

.container{
padding:50px;
text-align:center;
}

h1{
font-size:58px;
margin-bottom:35px;
text-shadow:
0 0 10px cyan,
0 0 20px cyan,
0 0 40px #38bdf8;
animation:pulse 2s infinite alternate;
transform:translateZ(50px);
}

@keyframes pulse{
from{transform:scale(1);}
to{transform:scale(1.05);}
}

.host{
padding:30px;
font-size:28px;
border-radius:25px;
margin-bottom:40px;
background:rgba(255,255,255,0.08);
backdrop-filter:blur(18px);
box-shadow:0 0 35px rgba(0,255,255,.35);
animation:float 4s ease-in-out infinite;
}

@keyframes float{
0%,100%{transform:translateY(0);}
50%{transform:translateY(-14px);}
}

.grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
gap:30px;
}

.card{
padding:30px;
border-radius:24px;
background:rgba(255,255,255,.08);
backdrop-filter:blur(18px);
transform-style:preserve-3d;
transition:.6s;
box-shadow:0 15px 35px rgba(0,0,0,.35);
animation:float 5s ease-in-out infinite;
}

.card:hover{
transform:
rotateY(18deg)
rotateX(10deg)
scale(1.08)
translateZ(35px);

box-shadow:0 0 45px cyan;
}

.card h2{
font-size:24px;
margin-bottom:18px;
color:#7dd3fc;
text-shadow:0 0 12px cyan;
}

.card p{
font-size:17px;
line-height:1.7;
}

.footer{
margin-top:55px;
font-size:20px;
opacity:.85;
}
</style>
</head>

<body>

<div class="container">

<h1>AWS AUTO SCALING DASHBOARD</h1>

<div class="host">
Our ASG Host is <b>$PRIVATE_IP</b><br><br>
Public Access: <b>$PUBLIC_IP</b>
</div>

<div class="grid">

<div class="card">
<h2>⚡ Auto Scaling Group</h2>
<p>Automatically launches and terminates EC2 instances based on traffic demand and system health.</p>
</div>

<div class="card">
<h2>🎯 Target Group</h2>
<p>Routes traffic only to healthy registered EC2 instances behind the Application Load Balancer.</p>
</div>

<div class="card">
<h2>📦 Launch Template</h2>
<p>Stores AMI, instance type, security groups, storage, and bootstrap automation script.</p>
</div>

<div class="card">
<h2>📈 Dynamic Scaling</h2>
<p>Monitors CPU metrics from CloudWatch and automatically scales out/in within min and max limits.</p>
</div>

<div class="card">
<h2>🛠 Health Checks</h2>
<p>Unhealthy instances are replaced automatically to maintain desired application availability.</p>
</div>

<div class="card">
<h2>🚀 Production Architecture</h2>
<p>High availability across multiple AZs with self-healing infrastructure and elastic traffic distribution.</p>
</div>

</div>

<div class="footer">
Powered by AWS + NGINX + EC2 Metadata + Auto Scaling
</div>

</div>

</body>
</html>
EOF

sudo systemctl restart nginx