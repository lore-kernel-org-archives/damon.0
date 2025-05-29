Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230D4315C;
	Thu, 29 May 2025 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537172; cv=none; b=i46xqYHkdbN16DP1BH1SjK23Q/53C++gj8RAttrcrfPp74A0iIYH50qZ//5K9pYjnqN3arBlvt+wxPZDLToOR/43kovHvdaCv3Kqb7/mDC5YOXHYoWYI3QIcanlrhOb009fXF8LBzjxhos+jgOoN80UPQ+GWYMVCuJjHzwE9fSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537172; c=relaxed/simple;
	bh=D7pFpHFbd8b9b6GPBLqRyR4yWUChqilaV2dAhA1yxo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0DMWm5i8fmhdxIlXhGYjw8eF+7n7Uezg2aVf32hCHM5Q2e2P4jOkJsZQrLDYKLyy2ZbD/RcGOn9vEd//G5Hc9H97F/HjqKIhmkkSepuHc9QaDJv7MM+lVV70ZStGGCicq/eN+3RHf7cdo7L2v7a5adWd6LFEObqdZgxd8Y44x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNoXC0Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNoXC0Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885A7C4CEE7;
	Thu, 29 May 2025 16:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748537171;
	bh=D7pFpHFbd8b9b6GPBLqRyR4yWUChqilaV2dAhA1yxo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNoXC0Of+W7Rlb+xYYkg3fguM3Ih+wwonXIIsuIBtTQeRJo1TEv/jHK6sZnKfNYdf
	 LOMl8AT6R32sh6g52AooPSC/bIiTLuFNcNfRS/s0blF85OCFqZfUpmehCWTQvcNBqb
	 Hnz7JTFEVWlmLzgMEof8ArMJWttIO6/nxclfsqGWzq3P0KJA+GKs5c/wPClYpwTlsq
	 v1RGqE/vlAhJwrN7UTsBBazzogD5awz+FGTOK926cOZpWVOOuhK7EBzrJuLZNSROzB
	 h5E6p0BBlUedujtByc8GPSauywi2KcuFq+Zu5zg8vAZPEUz5ku9m29iqS7nZLcaZIN
	 iDTwrDY8wBkQQ==
From: SeongJae Park <sj@kernel.org>
To: Simon Wang <wangchuanguo@inspur.com>
Cc: SeongJae Park <sj@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Thu, 29 May 2025 09:46:08 -0700
Message-Id: <20250529164608.37594-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <a3f041d817534652a3e1e6545432016b@inspur.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 29 May 2025 03:12:13 +0000 Simon Wang (王传国) <wangchuanguo@inspur.com> wrote:

> > > This patch adds use_nodes_of_tier under
> > >
> > /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
> > >
> > > The 'use_nodes_of_tier' can be used to select nodes within the same
> > > memory tier of target_nid for DAMOS actions such as
> > DAMOS_MIGRATE_{HOT,COLD}.
> > 
> > Could you please elaborate in what setup you think this option is useful, and
> > measurement of the usefulness if you have?
> > 
> > I'm asking the above question because of below reasons.  My anticiapted
> > usage of DAMOS_MIGRATE_{HOT,COLD} is for not only memory tiering but
> > generic NUMA node management.  And my proposed usage of these for
> > memory tiering is making per-node promotion/demotion for gradually
> > promoting and demoting pages step by step between node.  It could be slow
> > but I anticipate such slow but continued promotion/demotion is more
> > important for reliable performance on production systems of large time scale.
> > And I believe the approach can be applied to general NUMA nodes
> > management, once DAMON is extended for per-CPU access monitoring.
> > 
> > I'm not saying this change is not useful, but asking you to give me a chance to
> > learn your changes, better.
> 
> I believe some users may want to ​​use only the target node's
> memory​​ and reserve other nodes in the same tier for specific
> applications. Therefore, I added a switch file use_nodes_of_tier.

Thank you for clarifying, Simon.

Because this is an ABI change that difficult to revert and therefore we may
need to support for long term, I'd like to have more clear theory and/or data
if possible.  In my humble opinion, above clarification doesn't sound like a
strong enough justification for ABI change.

More specifically, it would be better if you could answer below questions.  Who
would be such users, how common the use case would be, and what are the benefit
of doing so?  Is that only theory?  Or, a real existing use case?  Can you
share measurement of the benefit from this change that measured from real
workloads or benchmarks?  Is there an alternative way to do this without ABI
change?

> I think it might be better to set the default value of use_nodes_of_tier to
> true (i.e., allow using fallback nodes). What do you think

In my humble opinion, we can consider setting it true by default, if we agree
the benefit of the change is significant.  With only currently given
information, I cannot easily say if I think this can really be useful.  As
asked abovely, more clear thoery and/or real data would be helpful.

> 
> > >
> > > Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
> > > ---
> > >  include/linux/damon.h        |  9 ++++++++-
> > >  include/linux/memory-tiers.h |  5 +++++
> > >  mm/damon/core.c              |  6 ++++--
> > >  mm/damon/lru_sort.c          |  3 ++-
> > >  mm/damon/paddr.c             | 19 ++++++++++++-------
> > >  mm/damon/reclaim.c           |  3 ++-
> > >  mm/damon/sysfs-schemes.c     | 31
> > ++++++++++++++++++++++++++++++-
> > >  mm/memory-tiers.c            | 13 +++++++++++++
> > >  samples/damon/mtier.c        |  3 ++-
> > >  samples/damon/prcl.c         |  3 ++-
> > >  10 files changed, 80 insertions(+), 15 deletions(-)
> > 
> > Can we please make this change more separated?  Maybe we can split the
> > change for memory-tiers.c, DAMON core layer, and DAMON sysfs interface.
> > That will make review much easier.
> 
> Yes,I'll split this patch to be 2 patches.

Thank you for accepting my suggestion.  But I think it deserves 3 patches, each
for

- memory-tiers.c,
- DAMON core layer, and
- and DAMON sysfs interface.

But, let's further discuss on the high level topic (if this change is really
beneficial enough to make ABI change).


Thanks,
SJ

[...]
