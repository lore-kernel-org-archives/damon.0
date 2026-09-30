Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC24403E8D
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757364; cv=none; b=DzhkeQMysT/8Jsp8o6XRJJSZbwZ4iMNAvwCDCOu+x6VLl+Su8vpOylqx4/UiX80PEUF8S9xiECB7UWu4TzAMV9WF2x0MRZK2cDTGsh07wOtvSCLxmkZWqzpZ39oIpfZVU8QBHm3FEs2J+cL3RkcfB1v9QDtHopGX0yO0Dnql+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757364; c=relaxed/simple;
	bh=WZRwva2hNDaFZUXMO9LcoiuI9jVdyuD0MbBqZMRlGTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2c/K0lQcSHR44YZUAtukZd8bEnPkaU0/sba9816cG4KkGcxIeCEViQYUX//ts+1FaUu1fuEKnFvFuWiRBhWfgH5IpF99b1OafRZ+pHWCLkjsqb+Afydyw8bfUiwxhAT3AoWnYJIpkpvvp6nCDbj0Pwp/ydupycGX25t3socYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/RpF3Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/RpF3Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DCC1F000FF;
	Wed, 30 Sep 2026 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790757356;
	bh=deudgWLlS6fYg6PAww+QfzNnCqp9328c3dyy88B4LPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/RpF3CzcGE2GBw033AqoorYtxxMkUHgV47guqXEkU+3jRV3teSrXluKXabXNK6hi
	 QLeO6pHEqUjbVhrf4Kzg/k18VngJJiiAvfHxM9RUDGASPuS/D21uojKUIGF5JCkmLB
	 x2OfPxgSIJYQefJlmjNesM/dSWTL+5nYX0F8B0AcsydY2KKUx590CDU2FhbmDxdAdG
	 ZN/3wn3NAv2Gv4ZFxZryIR/EV/kIGHCjse9Im8z2gCNfEAXZpXaWmjKtLjogsuYXAg
	 whj2zT6jwMxpQWRtOfz5G34qHquh6MkVsRoAr/hgLI2IGlBDw8fczV9Ensog1HotYE
	 +5FnSSHJJZ+tw==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Wed, 30 Sep 2026 01:35:51 -0700
Message-ID: <20260930083552.11289-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjq_XJ+kvNFdbXNJUrJMVtj5BVqN+NoZ2PvxYavFjOg2fw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 07:03:47 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> > Oops...  Seems you were running next branch of damo.  There was a bug.  I
> > reproduced it on 7.2.8 kernel, and fixed it.  The fix [1] is now pushed.  Could
> > you pull the 'next' branch and try again?
> 
> Done.
[...]
> It looks now it keeps ~50% free numa node 0,

Awesome :D

[...]
> [root@localhost ~]# /home/anton/damo/damo report damon
> kdamond 0
>     state: on, pid: 29836
>     context 0
>         ops: paddr
[...]
>         scheme 0
>             action: migrate_cold to node 2 per 1 s
>             target access pattern
>                 sz: [0 B, max]
>                 nr_accesses: [0 samples, 0 samples]
>                 age: [0 aggr_intervals, 184,467,440,737,095 aggr_intervals]
>             quotas
>                 0 ns / 8.000 GiB / 0 B per 1 s
>                 goal 0: metric node_mem_free_bp (nid 0) target 5,000 current 0
>                 goal tuner: temporal

Ok, the above line confirms DAMON is running with 'temporal' tuner.

[...]
> DAMON & DAMOS are very flexible, so it requires a deep understanding
> of specific workload and how to configure memory tiering with DAMON &
> DAMOS.

Indeed it is.  Nonetheless, for the reason we provide DAMON modules [1] or damo
scripts for commonly known DAMON usages.  We have DAMON_RECLAIM module [2] for
proactive memory reclamation, and mem_tier.sh [3] for memory tiering.

My suggestion is to start from such examples, find what is not working and
asking questions to me.  So you are doing all great :D

> 
> So firstly I decided to make it like VMware VCF 9.1 does :-)), next I
> will reduce the goal from 50% free to 25-25% for numa node 0.

Sounds like a good plan.

> 
> Based on the outputs above, please let me know if other improvements
> are required.

This temporal tuner test has proved the quota system is not broken.  It implies
the previous test resulted in migrating nearly all data to the lower tier,
because there was no hot data to promote back to the upper tier.

In many common benchmarks using zipfian-like access distribution, hot data is
always hot, and cold data is always cold.  And usually the amount of cold data
is much larger than hot data.  I found [4] the pattern is making evaluation of
tiering solutions difficult, and was using artificial access pattern mixing to
work around.

My imagined real world workload is, there will be hot and cold data.  And the
pattern will nearly always be stable.  But, occasionally there will be changes.
Say, a chunk of data will be hot for a few hours, but suddenly be cold and keep
being cold for a few hours, then sudenly be warm for hours, and so on.  The
auto-tuning based DAMON tiering is designed with such workload in mind.

For your testing, I think the setup is good.  I'd suggest lower target free
memory ratio, though.  Assuming the theory (your workload has static access
pattern of small hot data) is true, using consist tuner should also be fine.

You will have more than expected data in lower tier, but if those are truly
cold, why would we bother?  If you still want strict upper tier utilization,
you could make the access pattern and filter condition less strict.  Ideally,
the access pattern and filter conditions should all go away, assuming DAMON can
find true hot and cold data.  And I believe that would be the case for
long-running real world workloads.  Short-running test workload would show
DAMON making wrong decisions in short term, though.

If you want to make sure if my theory is true, you could also profile the
access pattern of your test workload using DAMON.  I actually did it for my
auto-tuned tiering test [4] to find the fact.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#special-purpose-access-aware-kernel-modules
[2] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/reclaim.html
[3] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
[4] https://lkml.kernel.org/r/20250420194030.75838-1-sj@kernel.org


Thanks,
SJ

[...]
