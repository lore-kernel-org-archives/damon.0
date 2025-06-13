Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA41E991B;
	Fri, 13 Jun 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834760; cv=none; b=nlwSwIjETcQNYrxoxR3JElZFk+VKm7N4nAjd4DHZiVUSuAiEFycgRtwbtzDq1zclBz2RBlWOcvp5+ngWXNXyeRKIr4Rm8kpjMxxL4hlsdDLp8j3dkekEcu0reZItp9/Ml+2Po1zVey9fUMJ/U0cVLnQ45reMN9V/UVlresoartc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834760; c=relaxed/simple;
	bh=xM4LY8gCbVDYFCPbHwGXzUDBh//wknD9c5Jupk3PfVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CixVgEhnt6C4AfqwnGS40H9bzVUAMAtORCsDPsWRhTVxfvGjwWu7qhvvuhCBpI+J6zwE93iqxt2+GAuPeimQPhN62YL2zee21mDavhJcL+XpBst2GEXa7sXd9Q3mEfed/9BhBi02D/e/MvFEpxAb/5PKnxtm+vxhok4pWhvcGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYig8c2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYig8c2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FF6C4CEEB;
	Fri, 13 Jun 2025 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749834759;
	bh=xM4LY8gCbVDYFCPbHwGXzUDBh//wknD9c5Jupk3PfVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYig8c2KsM8V1idlrJDousBAEU1xY7riLzZWMBTWE3Ezu2VsSR3yMHdo+EZrRPviZ
	 BydL+68ZnGxEMYLCvzJpfV6fRy61xlYThU65/p/1tVPw+pdqDPIpGcOWMgAW7aPkzV
	 +tGA94ZGrvKjJz2Dw42l0Hk0JshDRSo8/zt7gSQwRbDBOU35210VWs+2xsarH8E1Oi
	 b//BrwyccxdIhvOvQ9vNzKXzbT9lwnSYCGMWxiBxqU0MrxS2kLsljTeexSkJOAQIFr
	 /62nri21isMHRdLqH7ztmcGqHGFYbGMed7zYnKEp9ZPSushEVo8pS0XzkEiAAfXdzO
	 RGIdY7xlvt3Qw==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 0/4] mm/damon: Add DAMOS action to interleave data across nodes
Date: Fri, 13 Jun 2025 10:12:37 -0700
Message-Id: <20250613171237.44776-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS4WsGkfukNscnLWW40Agg6_wmkm_QF96m+HZrEZrstR4A@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Jun 2025 10:44:17 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> Hi SeongJae,
> 
> Thank you for your comments.
> 
> On Thu, Jun 12, 2025 at 6:49 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Bijan,
> >
> > On Thu, 12 Jun 2025 13:13:26 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:
> >
> > > From: Bijan Tabatabai <bijantabatab@micron.com>
> > >
[...]
> > What about extending DAMOS_MIGRATE_{HOT,COLD} to support your use case?  For
> > example, letting users enter special keyword, say, 'weighted_interleave' to
> > 'target_nid' DAMON sysfs file.  In the case, DAMOS_MIGRATE_{HOT,COLD} would
> > work in the way you are implementing DAMOS_INTERLEAVE.
> 
> I like this idea. I will do this in the next version of the patch.

Great, looking forward to that!

> I
> have a couple of questions
> about how to go about this if you don't mind.

Of course I don't :)

> 
> First, should I drop the vaddr implementation or implement
> DAMOS_MIGRATE_{HOT,COLD}
> in vaddr as well? I am leaning towards the former because I believe
> the paddr version is
> more important, though the vaddr version is useful if the user only
> cares about one
> application.

I show no problem at dropping the vaddr implementation.  Please do what you
want and need to do on your pace :)

> 
> Second, do you have a preference for how we indicate that we are using
> the mempolicy
> rather than target_nid in struct damos? I was thinking of either
> setting target_nid to
> NUMA_NO_NODE or adding a boolean to struct damos for this.

I'd prefer adding a boolean to 'struct damos'.

> 
> Maybe it would also be a good idea to generalize it some more. I
> implemented this using
> just weighted interleave because I was targeting the use case where
> the best interleave
> weights for a workload changes as the bandwidth utilization of the
> system changes, which
> I will go describe in more detail further down. However, we could
> apply the same logic for
> any mempolicy instead of just filtering for MPOL_WEIGHTED_INTERLEAVE. This might
> clean up the code a little bit because the logic dependent on
> CONFIG_NUMA would be
> contained in the mempolicy code.

Yes, I agree.  Such flexibility sounds useful :)

In future, I think we could further let users set multiple target nodes for
DAMOS_MIGRATE_{HOT,COLD} with arbitrary weights.

[...]
> > I show the test results on the commit messages of the second and the fourth
> > patches.  In the next version, letting readers know that here would be nice.
> > Also adding a short description of what you confirmed with the tests here
> > (e.g., with the test we confirmed this patch functions as expected [and
> > achieves X % Y metric wins]) would be nice.
> >
> 
> Noted. I'll include this in the cover letter of the next patch set.

Thank you! :)

[...]
> > I think it would also be nice if you could add more explanation about why you
> > picked DAMON as a way to implement this feature.  I assume that's because you
> > found opportunities to utilize this feature in some access-aware way or
> > utilizing DAMOS features.  I was actually able to imagine some such usages.
> > For example, we could do the re-interleaving for hot or cold pages of specific
> > NUMA nodes or specific virtual address ranges first to make interleaving
> > effective faster.
> 
> Yeah, I'll give more detail on the use case I was targeting, which I
> will also include
> in the cover letter of the next patch set.
> 
> Basically, we have seen that the best interleave weights for a workload can
> change depending on the bandwidth utilization of the system. This was touched
> upon in the discussion in [1]. As a toy example, imagine some
> application that uses
> 75% of the local bandwidth. Assuming sufficient capacity, when running alone, we
> probably want to keep all of that application's data in local memory.
> However, if a
> second instance of that application begins, using the same amount of bandwidth,
> it would be best to interleave the data of both processes to alleviate
> the bandwidth
> pressure from the local node. Likewise, when one of the processes ends, the data
> should be moved back to local memory.
> 
> We imagine there would be a userspace application that would monitor system
> performance characteristics, such as bandwidth utilization or memory
> access latency,
> and uses that information to tune the interleave weights. Others seemed to have
> come to a similar conclusion in previous discussions [2]. We are
> currently working
> on a userspace program that does this, but it's not quite ready to be
> published yet.

Sounds interesting, looking forward!

Note that DAMOS has internal feedback loop for auto-tuning aggressiveness of a
given scheme, and the feedback loop accepts system metrics or arbitrary user
inputs.  I think the userspace program _might_ be able to give the arbitrary
feedback.  We could also think about extending the list of DAMOS-accepting
feedback system metrics to memory bandwidth.

> 
> After the userspace application adjusts the interleave weights, we need some
> mechanism to migrate the application pages that have already been allocated.
> We think DAMON is the correct venue for this mechanism because we noticed
> that we don't have to migrate all of the application's pages to
> improve performance,
> we just need to migrate the frequently accessed pages. DAMON's existing hotness
> tracking is very useful for this. Additionally, as Ying pointed out
> [3], a complete
> solution must also handle when a memory node is at capacity. The existing
> DAMOS_MIGRATE_COLD action can be used in conjunction with the functionality
> in this patch set to provide that complete solution.
> 
> [1] https://lore.kernel.org/linux-mm/20250313155705.1943522-1-joshua.hahnjy@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20250314151137.892379-1-joshua.hahnjy@gmail.com/
> [3] https://lore.kernel.org/linux-mm/87frjfx6u4.fsf@DESKTOP-5N7EMDA/

Thank you for this nice and informative description of the use case!

> 
> > Also we could apply a sort of speed limit for the interleaving-migration to
> > ensure it doesn't consume memory bandwidth too much.  The limit could be
> > arbitrarily user-defined or auto-tuned for specific system metrics value (e.g.,
> > memory bandwidth balance?).
> 
> I agree this is a concern, but I figured DAMOS's existing quota mechanism would
> handle it. If you could elaborate on why quotas aren't enough here,
> that would help
> me come up with a solution.

What I wanted to say is, we could use DAMOS's existing quota mechanism to
handle it.  DAMOS quota feature is just another name of [auto-tunable] speed
limit.  Sorry for confusing you.  Anyway, happy to confirm this is yet another
DAMOS feature that could be useful for your and future cases.

> 
> 
> > If you have such use case in your mind or your test setups, sharing those here
> > or on the next versions of this would be very helpful for reviewers.
> 
> Answered above. I will include them in the next version.

That was very helpful.  Keeping that on the next version will be helpful for
new readers such as future SJ :)

[1] https://origin.kernel.org/doc/html/latest/mm/damon/design.html#aim-oriented-feedback-driven-auto-tuning


Thanks,
SJ

[...]
