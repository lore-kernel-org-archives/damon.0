Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5737AA9E
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703447; cv=none; b=aajIAyle+B0uSO2U5uyFyH1IyHf4VEZ/RS2iuKV15EUvhMpDM2XM80pYvlChSCsOm+yTbsTuRod9txYpW/lrCMb/2xbdcQFfAwtisdcFqLjS6IleTebfl1qiUfXlRDqIDvZMd6vc6tp7HUVkYVs0QFgBt1B23xu/s8Bsrly+f0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703447; c=relaxed/simple;
	bh=nRLdS3gwX0P9wi+H27dXFaflRQrybWRSFYWSb9ppbrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMrh/E2OpN0DlaJzJAP6BcrVOMJelOwSB/v2aJ0sqDIOgJ8gCFEdRlOgxUxZDsvq97S2Jo44wYrexQ4t3five5t5SasR76rb/ztB6c/IX2of5zKIORrhGOzSe1PbL0dIz6u0sbHl8zufNuRr08I0Dx+hIG3udhYOxc0A7zjIfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STEAEUt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STEAEUt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFF01F000FF;
	Tue, 29 Sep 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703446;
	bh=KA2E9/8tGKWa05NbHoMj+ytY3KNmOmgZJMa6ksdpW+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=STEAEUt416oY21137Z5ZXBHloPrcujgx8nyHG89k1JpSGEedZ0yuP56LoXSmK3iIG
	 fdoveBJ1w7MjMehgFVebfDydair9rT2vH2AnGsRq4p5w/dg65NXtvMt85rLikzvplE
	 gx5GHNM2cYArSpzOGj6iuCon/dtRVEUIg00pfkwR3h0XY7tSlpa6PaeWTDTYQWr9ZL
	 A28DAxXeuWUEH3zkYwL7Ry95LGdXoXrFnlX69aIQ3u26RbnEh2XuhBlbDbKeJZbe6i
	 VCMK1HkHid24n0NU6FLCjZSD6OEacpzQZs4nnpOTv85RsjsSAyzstDt5Kiwh+rwg/H
	 5J+OyJ1UXhA7g==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Tue, 29 Sep 2026 10:37:21 -0700
Message-ID: <20260929173721.6763-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjrSKe9r7KXnWzrgb1-CRO0sDu7B_jK2mZDg7fPaT0Jdcg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 16:54:41 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> > Also, fyi again, from damo v3.4.1, you can mark start of new kdamond, context,
> > target and scheme parameters on the command line using --kdamond, --damon_ctx,
> > --damon_target, and --damos_scheme.  you coud use those instead of
> > --damos_nr_quota_goals, --damos_nr_filters, --nr_targets, --nr_schemes and
> > --nr_ctxs.  E.g.,
> 
> Fedora shows old damo version,
> 
> [root@localhost anton]# rpm -qa|grep -i damo
> damo-3.3.0-1.fc44.noarch
> [root@localhost anton]#
> 
> so I configured latest available 3.4.1
> 
> [root@localhost damo]# damo version
> 3.4.1
> [root@localhost damo]# which damo
> /home/anton/damo/damo
> [root@localhost damo]#

Thank you!  Hopefully upgrading the version was not that difficult.  You can
simply git-clone the repo and use the 'damo' executable file under the
local-cloned repo.

> 
> > Seems you manually made this change.  Has this executed after 'damo start'?
> > Also, did you 'commit' the updated commit input?  If any of your answer to the
> > questions is not "yes", the tuner update may not applied.
> 
> Yes, it was executed before 'damo start', but I didn't do 'commit'.

To do this manually, you should write the files after 'damo start', and also do
'commit'.

Anyway, this means your previous run was using 'consist' tuner.  That explains
why it didn't show any difference.

> 
> > It would also be helpful if you could run 'damo report damon --damos_stats'
> > periodically (say, once per 5-10 seconds) while the migration is ongoing and
> > share the outputs with us.
> 
> Ok, initially I have,
> 
> [root@localhost ~]# numastat -z -p $(pgrep valkey-server)
> 
> Per-node process memory usage (in MBs) for PID 25361 (valkey-server)
>                            Node 0          Node 1          Node 2
>                   --------------- --------------- ---------------
> Heap                         0.11            0.00            0.00
> Stack                        0.03            0.00            0.00
> Private                 238356.60            0.50            4.86
> ----------------  --------------- --------------- ---------------
> Total                   238356.73            0.50            4.86
> 
>                             Total
>                   ---------------
> Heap                         0.11
> Stack                        0.03
> Private                 238361.95
> ----------------  ---------------
> Total                   238362.09
> [root@localhost ~]#
> 
> I run
> 
> [root@localhost ~]# /home/anton/damo/damo start \
>         ` # A kdamond to demote cold memory from node 0 to node 2 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 0 \
>                 --damos_scheme \
>                         --damos_action migrate_cold 2 \
>                         --damos_access_rate 0% 0% --damos_apply_interval 1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G \
>                         ` # aiming at least 50% node 0 free memory ` \
>                         --damos_quota_goal node_mem_free_bp 50% 0 \
>                         ` # using temporal tuner ` \
>                         --damos_quota_goal_tuner temporal \
>                         --damos_filter reject young \
>         ` # A kdamond to promote hot memory from node 2 to node 0 ` \
>         --kdamond --damon_ctx --monitoring_intervals_autotune \
>                 --damon_target --numa_node 2 \
>                 --damos_scheme \
>                         --damos_action migrate_hot 0 \
>                         --damos_access_rate 5% max --damos_apply_interval 1s \
>                         ` # up to 8 GiB per second ` \
>                         --damos_quota_interval 1s --damos_quota_space 8G \
>                         ` # aiming at least 50.3% node 0 memory utilization ` \
>                         --damos_quota_goal node_mem_used_bp 50.3% 0 \
>                         ` # using temporal tuner ` \
>                         --damos_quota_goal_tuner temporal \
>                         --damos_filter allow young \
> >
> sysinfo loading fail (info update fail (sysfs feature check fail
> (feature map making fail (staging damos goal feature check purpose
> kdamond failed))))

Oops...  Seems you were running next branch of damo.  There was a bug.  I
reproduced it on 7.2.8 kernel, and fixed it.  The fix [1] is now pushed.  Could
you pull the 'next' branch and try again?

> [root@localhost ~]#
> [root@localhost ~]# ps -ef|grep -i damo
> root       26051   25396  0 16:49 pts/2    00:00:00 grep --color=auto -i damo
> [root@localhost ~]#
> 
> > It would also be helpful if you could run 'damo report damon --damos_stats'
> > periodically (say, once per 5-10 seconds) while the migration is ongoing and
> > share the outputs with us.
> 
> Sure, I will start something like that,
> while true; do damo report damon --damos_stats >>
> /home/anton/damo_report_damon_damos_stats; sleep 10; done
> once damo will be started.

Sounds good.

> 
> 
> > Interesting.  I doubt if the tuner change is correctly made.  'damo report
> > damon' can help us understand under what configuration DAMON is running.  It
> > could help us quickly see if the configuration is done as we intended.  Could
> > you share 'damo report damon' result on the final state?
> 
> There are errors above during damo start.

Apparently it was a bug in damo's next branch.  As I mentioned above, the fix
is now pushed.  Could you try again?

[1] https://github.com/damonitor/damo/commit/fd2fb55b44ba03db55b8a025eef43dcf569831e5

Thanks,
SJ

[...]
