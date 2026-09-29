Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B314E77E4
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673946; cv=none; b=LJAAkx4B9feJJWLEEZohTZEN36tX5UzEHOhP/p4YM/6BHxbsdoaNN4IGRueImvYjnjLdxlxGbLyzA+DB4gn7pMwZ+qkkrRIrkkDj4ck1URjtryXoOJdA7Zz/K0dp39MFHJTA6p6AWI0OuSVKVxsodrRHfsG8vFt6mbJBgKuihVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673946; c=relaxed/simple;
	bh=Yg10tulEv1rlSyKRGaIW+tftip1XXeJRAsFQSc6flZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHuKyyV5ZWmO0Kt38SvgpUpKdfHH/Pef2+68PTJvdBVwtxJX8gZ3NYyF8kVuPzYnblbXwQniVSZsf7JaNkGQrET3LXiUG0FgtVKyDu53OQH2XCK1Hp0pUwan6FtEXElR0WKAwUDm/dbgjEmZKzU4+MZvNJUqECpey4HwosfON6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzLofsVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzLofsVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928301F000FF;
	Tue, 29 Sep 2026 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790673937;
	bh=uQuDbPGJRYWS3RKCpW2DuvTsaIMKechb7gtoNSebzzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzLofsVg7EIEOnoMKU2/5NUGY7QNlFZjfT9Vy1NehrpqmgHSEfEvetdPrO6ncMEJL
	 M6pJdoz0+quYt0hrqp2ZtllAA3+jOwzGwhwLaV/t+WEBeU4GLH0xwwrjsvC4oCH61C
	 t8VnqpdJiPMsKwgkCZnjYDtPd8Rrseyl5u3ZD8LtdsWnmowguKTQLoX/U6Zv0VfvCe
	 H2Y2P5GzakyKKe7bl3O63tWpwVDyPGUTNH58sE4kEPqB+miaCO9mI1muFivqtkuH+T
	 u++0G5MbpqWENKQ+npbu4UupQNU9X2cXKVXjmjuP6KkcKGNA9nTMn2TG7BuLsKgNt0
	 KmIBnQCNXPthg==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Tue, 29 Sep 2026 02:25:33 -0700
Message-ID: <20260929092534.44636-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjo1JJAJ_Cu0FEZ5kxRaEEt9yqyGrJJq8ottwg=bNFo3rQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 11:41:15 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> Hello
> 
> I decided to move step-by-step, so firstly I would get on Linux/bare
> metal or non-VmWare setup memory tiering behaviour like on VmWare 9.1
> - https://knowledge.broadcom.com/external/article/449016/understanding-nvme-memory-tiering-activa.html#:~:text=Cause.%20This%20behavior%20is%20by%20design.%20The,page%20activity%20based%20on%20recency%20and%20frequency.
> 
> "Threshold Activation: The VMkernel initiates memory tiering only when
> total host physical DRAM (Tier 0) consumption reaches approximately
> the 80% threshold. If consumption is below this trigger (e.g., at
> 70-75%), the system will not migrate pages to Tier 1.
> Page Classification: ESXi monitors page activity based on recency and
> frequency. Only memory pages strictly classified as "cold" (inactive)
> are migrated to the NVMe Tier 1 device. The active working set ("hot"
> pages) is deliberately retained in Tier 0 to prevent performance
> penalties.
> Scan Rate: The page scan and migration rate scale with memory
> pressure. At lower consumption levels (just crossing the 80% mark),
> the rate is highly conservative."

Sounds good.

> 
> Here is my corrected command,
> 
> damo start \--numa_node 0 --monitoring_intervals_goal 5% 3 5ms 10s

Fyi, '--monitoring_intervals_autotune' is same to
'--monitoring_intervals_goal 4% 3 5ms 10s'.

> \--damos_action migrate_cold 2 --damos_access_rate 0% 0%
> \--damos_apply_interval 1s \--damos_quota_interval 1s
> --damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
> \--damos_filter reject young \--numa_node 2
> --monitoring_intervals_goal 5% 3 5ms 10s \--damos_action migrate_hot 0
> --damos_access_rate 5% max \--damos_apply_interval 1s
> \--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
> node_mem_used_bp 50.3% 0 \--damos_filter allow young
> \--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
> --nr_schemes 1 1 --nr_ctxs 1 1

Also, fyi again, from damo v3.4.1, you can mark start of new kdamond, context,
target and scheme parameters on the command line using --kdamond, --damon_ctx,
--damon_target, and --damos_scheme.  you coud use those instead of
--damos_nr_quota_goals, --damos_nr_filters, --nr_targets, --nr_schemes and
--nr_ctxs.  E.g.,

damo start \
        ` # A kdamond to demote cold memory from node 0 to node 2 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 0 \
                --damos_scheme \
                        --damos_action migrate_cold 2 \
                        --damos_access_rate 0% 0% --damos_apply_interval 1s \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50% node 0 free memory ` \
                        --damos_quota_goal node_mem_free_bp 50% 0 \
                        --damos_filter reject young \
        ` # A kdamond to promote hot memory from node 2 to node 0 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 2 \
                --damos_scheme \
                        --damos_action migrate_hot 0 \
                        --damos_access_rate 5% max --damos_apply_interval 1s \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50.3% node 0 memory utilization ` \
                        --damos_quota_goal node_mem_used_bp 50.3% 0 \
                        --damos_filter allow young \

> 
> with consist -> temporal,
> 
> [root@localhost ~]# cat
> /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goal_tuner
> temporal
> [root@localhost ~]# cat
> /sys/kernel/mm/damon/admin/kdamonds/1/contexts/0/schemes/0/quotas/goal_tuner
> temporal

Seems you manually made this change.  Has this executed after 'damo start'?
Also, did you 'commit' the updated commit input?  If any of your answer to the
questions is not "yes", the tuner update may not applied.

You can specify what tuner to use on 'damo' command together, using
'--damos_quota_goal_tuner' option.  I'd recommend using that.  E.g.,

damo start \
        ` # A kdamond to demote cold memory from node 0 to node 2 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 0 \
                --damos_scheme \
                        --damos_action migrate_cold 2 \
                        --damos_access_rate 0% 0% --damos_apply_interval 1s \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50% node 0 free memory ` \
                        --damos_quota_goal node_mem_free_bp 50% 0 \
                        ` # using temporal tuner ` \
                        --damos_quota_goal_tuner temporal \
                        --damos_filter reject young \
        ` # A kdamond to promote hot memory from node 2 to node 0 ` \
        --kdamond --damon_ctx --monitoring_intervals_autotune \
                --damon_target --numa_node 2 \
                --damos_scheme \
                        --damos_action migrate_hot 0 \
                        --damos_access_rate 5% max --damos_apply_interval 1s \
                        ` # up to 8 GiB per second ` \
                        --damos_quota_interval 1s --damos_quota_space 8G \
                        ` # aiming at least 50.3% node 0 memory utilization ` \
                        --damos_quota_goal node_mem_used_bp 50.3% 0 \
                        ` # using temporal tuner ` \
                        --damos_quota_goal_tuner temporal \
                        --damos_filter allow young \

> 
> But it again didn't stop ~50%
> 
> [root@localhost ~]# numastat -p $(pgrep valkey-server)
> 
> Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Huge                         0.00            0.00            0.00
> Heap                         0.11            0.00            0.00
> Stack                        0.03            0.00            0.00
> Private                 228807.54            0.48          185.79
> ----------------  --------------- --------------- ---------------
> Total                   228807.67            0.48          185.79
> 
>                            Node 3           Total
>                   --------------- ---------------
> Huge                         0.00            0.00
> Heap                         0.00            0.11
> Stack                        0.00            0.03
> Private                      0.00       228993.80
> ----------------  --------------- ---------------
> Total                        0.00       228993.94
> 
> 
> [root@localhost ~]# numastat -p $(pgrep valkey-server)
> 
> Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Huge                         0.00            0.00            0.00
> Heap                         0.01            0.00            0.10
> Stack                        0.01            0.00            0.02
> Private                  13434.01            0.48       215559.31
> ----------------  --------------- --------------- ---------------
> Total                    13434.03            0.48       215559.43
> 
>                            Node 3           Total
>                   --------------- ---------------
> Huge                         0.00            0.00
> Heap                         0.00            0.11
> Stack                        0.00            0.03
> Private                      0.00       228993.80
> ----------------  --------------- ---------------
> Total                        0.00       228993.94

Interesting.  I doubt if the tuner change is correctly made.  'damo report
damon' can help us understand under what configuration DAMON is running.  It
could help us quickly see if the configuration is done as we intended.  Could
you share 'damo report damon' result on the final state?

It would also be helpful if you could run 'damo report damon --damos_stats'
periodically (say, once per 5-10 seconds) while the migration is ongoing and
share the outputs with us.

> 
> 
> 
> > > Oohhh... I moved to 5%.
> > I understand you mean 4%?
> 
> As far as I understood, this value represents "accuracy", so there
> shouldn't be a big difference between 4% vs 5%.  Or please correct me
> if I'm wrong.

Yes, 5% vs 4% should be an ignorable small difference.


Thanks,
SJ

[...]
