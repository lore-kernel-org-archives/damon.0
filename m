Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F32222D7;
	Thu,  8 May 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722110; cv=none; b=m1xpPQHA4AM2hVWXfEXRyro9TLK4SjQt4QZsY9CGEK/CePjCewx6SfZIS6dIQj93aFboRvwfF723/4BQ6V/QFCZGguEeTVlHwsYR8fRODC294OEjgVK8lMEjOSFOVjdSFLSugD2wjLLNmCFFeLDdboI3DS1pXO4zPhdMUEeb3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722110; c=relaxed/simple;
	bh=zw69N1sh7qesflqhTh0NK6JUMUolWi0TizEUEVcFxlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+SL7x7cnTWz995PklCFf4nMpx+7WLDemxK/YMcSrmOnUFu27Ao4gXF02jPpz+Y//JTcttTzb4Dd1XONqfyqJ6PqnrHMCyTIUW57UIA8k+ZaAcgnAXV/bXFsGky26tDiN7KdxLUuGRwR8Ts4OfJjQOU93VYsU1XZvdNS8ogVL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDbz+7F1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDbz+7F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B655EC4CEEB;
	Thu,  8 May 2025 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746722110;
	bh=zw69N1sh7qesflqhTh0NK6JUMUolWi0TizEUEVcFxlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDbz+7F1512FyEYzrZEBPqSbS3DRB6QCp0TbaWZM1jE9I6oaepgzR4qL/rT9QJ8CK
	 gi199aO6exscuDS17FWNa2gcW+og7Tqzln97CHEm82itEs/+X6Ptz+tPRU9+LtOEJ1
	 oOyOMpX6NOSC/6ah7uH5GPge09dC1EgTzQRwf6LKPEMbJNm4TAuFzSV9at1PQTzwM8
	 mprtj7Df6HWFMlWNZcBO0JYtAt0dvM3b7E4yTaDwq2nTWk/R5bgkpQn0Zts22wndVF
	 gPN2CfsVrT6FOAu6kVItwjjqIRlj1LcM5T/EmS6hohDxZcFyLTKFd0AVL5PZg3aYIm
	 kwGDhqPgXnVhw==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com
Subject: Re: [PATCH 0/7] mm/damon: auto-tune DAMOS for NUMA setups including tiered memory
Date: Thu,  8 May 2025 09:35:06 -0700
Message-Id: <20250508163506.56305-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508092833.800-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  8 May 2025 18:28:27 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi Seongjae, I'm sorry for the delayed response due to the holidays.

No worry, hope you had a good break :)

> 
> On Fri,  2 May 2025 08:49:49 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hi Yunjeong,
> > 
> > On Fri,  2 May 2025 16:38:48 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > > Hi SeongJae, thanks for your helpful auto-tuning patchset, which optimizes 
> > > the ease of used of DAMON on tiered memory systems. I have tested demotion
> > > mechanism with a microbenchmark and would like to share the result.
> > 
> > Thank you for sharing your test result!
> > 
> > [...]
> > > Hardware. 
> > > - Node 0: 512GB DRAM
> > > - Node 1: 0GB (memoryless)
> > > - Node 2: 96GB CXL memory
> > > 
> > > Kernel
> > > - RFC patchset on top of v6.14-rc7 
> > > https://lore.kernel.org/damon/20250320053937.57734-1-sj@kernel.org/
> > > 
> > > Workload
> > > - Microbenchmark creates hot and cold regions based on the specified parameters.
> > >   $ ./hot_cold 1g 100g
> > > It repetitively performs memset on a 1GB hot region, but only performs memset
> > > once on a 100GB cold region. 
> > > 
> > > DAMON setup
> > > - My intention is to demote most of all regions of cold memory from node 0 to 
> > > node 2. So, damo start with below yaml configuration:
> > > ...
> > > # damo v2.7.2 from https://git.kernel.org/pub/scm/linux/kernel/git/sj/damo.git/
> > >    schemes:
> > >    - action: migrate_cold
> > >       target_nid: 2
> > > ...
> > >       apply_interval_us: 0
> > >       quotas:
> > >         time_ms: 0 s
> > >         sz_bytes: 0 GiB
> > >         reset_interval_ms: 6 s
> > >         goals:
> > >         - metric: node_mem_free_bp 
> > >           target_value: 99%
> > >           nid: 0
> > >           current_value: 1
> > >         effective_sz_bytes: 0 B
> > > ...
> > 
> > Sharing DAMON parameters you used can be helpful, thank you!  Can you further
> > share full parameters?  I'm especially interested in how the parameters for
> > monitoring targets and migrate_cold scheme's target access pattern, and if
> > there are other DAMON contexts or DAMOS schemes running together.
> > 
> 
> Actually, I realized that the 'regions' field in my YAML configuration is 
> incorrect. I've been using a configuration file that was create on another 
> server, not the testing server.

To my understanding, you use YAML configuration because DAMON user-space tool
doesn't provide good interface for multiple kdamonds setup.  Starting from
v2.7.5, DAMON user-space tool supports multiple kdamonds setup from the command
line, and it supports setting target regions as NUMA nodes (--numa_node).
Using those might be a better option for you.

> As a result, the scheme is applied to wrong
> region, causing the results to appear confusing. I've  fixed the issue and
> confirmed that the demotion occured successfully. I'm sorry for any confusion
> this may have caused.

Glad to hear that the issue is fixed.

> 
> After fixing it up, Honggyu and I tested this patch again. I would like to
> share two issues: 1) slow start of action, 2) action does not stop even when 
> target is acheived. Below are the test configurations:
> 
> Hardware
> - node 0: 64GB DRAM
> - node 1: 0GB (memoryless)
> - node 2: 96GB CXL memory
> 
> Kernel
> - This patchset on top of v6.15-rc4
> 
> Workload: microbenchmark that `mmap` and `memset` once for size GB
> $ ./mmap 50
> 
> DAMON setup: just one contexts and schemes.
>     ...
>     schemes:
>     - action: migrate_cold
>       target_nid: 2
>       access_pattern:
>         sz_bytes:
>           min: 4.000 KiB
>           max: max
>         nr_accesses:
>           min: 0 %
>           max: 0 %
>         age:
>           min: 10 s
>           max: max
>       apply_interval_us: 0
>       quotas:
>         time_ms: 0 s
>         sz_bytes: 0 GiB
>         reset_interval_ms: 20 s
>         goals:
>         - metric: node_mem_free_bp
>           target_value: 50%
>           nid: 0
>           current_value: 1
>      ...
> 
> Two issues mentioned above are both caused by the calculation logic of 
> `quota->esz`, which grows too slowly and increases gradually.
> 
> Slow start: 50GB of data is allocated on node 0, and the demotion first occurs
> after about 15 minutes. This is because `quota->esz` is growing slowly even
> when the `current` is lower than the `target`. 

This is an intended design to avoid making unnecessary actions for only
temporal access pattern.  On realistic workloads having a time scale, I think
some delay is not a big problem.  I agree 15 minutes is too long, though.  But,
the speed also depends on reset_interval_ms.  The quota grows up to 100% once
per reset_interval_ms.  The quota size is 1 byte in minimum, so it takes at
least 12 reset_interval_ms to make the size quota at least single 4K page size.
Because reset_interval_ms is 20 seconds in this setup, 12 reset_interval_ms is
four minutes (240 seconds).

My intended use of resset_interval_ms is setting it just not too short, to
reduce unnecessary quota calculation overhead.  From my perspective, 20 seconds
feels too long.  Is there a reason to set it so long?  If there is no reason,
I'd recommend starting with 1 second reset_interval_ms and adjust for your
setup if it doesn't work.

And I realize this would better to be documented.  I will try to make this more
clarified on the documentation when I get time.  Please feel free to submit a
patch if you find a time faster than me :)

> 
> Not stop: the `target` is to maintain 50% free space on node 0, which we expect
> to be about 32GB. However, it demoted more than intended, maintaing about 90%
> free space as follows:
> 
>   Per-node process memory usage (in MBs)
>   PID           Node 0 Node 1 Node 2 Total
>   ------------  ------ ------ ------ -----
>   1182 (watch)       2      0      0     2
>   1198 (mmap)     7015      0  44187 51201
>   ------------  ------ ------ ------ -----
>   Total           7017      0  44187 51204
> 
> This is becuase the `esz` decreased slowly after acheiving the `target`.
> In the end, the demotion occured more excessively than intended.
> 
> We believe that the defference between `target` and `current` increases, the
> `esz` should be raised more rapidly to increase the aggressiveness of action.
> In the current implementation, the `esz` remains low even when the `current` is
> below the `target`, leading to a slow start issue. Also, there is a not-stop
> issue where high `esz` persist (decreasing slowly) even when an over_achieved
> state. 

This is yet another intended design.  The aim-oriented quota auto-tuning
feature assumes there is an ideal amount of quota that fits for the current
situation, that could dynamically change.  For example, proactively reclaiming
cold memory aiming a modest level of memory pressure.

For this case, I think you should have another scheme for promotion.  Please
refer to the design and example implementation of the sample module.  Or, do
you have a special reason to utilize only demotion scheme like this setup?  If
so, please share.

If you really need a feature that turns DAMOS on and off for given situation,
DAMOS watermarks may be the right feature to look.  You could also override
tuned quota from user space.  So you could monitor the free size of given NUMA
node and set the tuned quota as zero, immediately, or jsut remove the scheme.

Again, this might be due to the poor documentation.  Sorry about the poor
documentation and thank you for letting me find this.  I'll try to make the
documentation better.

> 
> > 
> > Yes, as you intrpret, seems the auto-tuning is working as designed, but
> > migration is not successfully happened.  I'm curious if migration is tried but
> > failed.  DAMOS stats[1] may let us know that.  Can you check and share those?
> > 
> 
> Thank you for providing the DAMOS stats information.
> I will use it when analyzing with DAMON.

Maybe an easiest way to monitor it is
'damo report access --tried_regions_of X Y Z --style temperature-sz-hist'.

> I would appreciate any feedback you
> might have on the new
> results.

I wish my above replies helps a bit, and looking forward to anything I missed
or your special reasons for your setup if you have.


Thanks,
SJ

[...]
