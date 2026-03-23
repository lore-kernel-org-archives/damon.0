Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F533328FA;
	Mon, 23 Mar 2026 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774310085; cv=none; b=tN/aveN8815cCuxVGBmBeS1kFEqDdaPmwg0D5T35PBFWKbNe8ZtNIMKlTONwEDZleIlD9V9gEQ7hyZdcdRI9l9oFLgIDH1vPHKcNvnq0fliWrCmJcoV0BZgYk6Dft0pq5T1/MGvHe8JtbO4frN7D3H4GFdpnm1rFnRi+2TIfYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774310085; c=relaxed/simple;
	bh=+j/Q0T6wecgob98wFExGgY24lat6lW97XRFNsp8RiPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBgvS7KQf40WsNkWr/GyMFBVLMBOoB8yNfJR29f4atbA4KNLz5YH0I0Buz15UtQHFdAZP4E12Y9D9vDGZi651md3QGn8UStYnp23vXWdcJ+ab2BOl1CYew+J2nUKMYzepB6Ka16h47qZYlonR8fgsqSTfkazFKkEnJh+ZAg9zIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEW2HKlb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEW2HKlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4527C4CEF7;
	Mon, 23 Mar 2026 23:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774310085;
	bh=+j/Q0T6wecgob98wFExGgY24lat6lW97XRFNsp8RiPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEW2HKlb2Z5QQzMHbK/Pdm1Mi1c/bF3SbtB7SgiZ/brk5Nl65EWyWHpXfxQjSFQ5r
	 mDHb/G2qM/wGXV6Q3z1wEWc9jG/ujC6BdOws+Ec+LReGHP0HN5YwDE9AnmbrmGVxW3
	 eVO4JE9DjBFllH7uW/yj9MgGGCmKQR0Nro+r/7uUHYRh1LYFzhlY/kcT3shHBXshM7
	 kLoDYvsh72AaxawYyOqFBB4pmRyL7T268KDA9eZukUfTnny45csqfEBK7d1g3JGq2M
	 WOyiJD4mTIvu1EybGVlSnej1G8XSvZnZDvqQ6LPsFKdnsylvsOfWEWUaCRAanIrbMN
	 jeNkqOZr/fBEA==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v4 1/1] mm/damon: add node_eligible_mem_bp and node_ineligible_mem_bp goal metrics
Date: Mon, 23 Mar 2026 16:54:36 -0700
Message-ID: <20260323235438.85953-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALa+Y16i0f5D_ZTVcfVa1DgeZL1btvUJxjOvoyFEYNkT7K-grg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Mar 2026 12:41:42 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> On Sat, Mar 21, 2026 at 9:54 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 20 Mar 2026 12:04:53 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:
> >
> > > Add new quota goal metrics for memory tiering that track scheme-eligible
> > > memory distribution across NUMA nodes:
> > >
> > > - DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP: ratio of eligible memory on a node
> > > - DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP: ratio of eligible memory NOT on
> > >   a node
> >
> > The description for the second metric should be "ratio of ineligible memory on
> > a node".
> >
> 
> Got it. Will fix the commit message.
> 
> > >
> > > These complementary metrics enable push-pull migration schemes that
> > > maintain a target memory distribution across different NUMA nodes
> > > representing different memory tiers, based on access patterns defined
> > > by each scheme.
> > >
> > > The metrics iterate scheme-eligible regions and use damon_get_folio()
> > > to determine NUMA node placement of each folio, calculating the ratio
> > > of eligible memory on the specified node versus total eligible memory.
> > >
> > > Suggested-by: SeongJae Park <sj@kernel.org>
> > > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > > ---
> > >  include/linux/damon.h    |   6 ++
> > >  mm/damon/core.c          | 158 ++++++++++++++++++++++++++++++++++++---
> > >  mm/damon/sysfs-schemes.c |  12 +++
> > >  3 files changed, 164 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > index b1d8fd88a0fc..490918804f85 100644
> > > --- a/include/linux/damon.h
> > > +++ b/include/linux/damon.h
> > > @@ -193,6 +193,10 @@ enum damos_action {
> > >   * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:  MemFree ratio of a node for a cgroup.
> > >   * @DAMOS_QUOTA_ACTIVE_MEM_BP:               Active to total LRU memory ratio.
> > >   * @DAMOS_QUOTA_INACTIVE_MEM_BP:     Inactive to total LRU memory ratio.
> > > + * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:        Scheme-eligible memory ratio of a
> > > + *                                   node.
> > > + * @DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:      Scheme-ineligible memory ratio of a
> > > + *                                   node.
> > >   * @NR_DAMOS_QUOTA_GOAL_METRICS:     Number of DAMOS quota goal metrics.
> > >   *
> > >   * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
> > > @@ -206,6 +210,8 @@ enum damos_quota_goal_metric {
> > >       DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
> > >       DAMOS_QUOTA_ACTIVE_MEM_BP,
> > >       DAMOS_QUOTA_INACTIVE_MEM_BP,
> > > +     DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > > +     DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
> > >       NR_DAMOS_QUOTA_GOAL_METRICS,
> > >  };
> > >
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index b9e12865622c..3e0ac65e34a0 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -17,6 +17,8 @@
> > >  #include <linux/string.h>
> > >  #include <linux/string_choices.h>
> > >
> > > +#include "ops-common.h"
> > > +
> >
> > I don't find a reason to include this, and I'd like to avoid including that in
> > core.c unless it is really necessary.  Could you please remove this?
> >
> 
> The include was added because the implementation uses damon_get_folio() to
> determine NUMA node placement of folios when iterating eligible regions.

Thank you for clarifying, Ravi.

> Would you prefer that I move the damon_get_folio() declaration to
> include/linux/damon.h, or would you suggest a different approach such as
> adding an ops callback for the node calculation?

I'd like to keep it mm/damon/ internal if possible.  Maybe adding new files,
say, mm/damon/common.{c,h} is one option.

Just keeping it as is for now with clarification comment (e.g., "including
ops-common.h for damon_get_folio()") for now, and revisiting for cleanup in
future could also be another option.

I slightly prefer the second option at the moment.

> 
> > Below looks all good for RFC level code to move on to the next stage (dropping
> > RFC tag). :)
> >
> 
> Thank you, SJ! Will send v5 with fixes once I hear back on the above.

Sounds good, looking forward to!


Thanks,
SJ

[...]
