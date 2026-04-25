Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84162288CB
	for <damon@lists.linux.dev>; Sat, 25 Apr 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777090751; cv=pass; b=uTCBgVa7rRacE+wHpT7uWCN8ECHhHi2SLefJbL5fb+JFBZdz8UgzxoT4kpXoMP2GXHixRktDA5iezG+J2850yC+E4rkD4936CGuyHVxgRCc20JX5arD63h/a26YalRJkjZpYzBxBpcQ0vbFKMO92Umbbkw1myp4pL1WgftKvo4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777090751; c=relaxed/simple;
	bh=DAexoANLnIWDOBI1bXoIwZ9eIqY3lVLujOBaj4ggrVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTqq+48yDggWiW154kM9JlhH4H3NXTlog+ryjZLmZEbLDy+DVqmibin+rXWbXaBI6/q6he7/AzClu6CRZmSHsw0S7KdQJWOlOTN4YDyr9eyNBg/arA1Uh8e6fSCyxOgXg6Na7j3lyCRu79UbYTKnMBwcd+2XTmWiuBkO2nSWkd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb0nkYr0; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb0nkYr0"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c726f46baso10654494c88.1
        for <damon@lists.linux.dev>; Fri, 24 Apr 2026 21:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777090749; cv=none;
        d=google.com; s=arc-20240605;
        b=UEtcGoDAjA55tTaDVI3AGfWuYwTJyUJuGx3l1jwBNaNLz+9oIwJ5ctvU18smJDgMDh
         yxI8uBPdEuG/nPqJqbsI0H9f/feTH7VMyAnZ61yA2ZlK0LFM8B37I+r3xD7HqpNBDKgF
         DSaxQjm0TERgZztcab9w2+Xov+36wiYe+xQphq43zcEn15iwWBI8Bd/RHeFmu1BKKywW
         40qZlnS+hbgM+irswCj4II0T19atiN32DyZ+nR1ym0wfIXay+PsvBAF1hQvUfmx2wTwS
         +eAMl64WyJCTZZkgvSewRfDEfbCNqB1apS+SG6y/Wdemx2YIZ2O2WVjhapXOeNMVO0r7
         m/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ED6LRizb0aLegQxmqSHHiWjesUTMCbbsMRIvv4Qgi/U=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=jDUNMav7uLHppdwK7m+Nbt1sucb5Ue8sHf/2G4nNIvVs3ijP4JF82SCToUjZ3zKbjI
         8mWoknXdS1yguh/qjm+X463Cls+/AK+g8u/zZjVkS/cCExFYL6DGRZYcxBgfNOtQJpVJ
         NHRy6FHEwsPK8Ao0OHsszhs13/PUf5Yn+OqPKEh0Gp7fhUBxgnH9oJdYin9w5XhACjQo
         sl5hmICkdxqrUqfk1acvwLYBv8hBdUjUu474G7ESHCETU9k1PpDQiypZ8VqCO8aarExx
         nVJ+4nNPqY8leYweb22Mx8qO7pXhdCkRKIR3z8k1KyZNvrAMv/ltC7YfyRzv+VMxIezH
         Bc7g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777090749; x=1777695549; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED6LRizb0aLegQxmqSHHiWjesUTMCbbsMRIvv4Qgi/U=;
        b=Kb0nkYr0BGWiPlLGhc2CcHHlZ56PsBXPLcSi7pafK30K4qN3YubdAPMfuKViZlYH9C
         kmcoL2CZz/aWWvNUS7fvGH8jEppzJqtvMz324zJMMrX3QMybzrEUk4IXiIoY8cOdeD9j
         xzFZzeM5UaLusgS4ReFZmwTkf8e7cIPSTy767+ENpmZ0IPkhPK7wmLrY0vaC38h6m90J
         UxoeT0pXts+NqTp4a4++7P+8hQULOctdjBRQHG0PgJxy6aRrVKUxZqsbNLQMRdm4qX8G
         He+pBBheLpLnG7gg4GODuSVJmQr3e2jz7BrDCJgC1odM6KC7xiTDoEZMDeFvhCmakAPY
         K/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777090749; x=1777695549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ED6LRizb0aLegQxmqSHHiWjesUTMCbbsMRIvv4Qgi/U=;
        b=LK3nTKOocN9/IC4Xs8OiGiNRUX3MiwlfwhseT9Q8h+0PsgcDpuVYy46kQ6MDOJ8+nK
         1OrXQH22TKpSkeo0jkbRFnlxAmZhj5aQbDzMN4JWnWqLR+8xbPJLDHeqXAJEV2dNl/sU
         9IT9Jb9KQtkotjwbEhZMMxNlc3wXYsPNgVei/COe9byTp+xxx4TY+6IY7l83qTwTrreN
         WXW7H4kK1p5WdoAsArr7UEyjNVzrHUKvfgzDORnDUWRZXYhr/YhJkLG+dmCHu36Fhq2R
         jLK+H6bek3KTF+x3cdovPxEfsqjbGcjg0NxvD+6CXzxHd83BWJ7KQ7RJemKXIBMR8RDl
         ESmQ==
X-Gm-Message-State: AOJu0YzZwOr46eB5I/Dh4I2sUeNg0tUBZhDMV04HJL5p9Q8s0QD3x+5V
	YIQJ/uPnpSLsCW4GzeBG5oE6vSC2OxhCF/RHcElBnzLrIAyLVq75PXwE8X2KbyQxpO52VCp7BAW
	80lJWnUqGRz2AUtO/v67eOOMPy0Z42Q==
X-Gm-Gg: AeBDietTA6P38i0lEIb4HXSEzBdH0HWG/IzGKfWA8e3MnmBfwgYXm28jnpzKnWuy/gw
	83WstX3gr3XKrrZEyRFJEkXa3mmR73ADdLYpLt1qmD/+rJCf0xJenexbKN+cpc3iDv/JR8B39v+
	WXjFrDiWsU/27kUd+oqCxW3PYr/rQoi3q+Bq3eifadwmnYcK5n3shMCwkkxumxAifL0d+QI7y+S
	JL+soH4pYnOr1Q/9Vzq5MWlSbT4j5pgA2MONnfWjpxgRLn5QWxFpZVOXEBM98dqY9Ij8q2xFGDM
	LKlLwzI4uO1mQpRJJMM=
X-Received: by 2002:a05:7022:2602:b0:128:d23d:81a2 with SMTP id
 a92af1059eb24-12c73f9ae5cmr17700641c88.29.1777090748581; Fri, 24 Apr 2026
 21:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424203448.5040-1-ravis.opensrc@gmail.com> <20260425003942.85395-1-sj@kernel.org>
In-Reply-To: <20260425003942.85395-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 24 Apr 2026 21:18:57 -0700
X-Gm-Features: AQROBzARRfoADW7Jx4sGujVnRXtL7JrOvvV0-SJLi2_UI7JAVotqOQR2kydBN3s
Message-ID: <CALa+Y16VuXb2DfeiBiE5avpEsqGVfc6DAKZWacNsu-1hD51hMQ@mail.gmail.com>
Subject: Re: [PATCH v7] mm/damon: add node_eligible_mem_bp goal metric
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 5:39=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello Ravi,
>
>
> This version looks good, except very trivial nits.

 Hi SJ,

  Thanks for the super quick review! Very helpful.

>
> On Fri, 24 Apr 2026 13:34:48 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Background and Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > In heterogeneous memory systems, controlling memory distribution across
> > NUMA nodes is essential for performance optimization. This patch enable=
s
> > system-wide page distribution with target-state goals such as "maintain
> > 60% of scheme-eligible memory on DRAM" using PA-mode DAMON schemes.
> >
> > Rather than using absolute thresholds, this metric tracks the ratio of
> > memory that matches each scheme's access pattern filters on a target
> > node, enabling the quota system to automatically adjust migration
> > aggressiveness to maintain the desired distribution.
> >
> > What This Metric Measures
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > node_eligible_mem_bp:
> >     scheme_eligible_bytes_on_node / total_scheme_eligible_bytes * 10000
> >
> > The metric iterates through each scheme's eligible regions and uses
> > damon_get_folio() to determine NUMA node placement of each folio.
> >
> > Two-Scheme Setup for Hot Page Distribution
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > For maintaining hot memory on DRAM (node 0) and CXL (node 1) in a 6:4
> > ratio (per SeongJae Park's suggestion):
> >
> >     PULL scheme: migrate_hot to node 0
> >       goal: node_eligible_mem_bp, nid=3D0, target=3D6000
> >       "Move hot pages to DRAM if less than 60% of hot data is in DRAM"
>
> You also set a damos filter of node type with node id 1 for this scheme, =
right?
>
> >
> >     PUSH scheme: migrate_hot to node 1
> >       goal: node_eligible_mem_bp, nid=3D1, target=3D4000
> >       "Move hot pages to CXL if less than 40% of hot data is in CXL"
>
> And you set damos filter of node type with node id 0 here, right?
>
> I think it would good to mention that here, too.
>

 Good point. I'll add a note explaining that each scheme uses DAMOS
addr filters
  to restrict the source node - PULL uses an addr filter for node 1's
address
  range, and PUSH uses an addr filter for node 0's address range.

> >
> > Each scheme independently measures its own eligible memory and adjusts
> > its quota to achieve its target ratio. The schemes work in concert
> > through DAMON's unified monitoring context, with the quota autotuner
> > balancing their relative aggressiveness.
> >
> > Implementation Details
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Key implementation considerations:
> > - Uses phys_addr_t for byte calculations to prevent overflow on 32-bit
> >   architectures with large memory configurations
> > - Includes cond_resched() per region to prevent CPU soft lockups when
> >   processing large numbers of regions
> > - Validates that ops type is DAMON_OPS_PADDR in both damon_commit_ctx()
> >   (for clear error feedback) and the metric function (defensive check)
> > - Properly handles folio alignment when region addresses fall within
> >   large folios by calculating exact overlap
>
> This is changelog from the previous version [1], right?  Let's put all
> changelog from all previous version on the commentary area [2].
>

Understood. Will move this to the commentary area and include the
full changelog history from RFC v1.

> >
> > The implementation requires CONFIG_DAMON_PADDR since damon_get_folio()
> > is only available for physical address space monitoring.
> >
> > Testing Results
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Functionally tested on a two-node heterogeneous memory system with DRAM
> > (node 0) and CXL memory (node 1). A PUSH+PULL scheme configuration usin=
g
> > migrate_hot actions was used to reach a target hot memory ratio between
> > the two tiers.
> >
> > With the TEMPORAL tuner, the system converges quickly to the target
> > distribution. The tuner drives esz to maximum when under goal and to
> > zero once the goal is met, forming a simple on/off feedback loop that
> > stabilizes at the desired ratio.
> >
> > With the CONSIST tuner, the scheme still converges but more slowly, as
> > it migrates and then throttles itself based on quota feedback. The time
> > to reach the goal varies depending on workload intensity.
> >
> > Note: This metric works with both TEMPORAL and CONSIST goal tuners.
> >
> > Suggested-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/linux/damon.h    |   3 +
> >  mm/damon/core.c          | 171 +++++++++++++++++++++++++++++++++++----
> >  mm/damon/sysfs-schemes.c |   7 ++
> >  3 files changed, 165 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index f2cdb7c3f5e6..986b8c902585 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -159,6 +159,8 @@ enum damos_action {
> >   * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:  MemFree ratio of a node for a cgr=
oup.
> >   * @DAMOS_QUOTA_ACTIVE_MEM_BP:               Active to total LRU memor=
y ratio.
> >   * @DAMOS_QUOTA_INACTIVE_MEM_BP:     Inactive to total LRU memory rati=
o.
> > + * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:        Scheme-eligible memory ra=
tio of a
> > + *                                   node in basis points (0-10000).
> >   * @NR_DAMOS_QUOTA_GOAL_METRICS:     Number of DAMOS quota goal metric=
s.
> >   *
> >   * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsup=
ported.
> > @@ -172,6 +174,7 @@ enum damos_quota_goal_metric {
> >       DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
> >       DAMOS_QUOTA_ACTIVE_MEM_BP,
> >       DAMOS_QUOTA_INACTIVE_MEM_BP,
> > +     DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >       NR_DAMOS_QUOTA_GOAL_METRICS,
> >  };
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff71..4ac805205261 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -13,10 +13,14 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/mm.h>
> >  #include <linux/psi.h>
> > +#include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/string_choices.h>
> >
> > +/* for damon_get_folio() used by node eligible memory metrics */
> > +#include "ops-common.h"
> > +
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/damon.h>
> >
> > @@ -1326,11 +1330,25 @@ static int damon_commit_targets(
> >  int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> >  {
> >       int err;
> > +     struct damos *scheme;
> > +     struct damos_quota_goal *goal;
> >
> >       dst->maybe_corrupted =3D true;
> >       if (!is_power_of_2(src->min_region_sz))
> >               return -EINVAL;
> >
> > +     /* node_eligible_mem_bp metric requires PADDR ops */
> > +     if (src->ops.id !=3D DAMON_OPS_PADDR) {
> > +             damon_for_each_scheme(scheme, src) {
> > +                     struct damos_quota *quota =3D &scheme->quota;
> > +
> > +                     damos_for_each_quota_goal(goal, quota) {
> > +                             if (goal->metric =3D=3D DAMOS_QUOTA_NODE_=
ELIGIBLE_MEM_BP)
>
> Let's wrap this line to keep the 80 columns limit.

Will wrap this in v8.

>
> > +                                     return -EINVAL;
> > +                     }
> > +             }
> > +     }
> > +
> >       err =3D damon_commit_schemes(dst, src);
> >       if (err)
> >               return err;
> > @@ -2287,7 +2305,112 @@ static unsigned long damos_get_node_memcg_used_=
bp(
> >               numerator =3D i.totalram - used_pages;
> >       return mult_frac(numerator, 10000, i.totalram);
> >  }
> > -#else
> > +
> > +#ifdef CONFIG_DAMON_PADDR
> > +/*
> > + * damos_calc_eligible_bytes() - Calculate raw eligible bytes per node=
.
> > + * @c:               The DAMON context.
> > + * @s:               The scheme.
> > + * @nid:     The target NUMA node id.
> > + * @total:   Output for total eligible bytes across all nodes.
> > + *
> > + * Iterates through each folio in eligible regions to accurately deter=
mine
> > + * which node the memory resides on. Returns eligible bytes on the spe=
cified
> > + * node and sets *total to the sum across all nodes.
> > + *
> > + * Note: This function requires damon_get_folio() from ops-common.c, w=
hich is
> > + * only available when CONFIG_DAMON_PADDR is enabled. It also requires=
 the
> > + * context to be using PADDR operations for meaningful results.
> > + */
> > +static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
> > +             struct damos *s, int nid, phys_addr_t *total)
> > +{
> > +     struct damon_target *t;
> > +     struct damon_region *r;
> > +     phys_addr_t total_eligible =3D 0;
> > +     phys_addr_t node_eligible =3D 0;
> > +
> > +     damon_for_each_target(t, c) {
> > +             damon_for_each_region(r, t) {
> > +                     phys_addr_t addr, end_addr;
> > +
> > +                     if (!__damos_valid_target(r, s))
> > +                             continue;
> > +
> > +                     /* Convert from core address units to physical by=
tes */
> > +                     addr =3D (phys_addr_t)r->ar.start * c->addr_unit;
> > +                     end_addr =3D (phys_addr_t)r->ar.end * c->addr_uni=
t;
> > +                     while (addr < end_addr) {
> > +                             struct folio *folio;
> > +                             phys_addr_t folio_start, folio_end;
> > +                             phys_addr_t overlap_start, overlap_end;
> > +                             phys_addr_t counted;
> > +
> > +                             folio =3D damon_get_folio(PHYS_PFN(addr))=
;
> > +                             if (!folio) {
> > +                                     addr +=3D PAGE_SIZE;
>
> Sashiko found [3] this may better to be aligned.  It is trivial but I agr=
ee.
> How about using PAGE_ALIGN_DOWN(addr + PAGE_SIZE)?

Agreed, will change to PAGE_ALIGN_DOWN(addr + PAGE_SIZE) in v8.

>
> > +                                     continue;
> > +                             }
> > +
> > +                             /*
> > +                              * Calculate exact overlap between the re=
gion
> > +                              * [addr, end_addr) and the folio range.
> > +                              * The folio may start before addr if add=
r is
> > +                              * in the middle of a large folio.
> > +                              */
> > +                             folio_start =3D PFN_PHYS(folio_pfn(folio)=
);
> > +                             folio_end =3D folio_start + folio_size(fo=
lio);
> > +
> > +                             overlap_start =3D max(addr, folio_start);
> > +                             overlap_end =3D min(end_addr, folio_end);
> > +
> > +                             if (overlap_end > overlap_start) {
> > +                                     counted =3D overlap_end - overlap=
_start;
> > +                                     total_eligible +=3D counted;
> > +                                     if (folio_nid(folio) =3D=3D nid)
> > +                                             node_eligible +=3D counte=
d;
> > +                             }
> > +
> > +                             /* Advance past the entire folio */
> > +                             addr =3D folio_end;
> > +                             folio_put(folio);
> > +                     }
> > +                     cond_resched();
> > +             }
> > +     }
> > +
> > +     *total =3D total_eligible;
> > +     return node_eligible;
> > +}
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *=
c,
> > +             struct damos *s, int nid)
> > +{
> > +     phys_addr_t total_eligible =3D 0;
> > +     phys_addr_t node_eligible;
> > +
> > +     if (c->ops.id !=3D DAMON_OPS_PADDR)
> > +             return 0;
> > +
> > +     if (nid < 0 || nid >=3D MAX_NUMNODES || !node_online(nid))
> > +             return 0;
>
> Trivial nit.  I'd prefer using '!node_state(nid, N_MEMORY)' to be consist=
ent
> with the similar one in damon_migrate_pages().  But this one seems fine t=
o me.

Thanks for the suggestion. I'll keep node_online() for now as you
indicated
  it's fine, but happy to change it later, if you prefer consistency.

>
> > +
> > +     node_eligible =3D damos_calc_eligible_bytes(c, s, nid, &total_eli=
gible);
> > +
> > +     if (!total_eligible)
> > +             return 0;
> > +
> > +     return mult_frac((unsigned long)node_eligible, 10000,
> > +                     (unsigned long)total_eligible);
> > +}
> > +#else /* CONFIG_DAMON_PADDR */
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *=
c,
> > +             struct damos *s, int nid)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_DAMON_PADDR */
> > +#else /* CONFIG_NUMA */
> >  static __kernel_ulong_t damos_get_node_mem_bp(
> >               struct damos_quota_goal *goal)
> >  {
> > @@ -2299,7 +2422,13 @@ static unsigned long damos_get_node_memcg_used_b=
p(
> >  {
> >       return 0;
> >  }
> > -#endif
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *=
c,
> > +             struct damos *s, int nid)
> > +{
> > +     return 0;
> > +}
> > +#endif /* CONFIG_NUMA */
> >
> >  /*
> >   * Returns LRU-active or inactive memory to total LRU memory size rati=
o.
> > @@ -2319,7 +2448,8 @@ static unsigned int damos_get_in_active_mem_bp(bo=
ol active_ratio)
> >       return mult_frac(inactive, 10000, total);
> >  }
> >
> > -static void damos_set_quota_goal_current_value(struct damos_quota_goal=
 *goal)
> > +static void damos_set_quota_goal_current_value(struct damon_ctx *c,
> > +             struct damos *s, struct damos_quota_goal *goal)
> >  {
> >       u64 now_psi_total;
> >
> > @@ -2345,19 +2475,24 @@ static void damos_set_quota_goal_current_value(=
struct damos_quota_goal *goal)
> >               goal->current_value =3D damos_get_in_active_mem_bp(
> >                               goal->metric =3D=3D DAMOS_QUOTA_ACTIVE_ME=
M_BP);
> >               break;
> > +     case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +             goal->current_value =3D damos_get_node_eligible_mem_bp(c,=
 s,
> > +                             goal->nid);
> > +             break;
> >       default:
> >               break;
> >       }
> >  }
> >
> >  /* Return the highest score since it makes schemes least aggressive */
> > -static unsigned long damos_quota_score(struct damos_quota *quota)
> > +static unsigned long damos_quota_score(struct damon_ctx *c, struct dam=
os *s)
> >  {
> >       struct damos_quota_goal *goal;
> > +     struct damos_quota *quota =3D &s->quota;
> >       unsigned long highest_score =3D 0;
> >
> >       damos_for_each_quota_goal(goal, quota) {
> > -             damos_set_quota_goal_current_value(goal);
> > +             damos_set_quota_goal_current_value(c, s, goal);
> >               highest_score =3D max(highest_score,
> >                               mult_frac(goal->current_value, 10000,
> >                                       goal->target_value));
> > @@ -2366,17 +2501,19 @@ static unsigned long damos_quota_score(struct d=
amos_quota *quota)
> >       return highest_score;
> >  }
> >
> > -static void damos_goal_tune_esz_bp_consist(struct damos_quota *quota)
> > +static void damos_goal_tune_esz_bp_consist(struct damon_ctx *c, struct=
 damos *s)
>
> 80 columns limit?

I checked - `damos_goal_tune_esz_bp_consist` is exactly 80 characters,
so it's
  fine as-is. However, `damos_goal_tune_esz_bp_temporal` below is 81
  characters, so I'll wrap that one in v8.

>
> >  {
> > -     unsigned long score =3D damos_quota_score(quota);
> > +     struct damos_quota *quota =3D &s->quota;
> > +     unsigned long score =3D damos_quota_score(c, s);
> >
> >       quota->esz_bp =3D damon_feed_loop_next_input(
> >                       max(quota->esz_bp, 10000UL), score);
> >  }
> >
> > -static void damos_goal_tune_esz_bp_temporal(struct damos_quota *quota)
> > +static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c, struc=
t damos *s)
> >  {
> > -     unsigned long score =3D damos_quota_score(quota);
> > +     struct damos_quota *quota =3D &s->quota;
> > +     unsigned long score =3D damos_quota_score(c, s);
> >
> >       if (score >=3D 10000)
> >               quota->esz_bp =3D 0;
> > @@ -2389,9 +2526,9 @@ static void damos_goal_tune_esz_bp_temporal(struc=
t damos_quota *quota)
> >  /*
> >   * Called only if quota->ms, or quota->sz are set, or quota->goals is =
not empty
> >   */
> > -static void damos_set_effective_quota(struct damos_quota *quota,
> > -             struct damon_ctx *ctx)
> > +static void damos_set_effective_quota(struct damon_ctx *c, struct damo=
s *s)
> >  {
> > +     struct damos_quota *quota =3D &s->quota;
> >       unsigned long throughput;
> >       unsigned long esz =3D ULONG_MAX;
> >
> > @@ -2402,9 +2539,9 @@ static void damos_set_effective_quota(struct damo=
s_quota *quota,
> >
> >       if (!list_empty(&quota->goals)) {
> >               if (quota->goal_tuner =3D=3D DAMOS_QUOTA_GOAL_TUNER_CONSI=
ST)
> > -                     damos_goal_tune_esz_bp_consist(quota);
> > +                     damos_goal_tune_esz_bp_consist(c, s);
> >               else if (quota->goal_tuner =3D=3D DAMOS_QUOTA_GOAL_TUNER_=
TEMPORAL)
> > -                     damos_goal_tune_esz_bp_temporal(quota);
> > +                     damos_goal_tune_esz_bp_temporal(c, s);
> >               esz =3D quota->esz_bp / 10000;
> >       }
> >
> > @@ -2415,7 +2552,7 @@ static void damos_set_effective_quota(struct damo=
s_quota *quota,
> >               else
> >                       throughput =3D PAGE_SIZE * 1024;
> >               esz =3D min(throughput * quota->ms, esz);
> > -             esz =3D max(ctx->min_region_sz, esz);
> > +             esz =3D max(c->min_region_sz, esz);
> >       }
> >
> >       if (quota->sz && quota->sz < esz)
> > @@ -2452,7 +2589,9 @@ static void damos_adjust_quota(struct damon_ctx *=
c, struct damos *s)
> >       /* First charge window */
> >       if (!quota->total_charged_sz && !quota->charged_from) {
> >               quota->charged_from =3D jiffies;
> > -             damos_set_effective_quota(quota, c);
> > +             damos_set_effective_quota(c, s);
> > +             if (trace_damos_esz_enabled())
> > +                     damos_trace_esz(c, s, quota);
>
> damos_trace_esz() seems an unintended change?

Yes, this was unintended. Will remove it in v8.

>
> >       }
> >
> >       /* New charge window starts */
> > @@ -2467,7 +2606,7 @@ static void damos_adjust_quota(struct damon_ctx *=
c, struct damos *s)
> >               quota->charged_sz =3D 0;
> >               if (trace_damos_esz_enabled())
> >                       cached_esz =3D quota->esz;
> > -             damos_set_effective_quota(quota, c);
> > +             damos_set_effective_quota(c, s);
> >               if (trace_damos_esz_enabled() && quota->esz !=3D cached_e=
sz)
> >                       damos_trace_esz(c, s, quota);
> >       }
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 245d63808411..f21191d31f58 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1094,6 +1094,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs=
_qgoal_metric_names[] =3D {
> >               .metric =3D DAMOS_QUOTA_INACTIVE_MEM_BP,
> >               .name =3D "inactive_mem_bp",
> >       },
> > +     {
> > +             .metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > +             .name =3D "node_eligible_mem_bp",
> > +     },
> >  };
> >
> >  static ssize_t target_metric_show(struct kobject *kobj,
> > @@ -2685,6 +2689,9 @@ static int damos_sysfs_add_quota_score(
> >                       }
> >                       goal->nid =3D sysfs_goal->nid;
> >                       break;
> > +             case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +                     goal->nid =3D sysfs_goal->nid;
> > +                     break;
> >               default:
> >                       break;
> >               }
> >
> > base-commit: 277a7fae172bb4a598e0d4144ffb2ff6207fedb3
> > --
> > 2.43.0
>
> I also reviewed Sashiko review [3] and I find no real problem except the =
addr
> alignment.
>
> So this looks good to me, except the trivial things I commented above.  C=
ould
> you please revision for the last time?

Will do. Summary of changes for v8:
  1. Mention addr filters for source-node filtering in Two-Scheme
Setup
  2. Move implementation details to commentary area with full
changelog
  3. Wrap the 80-column violation in damon_commit_ctx()
  4. Use PAGE_ALIGN_DOWN(addr + PAGE_SIZE) for alignment
  5. Wrap damos_goal_tune_esz_bp_temporal() (81 chars)
  6. Remove unintended damos_trace_esz() from first charge window

  Thanks,
  Ravi

>
> [1] https://lore.kernel.org/20260405184247.2690-1-ravis.opensrc@gmail.com
> [2] https://docs.kernel.org/process/submitting-patches.html#commentary
> [3] https://lore.kernel.org/20260424205908.CF949C2BCB8@smtp.kernel.org
>
>
> Thanks,
> SJ
