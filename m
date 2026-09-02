Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4D4A8417;
	Wed,  2 Sep 2026 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362158; cv=none; b=kjx0xVeRXtVL3zJKFNQa0wvbyFs7AiNfLJ5m0O9pxgtGbi6cCEFUrTdosETRXnuVo8nK9NiH/r8+kiFapteIV4QNK1rYXTEPGKQpac6fNlVASSPvyNtz7s/e0D5f6oiibdEYMnfjYPpYzdECjNEiviOKjSn7qaArCjL0ZiqgKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362158; c=relaxed/simple;
	bh=C7GlblV3lduW5pRJ+8PzT7e2DgNLYOtJRCEzpWBM+xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppKpGfFGwB230p8WMuqLj6Q2u30LRkWLllSozg/rGahJHwZU602CwKDY8W90jMPSZlwQdgIobMKY0aMGKjmJlCuG4z2iCamTtt7BxKorK3uqbAXu1EuVK/jnRF8v2l2TYT1mmhaqZQxOEMMLNoaSJEAg9/hC+Y3VnVd63u+HO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKE/XKpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKE/XKpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CEF1F000E9;
	Wed,  2 Sep 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362155;
	bh=vE/Cggwy78pImngvxsbAxzUqhSZmdOdF6pnB66mIkJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKE/XKppWbSzjEt/knKYntQMNUjU3xxyGzG/qqWR+NjqD77xwNrloFoFmpEUo0H42
	 roqpGnzg/ZLZSqyjVveOpTZCbABjNrSjLZSWz7qyeQNTfHZT+bzmgpID1DYDQ/kCtX
	 aehIQzFzOxyaKZX8vE86cvy1wKe8GVf2THmdarEShk9FErMaLsEroyi1y7nSTrZGkM
	 mTb6qKQSPEah//6s9yXgPifJZ9QYU7LkeavHkqOkGj1b8M2cOMO5TmoUkoyR0pt++p
	 wiPnM9goFqsFH7vGYwOKMYLBeb1N6bnbPenlz7dGCKZxumg8CeTDclFwx39Bk33cAp
	 16Ex83MlBaJiA==
From: SJ Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SJ Park <sj@kernel.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Wed,  2 Sep 2026 08:15:48 -0700
Message-ID: <20260902151548.88735-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9ac2a10f-1551-410e-a9c0-173a1daeb1ab@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 18:03:39 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> Hi SJ and Lian,
> 
> On 9/1/2026 5:23 PM, SJ Park wrote:
> > Hi Lian,
> > 
> > On Tue,  1 Sep 2026 14:58:35 +0800 Lian Wang <lianux.mm@gmail.com> wrote:
> > 
[...]
> >> Second, the metric is global while a DAMOS scheme can target one process.
> > 
> > Actually it can target multiple processes if those are in single DAMON context.
> > 
> >> THPs from other processes or NUMA nodes can satisfy the target or dilute the
> >> monitored process's changes.  Is this intentional?
> > 
> > I think it is intentional.  The user should have the control on collapsing
> > hugepages, or believe the uncontrolled collapse mechanisms.
> > 
> >> If so, documenting the
> >> scope and testing a background THP workload may be useful.
> > 
> > More documentation and testing are always welcome :)
> > 
> >>
> >> The temporal results approach the 10% and 25% targets, while the consistent
> >> results overshoot the 10% target to about 20% and 45%.  I would describe this
> >> as control-response data.  TPS, latency, TLB, fragmentation and collapse CPU
> >> data could further show the workload benefit and cost.
> > 
> > Yes, those would be helpful.  That's not mandatory for this simple change in my
> > opinion, though.  I would let Asier decide whether and when to make and share
> > such data.
> The idea of this patch was to introduce auto tuning. I think I submitted thebenchmark results when I sent the DAMOS_COLLAPSE feature.
> 
> Anyway, it shouldn't take long for me to get more data. I think it may be useful
> for people to know the actual results in real application.
> 
> SJ, what's the best place to publish all those data? I believe you have more
> experience sharing this data and which platform is the most useful one.>>

I'm never an expert in visibility :)  But if I should recommend, I get three
places off the top of my head.

First, you could simply share the data with plain mail on DAMON and wider
kernel mailing lists like linux-mm@ and linux-kernel@.

Second, if the data is matured, sharing those in conferences like LPC,
OSSummit, FOSDEM or DAMON (nano) Conference would be nice.

Third, if you prefer text, LWN or personal blogs like medias could also be good
places.  I also maintain DAMON porject blog [1].  Kunwu and Lian actually
contributed an article to the blog before.  If you want to submit an article
there, let me know.

[1] https://damonitor.github.io/posts/
[2] https://damonitor.github.io/posts/tlb_flush_policy/


Thanks,
SJ

[...]
