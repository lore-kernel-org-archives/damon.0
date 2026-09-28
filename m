Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110A3546F9
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583353; cv=none; b=G52LzcBoIqRunbzEAERrZscctxNlXLrZ/fb0UdGzqSetVqV96X4yDT0zS73fsc4gKyMIgjbWo5UDEulOrxz2TIJ3qox/NrM37fTmFMI5AMYXZUowilOmzdWdQdctIRvF0CgbOEciFKQgpCGwcZ8q6aaA6ZF8sRsyyoyJabCm538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583353; c=relaxed/simple;
	bh=MpQRP2MSUPKM0JzTG5SB+fpD2u+J8qqurD6HbvE1LKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ew+Y/fukIfsyo6dI24n+y77OQa37gEwsQXuRimJ5KqvJE3cHqkXjoqvmx143GdObtfOzQ/Fb+gZ6iMHQtCfnbhHn+pI7RlIHMAjsxk/ET1E7w4iHKvvGeN6pmrK5Js5FtjZ0CvqgHdyRo/foaBPAFcU/oiYbUlZX+Rft3/3e7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMauDuc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMauDuc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2861F000FF;
	Mon, 28 Sep 2026 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790583351;
	bh=Y0xTR4/B1Vgjo13lJMkEJzf6Y6GeIR+cKhxGpeGKfq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMauDuc3a1Z4Ul2D5+0jHwQephVc36ffEBvW005WMRtDG+pZdIbhVURcnkSgswQcl
	 izmyxUi6Xmk3Qv/qlO4S/+RS9DC39amMI3kMEWnTC3tD738FvT2no1YDhRV9QUlwmd
	 /OuH8affQDupJpQSAf5JtC/eEgBffpRkDcIinu+iHzLPi9XL5G0G7xa5UUCqtBbsGZ
	 UswkEWL2u4bTFP2LVRcMmxPohGhwk/sHLUGFazdlxLTpHMQaor2k1qNjclCZhks9RF
	 cHgvDEspjs4HTK+aGClFPiE9+z3wMqi4Hyl1OYpr7yOD0KKD9e88t3R2PzSX2bz/yx
	 y59YdFxW8e75w==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Mon, 28 Sep 2026 01:15:46 -0700
Message-ID: <20260928081546.39695-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjp5F8ZuPG1gEsD_Wgs7Z+GToz67nzjr0490sz9y328=dg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Anton,

On Sun, 27 Sep 2026 20:26:21 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> Hello
> 
> I would like to play with memory tiering with DAMON/DAMOS auto-tuning
> (between numa nodes 0 & 2) based on valkey and memtier_benchmark.

Thank you for sharing your use case and question!

> The goal - keep numa node 0 50% free and promote cold pages from numa
> node 2 to numa node 0 immediately when they become hot.
> This is Fedora Server 44 up-to-date with the 7.2.8 kernel.
> 
> [root@localhost ~]# numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
> 22 23 24 25 26 27
> node 0 size: 386590 MB
> node 0 free: 337165 MB
> node 1 cpus: 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
> 47 48 49 50 51 52 53 54 55
> node 1 size: 387055 MB
> node 1 free: 338204 MB
> node 2 cpus:
> node 2 size: 3033088 MB
> node 2 free: 3032998 MB
> node 3 cpus:
> node 3 size: 3033088 MB
> node 3 free: 3032998 MB
> node distances:
> node     0    1    2    3
>    0:   10   20   25   35
>    1:   20   10   35   25
>    2:   25   35   10   20
>    3:   35   25   20   10
> [root@localhost ~]#
> [root@localhost ~]# /home/anton/Linux/mlc
> Intel(R) Memory Latency Checker - v3.13
> Measuring idle latencies for sequential access (in ns)...
>                 Numa node
> Numa node            0       1       2       3
>        0          82.3   147.6   173.8   238.0
>        1         146.7    82.0   238.7   172.2
> 
> 
> The Goal:
> 
> 1. There are two tiers, fast tier - numa node 0; slow tier - numa node 2
> 2. Keep fast tier 50% free
> 3. Demote valkey inactive >=5 min pages from fast to slow tier
> 4. Promote valkey hot pages from slow tier to fast tier immediately
> when accessed
> 5. Demote and Promote bandwidth performance limit up to 8 GB/s; CPU
> performance unlimited
> 6. Monitoring intervals for Demote/Promote 500ms
> 
> What I already done -
> 
> Launch Valkey Pinned to Node 0 DRAM
> 
> numactl --cpunodebind=0 --preferred=0 valkey-server \
>   --port 6379 \
>   --protected-mode no \
>   --save "" \
>   --appendonly no \
>   --maxmemory 300gb \
>   --maxmemory-policy noeviction &
> 
> 
> Command to Load ~200+ GB
> 
> memtier_benchmark \
>   -s 127.0.0.1 -p 6379 \
>   -t 16 -c 16 \
>   -d 10240 \
>   --ratio=1:0 \
>   --key-pattern=P:P \
>   --distinct-client-seed \
>   --key-maximum=20000000 \
>   --pipeline=32 \
>   -n allkeys
> 
> 
> [root@localhost anton]# numastat -p $(pgrep valkey-server)
> 
> Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Huge                         0.00            0.00            0.00
> Heap                         0.11            0.00            0.00
> Stack                        0.03            0.00            0.00
> Private                 238356.61            0.46            4.82
> ----------------  --------------- --------------- ---------------
> Total                   238356.75            0.46            4.82
> 
>                            Node 3           Total
>                   --------------- ---------------
> Huge                         0.00            0.00
> Heap                         0.00            0.11
> Stack                        0.00            0.03
> Private                      0.00       238361.90
> ----------------  --------------- ---------------
> Total                        0.00       238362.04
> 
> 
> damo start \--numa_node 0 --monitoring_intervals_goal 97% 3 5ms 10s

The example memory tiering script [1] uses 4% as intervals goal.  Is there a
reason to use 97% as the goal instead?

> \--damos_action migrate_cold 2 --damos_access_rate 0% 0%
> \--damos_apply_interval 1s \--damos_quota_interval 1s
> --damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
> \--damos_filter reject young \

You mentioned you want to demote >=5 minutes inactive pages.  But, the above
command doesn't have '--damos_age' option.  It means DAMON will demote node 0
pages as soon as it finds it was not accessed, even if it was not accessed for
<5 minutes.  You could let DAMON know you want to demote only >=5 minutes
inactive pages by adding '--damos_age 5m max' option.

> --numa_node 2
> --monitoring_intervals_goal 97% 3 5ms 10s \--damos_action migrate_hot

Again, I'm curious why you use 97% goal.

> 0 --damos_access_rate 5% max \--damos_apply_interval 1s
> \--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
> node_mem_used_bp 99.7% 0 \--damos_filter allow young

Is the above node_mum_used_bp what you really want?  That means you want to
promote hot pages from node 2 to node 0, until the node 0 memory utilization
becomes 99.7%.  That overlaps with the demotion goal (50% free memory of node
0) quite a lot.  I'd suggest smaller overlap, say, 50.3%, to keep healthy
circulation of hot/cold pages while not consuming too much resource under
stabilized access pattern.

> \--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
> --nr_schemes 1 1 --nr_ctxs 1 1
> 
> And it is demoted much more, almost all pages than the goal of 50%
> free numa node 0.
> 
> [root@localhost anton]# numastat -p $(pgrep valkey-server)
> 
> Per-node process memory usage (in MBs) for PID 5631 (valkey-server)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Huge                         0.00            0.00            0.00
> Heap                         0.02            0.00            0.09
> Stack                        0.02            0.00            0.01
> Private                  24389.88            0.46       213971.55
> ----------------  --------------- --------------- ---------------
> Total                    24389.92            0.46       213971.65
> 
>                            Node 3           Total
>                   --------------- ---------------
> Huge                         0.00            0.00
> Heap                         0.00            0.11
> Stack                        0.00            0.03
> Private                      0.00       238361.90
> ----------------  --------------- ---------------
> Total                        0.00       238362.04
> 
> I just want that demotion process to stop when there is 50% free at numa node 0.
> 
> Where am I wrong, how to fix that ?

DAMOS quota auto-tuning supports two tuner algorithms [2], consistent and
temporal.  As the documentation [2] explains, 'consistent' tuner assumes it
should keep applying the action in a level to keep the goal achieved.  In this
case, for example, the demotion scheme assumes there will be continued
promotion and therefore it keeps demoting.  If there is no appropriate
promotion, it could result in demoting more than expected amount.

To me, this seems like the workload has no much hot data, so demotion is much
more stronger.

For path forward, I'd suggest trying 'temporal' tuner [2].  It is designed to
immediately stop after achieving the goal.

If it still doesn't work, I'd suggest tracing damon:damos_esz tracepoint with
the numastat output.  It will show if the autotune is working as expected.

For long term production use case, I'd like to suggest running the example
tiering config [1] and see if it also gives you unexpected results.

[1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
[2] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning


Thanks,
SJ

[...]
