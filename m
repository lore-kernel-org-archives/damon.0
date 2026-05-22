Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B720ADF8;
	Fri, 22 May 2026 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417758; cv=none; b=qS23+0Ink22CFAk6pOBjRcioT8JZy5wTdkYFKRODQZI9W9jxmuldN3S6yJgrPP/FEx/UZwNN94jiqqJVLAlrckoLTjJPOyHtmg3+rpCfo8mbc6fZHQ2LTr0u/GCxckksJWr75B59HXdbkyITk9YS9I1GXHCLc5PMk86BQRFQxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417758; c=relaxed/simple;
	bh=Qj7m5dQ92BHZtfyrERkLS8iAMfCOGOFVVbmhnyzGszo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYsblVA8x06aFnZNz4YTOTrCrjSsh/CfegfyCtviB5k9qVwaHz/Xf2yNf/3VprBrVWqP/ocncfipgUsOzXfRNnvwnSBkxtMmOKHCm3QuKlCn2LQy8N3AfiMzliNM1lxepTpo0YBaYWJ+/gftL7oKKfhjKtP/rBVcEMU5Qo8zDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9O80Nsj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9O80Nsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A911F000E9;
	Fri, 22 May 2026 02:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417757;
	bh=UfaKm7/ffChZJckI3+fZbp1IlqqOKUAIq6IoYDmzaVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9O80NsjEeGKhmccQwt1t/+jRv+G3YUBl9ucxh8w4IYjc6ZLDLk8NAHsqnpYeKCHq
	 Wc7m7hLBHuRnzeVYhK9cALdTwu/kbCN0+KoWvtkq9ywuGneOK2S2ra/jVCLGLMMVfs
	 d6Fz1884Waxnlnppcn46gthfOeKPCRDk+adi4jAcahF20U3eotYgX6e7S23m2+VkWN
	 Ug1fJJQmoWIk07kiaC+nXEGFtsVgKOp8fO/OXNt6ki9XJkaGvoZngaQHaLaHged1bg
	 id4M6ZeqAkoodqwQXPPxRZb+9JNKuvSmi+QFLKkQ7aivP5MCG9cMrOboC/Z2OlzJhM
	 gBVxZXufJQ2OA==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/damon/core: detect internal variation above max_nr_regions/2
Date: Thu, 21 May 2026 19:42:26 -0700
Message-ID: <20260522024228.87328-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <26baec2e-bc11-4042-8f61-0b3f7fe1c3b1@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 23:07:11 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> Hi SJ,
> 
> Thanks for taking a look.  Quick replies inline.
> 
> 
> On 5/21/26 10:30 PM, SeongJae Park wrote:
> > Hello Jiayuan,
> >
> > On Thu, 21 May 2026 12:52:22 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >> kdamond_split_regions() bails out early when nr_regions is already
> >> above max_nr_regions / 2.  A large region that picks up new internal
> >> variation after that point never gets split, so we lose visibility
> >> into its hot/cold structure.
> >>
> >> We hit this with damon-paddr on hugepage workloads and damon-vaddr
> >> on processes that mmap a large anonymous range.
> >>
> >> On our production tree we added a current_nr_regions counter (no
> >> good upstream home for it yet, so it's not in this series).  We saw
> >> nr_regions never getting close to max_nr_regions, and the picture of
> >> the access pattern was too coarse.
> > Is 'current_nr_regions' somewhat showing the number of DAMON regions?  If so,
> > you could also get the information from nr_regions field of damon_aggregated
> > tracepoint.  I'm wondering if you considered using that but found a problem
> > that made you have to implement the internal change.
> >
> > I will be happy to help removing such downstream changes.
> 
> 
> Yes, same data as the nr_regions field in damon_aggregated.  The downstream
> 
> counter was just for convenience -- easier to cat a sysfs file than to wire
> 
> up tracing.  Even the tracepoint covers it, It's cost to much for 
> Grafana to just get
> 
> a metrics by tracepoint.

Makes sense.  And I think this deserves to be upstreamed.  Some minor
modifications might be needed to your current implementation, though.  Please
feel free to send a patch to start the discussion, if you want.

> 
> 
> >> Example with max_nr_regions == 1500.  A target ends up with 799
> >> small hot/cold regions plus one big region (an earlier merge
> >> collapsed a uniformly-accessed range into a single piece):
> >>
> >> H:hot
> >> C:cold
> >>
> >>        r1     r2     r3                 r800
> >>      HHHHHH|CCCCCC|HHHHHH|...|HHHHHH..........................|
> >>
> >>      nr_regions = 800  >  max_nr_regions / 2 = 750
> >>
> >> Now a cold subarea shows up inside r800:
> >>
> >>        r1     r2     r3                 r800
> >>      HHHHHH|CCCCCC|HHHHHH|...|HHHHHH........CCCCCC.............|
> >>
> >> The small regions can't merge with each other (their access counts
> >> differ), so budget never frees up.  r800 can't be split because
> >> nr_regions > max_nr_regions / 2 returns early.  The cold subarea
> >> stays invisible.
> > I agree this corner case could theoretically happen.  But, would the small
> > regions have the current pattern forever?  On real world systems having dynamic
> 
> 
> I agree with the point that this is a corner case. But it's not 
> transient for us.

Thank you for sharing this nice information.

> 
> On a production setup with max_nr_regions = 20000, nr_regions sits at 
> 11k-12k
> 
> for extended periods. There are occasional bursts (e.g. from offline 
> pods), then things settle
> 
> back without ever reclaiming the budget.

Could you please clarify a little bit more?  What is the occasional bursts, and
how offline pods contribute to that?  What "reclaiming the budget" means?

Also, do you have some measurements that shows this problem and how much of it
is removed by this series?

> 
> 
> > access pattern, I guess those small regions may not keep the shape forever, and
> > give chance for the large region to be split.  Am I missing something?
> >
> > My theory also implies that this kind of situation could happen at least
> > sometimes for temporal periods.  In other words, it could happens too
> > frequently and too long to be problematic.  But, in the case, maybe the user
> > could mitigate the issue by increasing the max_nr_regions.  I'm curious if you
> > considered that direction and found a problem that I don't expect for now.
> >
> >> Patch 1 lets this path still split regions that just changed
> >> (age == 0),
> > Why 'age == 0' means it is a good candidate to split?  Because it means its
> > access frequency is anyway unstable?  Or are there other reasons?  More
> > clarification would be helpful.
> 
> 
> Yes, age == 0 means the region's access count drifted past the merge 
> threshold in
> the last aggregation -- the strongest signal it just changed internally.
> Regions with age > 0 are stable; splitting them tends to oscillate (the next
> merge cycle pulls the halves back together and we waste the budget).

Thank you for confirming this.  Yes, that sounds good approach to me.  But
because this is a core behavior, I'd like to be careful more than usual.  I
will spend more time at thinking if I'm missing something, and if this is the
best approach.  If you have measurements that I asked above and can share, that
will also be helpful.

> 
> >
> >> up to whatever budget is left under max_nr_regions.
> >> If a split turns out useless, the next merge cycle undoes it.
> > I'm again curious why the user cannot just increase max_nr_regions.
> 
> It works as a workaround, but it isn't free: higher max means more sampling
> work and more memory,

It would depend on the real number of distinct access patterns.  I understand
the number is really high on your use case.  Again, if you have measurements
and could share, that will be very helpful.

> and 20000 is the ceiling we actually want to live
> with.  Bumping to 30000 just so the splitter has room to make progress
> between max/2 and max is wasteful -- we don't actually want to spend the
> resources for 30000 regions.

Makes sense.

> 
> The real issue isn't budget waste, it's that once nr_regions crosses max/2
> the splitter has no recovery path -- it returns immediately even when 
> there's
> variation worth refining, and merges don't help because the small regions
> have different access counts.  nr_regions just sits between max/2 and max,
> and new variation inside a large region goes undetected.  The patch gives
> that path a way to keep refining within whatever budget remains, instead of
> asking users to over-provision max.

Yes, I agree.  Nonetheless, as I mentioned above a couple of times, if you have
and could share measurements that showing how big the problem is and how much
of it this change can solve will be very helpful.


Thanks,
SJ

[...]
