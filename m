Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BE43146;
	Wed,  6 Aug 2025 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754453727; cv=none; b=CxV5K6Obufb5NJWrx1BgZyEQKhfIGG1dAIZBd7M5yY5ZLxI8iZoUyUIzIvUR/gd8hiKFUogkeo3YtHTSMydzcc9QbhdjiBkThONY4krOEdMsWd4N/ZtDTF+EVIr9A0LQ4yEg2ewcXCBU1nbRnGCUKuFC5tlZYjThs5SMGcxHz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754453727; c=relaxed/simple;
	bh=lixsbVjRKbA2M2sbx8UeuLMLOOp/6eUO40vsAH+a5LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZR7+vUWAkuRLQ6PBFp0Hr5nvdlh/KguKudPko+mI0MaexwUnsTPnR+JUumSzDzsgwI281T4yIJHtpSzTW32AIe0He/wOhGexpB/8fQZLB67uGh8qCRuWRtT5HLqZOWxFyk4DY/430KS257zM8nF+QNVumjlq3rJa/zHrf3G5Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9tKBhyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9tKBhyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7945BC4CEE7;
	Wed,  6 Aug 2025 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754453726;
	bh=lixsbVjRKbA2M2sbx8UeuLMLOOp/6eUO40vsAH+a5LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9tKBhytuodqEZxedPiCOH4+GHEEDTBFk1rnP38/kSvFuoPbRem5F5lhTwjA+7fsr
	 ig6tgd4pRttkI/nmaO33Dzr5D0zL1efo7QPMHVVuimFZciajkMy5af+A0kqvBCB/rA
	 kdJjTUt/M0yLDPOESiXLj3m+t1/jh/mv61xJI7EqLvD9EZQLFm0tmW5QuT9mKObx+z
	 WfMHgAFJ7ErAOkBNG6j5pPFfDPhJL56cXwMOeCmt5Q2c9h/bxpd4rnz4mnL/Iv4azC
	 2KiQctviETGhdXewkqyeJLodwmZUnnvVxbGEMtD9b1JvLWrz+CxEkxWemw3AxxJ8LK
	 w7LvnVKD9lpqQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using migration dests
Date: Tue,  5 Aug 2025 21:15:23 -0700
Message-Id: <20250806041523.54394-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS6hfCRh1fQh5zU5_quswPFVp0zWyS9N-Zikc0K-nSZd_g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 5 Aug 2025 20:27:52 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> Hi SJ,
> 
> 
> On Tue, Aug 5, 2025 at 7:40 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Bijan,
> >
> > Subjects of patches usually be converted into lowercase when be merged into mm
> > tree.  I'd suggest using lowercase even in patches stage, if those aim to be
> > merged into mm tree.
> 
> Noted, thanks.
> 
> [...]
> > > The commit_schemes_dests command, similar to the existing
> > > commit_schemes_quota_goals, is used to commit only the dests fields of
> > > schemes. This has a couple of benefits:
> > > 1) It is more efficient than recommitting all the DAMON data.
> > > 2) Doing a full commit resets the aggregation and ops_update intervals. If
> > > a user sends the full commit command frequently (relatively to those
> > > intervals) the aggregation and ops_update events will be prevented from
> > > triggering. Having a separate commit command side steps this problem.
> >
> > I agree the commit command of DAMON sysfs interface is inefficient, and could
> > make the infinite intervals delay problem.  But, I didn't expect there could be
> > use cases that use commit feature frequently enough to make the inefficiency
> > and the intervals delay be real problems.  Could you please let me know more
> > details about your use case and how severe problem DAMON is causing?
> 
> In my use case, I am trying to optimize the interleave ratio of
> applications to maximize their performance without prior knowledge of
> their behavior. To do this, we take the steps of updating the ratio,
> observing how the system reacts to the change in ratio, and update the
> ratio again accordingly. Because we want to approach the ideal
> interleave ratio quickly, we update the weights frequently, motivating
> the commit_schemes_dests. Similarly, we want to observe how the system
> reacts to the change only after the change has been applied,
> motivating wait_for_schemes_apply.

Thank you for sharing these details!

It sounds like you are using DAMOS without any quota, and the target workload
has static memory mapping.  Hence all migrations for the new weights can be
completed after one DAMOS schemes apply interval, and no more migration will
happen until new weights are given.  And that's why you want
wait_for_schemes_apply, since when the command is finished is when all new
weights based interleaving is done.  Am I understanding correctly?

> 
> The consequences are not very severe. The problem can be worked around
> by either updating less frequently, at the cost of converging slower,
> or decreasing the maximum aggregation period, which from what I
> understand may affect the access monitoring behavior.

Sounds suboptimal work arounds for you...

> 
> > Depending on the real problem, I'm wondering if optimizing commit command can
> > be a solution.  For example, skipping the update of next_aggregation_sis and
> > next_ops_update_sis when the intervals are not changed might be able to solve
> > the intervals delay problem.
> 
> This would work for my use case.

Great to hear this, and I agree.  The commit operation internally uses
damon_call(), which takes up to one sampling interval.  Also the migration
operation that you will wait for would also take no small time, depending on
the amount of pages to migrate.  Compared to those, I think the commit speed
increase due to committing unnecessary paramters may relatively short.
deal.

Meanwhile, I was concerning the continuous next_{aggregation,ops_update_}sis
delay could be a real problem.  And this option should solve the real problem.

> Another option might be to have a
> more general commit_schemes command, which may be useful to other use
> cases. I'll defer to your judgement on which would be better.

If my above theory is not wrong, I'd suggest making the commit operation
optimization.  If it turns out to be not enough for your or others' use cases,
we can further consider commit_schemes.

> 
> > >
> > > The wait_for_schemes_apply command causes the calling thread to wait until
> > > all schemes have been applied. It does this by calling damos_walk() with a
> > > NULL walk_fn. This can be useful, for example, if a user wants to know when
> > > new scheme parameters they've committed have been applied. Another use case
> > > could be if a user wants to record the system state every time a scheme is
> > > applied for debuging purposes.
> > >
> > > The functionality of wait_for_schemes_apply can be achieved with the
> > > existing update_schemes_tried_bytes and update_schemes_tried_regions
> > > commands. However, having a separate command avoids extra work and makes
> > > user intent clearer when used in scripts.
> >
> > I agree extra works are always better to be avoided.  But is the overhead large
> > enough to be a real problem for your use case?  I also agree it could make the
> > user script cleaner, but adding a kernel feature only for user scripts
> > readabilities sounds like too much, since the user script could have its own
> > abstract layers for its readability.
> 
> Totally fair. I will drop wait_for_apply_schemes in any future versions.
> 
> > Also, even if the new command is implemented, since the DAMOS schemes continue
> > running, the system status will keep changing.  If you cannot do the recording
> > of the system state in a restricted time, the recorded information might not be
> > that reliable.  So I'm not sure if you really need this strict waiting in this
> > way.
> 
> Fair. That was not something I was personally using the command for,
> just another possible use case I thought of. Regardless of the
> usefulness of that, the existing commands using damos_walk would work
> well enough.

I'm glad to hear we found a way to go.  As you may know,
update_schemes_tried_bytes would be more efficient, so I would suggest that
more than update_schemes_tried_regions.

If the wait is not strictly need to be accurate, maybe monitoring the DAMOS
scheme stats in auto-update mode[1] until any change is made could also be a
way.  The stat update for a scheme will be done only after the scheme is
applied to all applicable regions for a round.

> 
> > Could you please share more details about what you want to do with the new
> > command, and how much problem you are seeing?  I'm particularly curious what
> > system state you want to record, and why you need to wait the exact time
> > interval.
> 
> I mentioned this above, but I am using this to wait for new migration
> weights to be applied before monitoring how the change affects
> applications, but again, this can be done with existing commands.

Thank you again for kindly sharing your use case and participate in this
constructive discussion :)

[1] https://lore.kernel.org/20250717055448.56976-1-sj@kernel.org


Thanks,
SJ

[...]
