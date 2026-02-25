Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC202D780C
	for <damon@lists.linux.dev>; Wed, 25 Feb 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045231; cv=pass; b=GhPmcF3y5/4W8UGv7cD1k2rANH3+7cA7Nq5S4La1MrgMgulY6gpeubcetcbwUl/AviXHlkhDXpAJu1JqFWsELtni7bgpxq/0dXF2YnfbnhPI1Bf37MYAdjtStKLXYvoEjKchwK/aESjb8mj68Lnh1BMtfFtw1d+TCOJbivSS/M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045231; c=relaxed/simple;
	bh=Gn6zmkPbPLd5UccdTxX19E5733xdCO+dolwDcZ4U4vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfKQvrDnaPD0+jCrvEqnVH00wMacZ7Qd2GYtOKJYAi0CFLC/ZN7DflTZVsPfg9x5qxUqrWgIsDktAOy+7RZgAnysT5JOszs3lhT8tCzqO7v1m7L2WGGa4OTRx9hvHslj4z4uf5JX1n5Hy9MBFE5h1AxsKYL9tayicZVfFru96bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmu/Rwk4; arc=pass smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmu/Rwk4"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-126ea4e9694so3913329c88.1
        for <damon@lists.linux.dev>; Wed, 25 Feb 2026 10:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772045228; cv=none;
        d=google.com; s=arc-20240605;
        b=EkpAvwfNkQo2ZStRSBQpXEIM03JSoSkHXDxZwJs+rg6GZjeM4xBzQWnJt9yoRs3zKj
         yjhW+FJHhbgML0s0o1AFPQfk9YXjAGs2tOAyzzboqnhPSWz6DwRHrCxBV3ZdL82SZrNK
         LA5QD8OOkUBhl0SGjzHUO/XYf8qAw2F/tFfZ44BVsFHB8hWDD8fmzmD5X6C8JJKGKUeH
         X4c7XO4A0x/7/aKlhfhfIssdNbJiADMTmRsgxqMN3HczwTQgbVG1U6ytzaG3rbxLsYGG
         qbFRsjxxM+UrRq0k7/fGKKZKpZKa0hinlhvGWIdirg0pAWjkyBfzt+xrpB7iqhRx3Xpf
         nsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Am0QhYpweZev8nnkB2fwxkoFfdf13ydMbHaqe2oNmTA=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=QDmKGoaSB7Rk8tWgg8FwnqQ4VgnNAHwnh5mv6Qm40edqLDbHElJ28UDadSmc27XTbF
         xdWikH1nwOgVCHCd16ooSL+VIuteplST0fAvnqRaCXuhINI67gT5pr9bDWD+rncTFblR
         WBDMOS9UdA09bvem2X+PnK4UZfvO4raqewlQXCs7ZWR3/0VGxAp0XE6nWhcMp8PcPbYR
         /ssawIQFTpqiJirUk+GjQLq5a0ObnsNh/G1O6UYeVn0vk7wSzhJ6e/1we0SKpG5XSW1C
         faYjuK3dWeBY5wjfJsnSg1plSO7gAHYM3FuxeFRINNjTElF99wB3Wq4VmcZl/HpWiXwc
         fLRA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045228; x=1772650028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am0QhYpweZev8nnkB2fwxkoFfdf13ydMbHaqe2oNmTA=;
        b=lmu/Rwk4ndVMulGxgAV3CSVytorZo4GJPu+49MIXqYhybFDjon7VNT8IGqhuSTOhVK
         yTJD3biSn7I2dhywvCLBqnAFiuarbGh7VKsT2aWmLksZy4XaYDmwYB4zgHAxXqfSBYE0
         VICIt5RlH/a/7IbhD/abUw+MX3lW6m+gTlrtrNkYpvZGnPcS7qQRjRwGoufAn37/hqlU
         TFN+nJ25KE/JFmHIZKKJUMhn/F3s99JwMojONw9aevs6Usmnvv4lcncDKLmYE7Pkc3wx
         PRr25kKd3HzVkqJZcBERvk4Frr3+OftIShW8Xod5pw5f+aNt/jETlEY6xBXesyG2ZAjl
         oHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045228; x=1772650028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Am0QhYpweZev8nnkB2fwxkoFfdf13ydMbHaqe2oNmTA=;
        b=Vo/Y11H1l3xF9pjj0YjXnYBNmycYQJj4c7B4vgIZl30t/0jcFCNqzJe8SCST/lZU00
         t9+Qn55U8/I/z01yUrmZr5/hmkazv0nuln9ilfTpewMQPCVqOcdjQcGCSD9rNa3urs8W
         bzZHZu2l0kbellCOX3MCxsW342k2lJN6yhifgzDCn/mZy6pUsRelS6L+MusEZUN25Ll3
         h0uoSjTTeDZnnXFg/0amAs9GkeChOAtaHd0Cf9S764efI0TkJMM+IP6sf81zDeurdkmJ
         pm62IWJwjnG6Dj7ICFyi4ZCC9W1FGp7BTJ7F8J+UrJn2ZEtDZytE0TSLqC99o8OG358l
         UY3Q==
X-Gm-Message-State: AOJu0Ywgd37eovoTCv38E8lLWW6b1mWxmnjGWbxI3Sp+yhHuDN+DUnuU
	CJiQ+GhTqBbuHG/WXNIfHdhdpt3bSmRiwvI9qwYRD4yH+hrXhI2GetcviQmcNON/vMxrmxkfue3
	xt+NhQnYP6AsDvVNX7F8p1zkglXL8PQ==
X-Gm-Gg: ATEYQzztg6hYF+pRcEZ3U+qoOrQlvEu/8dGGaZh4IjbHJhVMySAmZ84lpad3WH0uzmG
	q4skAVX2O4zmkyAbeV4MaGbT78O/oiuwtQ+eNGt1E4iZKS95K44u2rY+Y2QpbDrSfjfxpzLjmr2
	GvTwuKuWoC1waPWQzKFJ0nGr31AAniLWtmt5B9DIIFRq1IqfXb9dyqbcuQIuAGVrMav3uq17EP1
	Frxll7ctLL7BMdcd57d9rkm1cceuzzOQKtJV+f/WPZoze89pOHQ+fq4jD/1CTq77E3Bb3u73mKj
	b8iqcX4=
X-Received: by 2002:a05:7022:e1e:b0:124:8d7d:2d63 with SMTP id
 a92af1059eb24-1276ad37c89mr6990464c88.35.1772045228091; Wed, 25 Feb 2026
 10:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260223123232.12851-4-ravis.opensrc@gmail.com> <20260224042734.57666-1-sj@kernel.org>
In-Reply-To: <20260224042734.57666-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Feb 2026 10:46:56 -0800
X-Gm-Features: AaiRm52GeaS6tTlogoSqCwfrxu1fZdKPGoV3imvaN48s8SBy_zqky7K_ivWZz7o
Message-ID: <CALa+Y16T-yNPq75s_PWwEJAEZ=r1YVdd7AyRMA2DtS=BdkZ3-w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] mm/damon: add node_eligible_mem_bp and
 node_ineligible_mem_bp goal metrics
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:27=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Mon, 23 Feb 2026 12:32:31 +0000 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Add new quota goal metrics for memory tiering that track scheme-eligibl=
e
> > (hot) memory distribution across NUMA nodes:
> >
> > - DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP: ratio of hot memory on a node
> > - DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP: ratio of hot memory NOT on a node
> >
> > These complementary metrics enable push-pull migration schemes that
> > maintain a target hot memory distribution. For example, to keep 30%
> > of hot memory on CXL node 1:
> >
> > - PUSH scheme (DRAM=E2=86=92CXL): node_eligible_mem_bp, nid=3D1, target=
=3D3000
> >   Activates when node 1 has less than 30% hot memory
> > - PULL scheme (CXL=E2=86=92DRAM): node_ineligible_mem_bp, nid=3D1, targ=
et=3D7000
> >   Activates when node 1 has more than 30% hot memory
> >
> > Together with the TEMPORAL goal tuner, the schemes converge to
> > equilibrium at the target distribution.
> >
> > The metrics use detected eligible bytes per node, calculated by summing
> > the size of regions that match the scheme's access pattern (size,
> > nr_accesses, age) on each NUMA node.
>
> Looks good in general!  I have some comments about trivials and the desig=
n
> below, though.
>

Thank you for the detailed review!

> >
> > Suggested-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> > ---
> >  include/linux/damon.h    |   6 ++
> >  mm/damon/core.c          | 123 ++++++++++++++++++++++++++++++++++++++-
> >  mm/damon/sysfs-schemes.c |  10 ++++
> >  3 files changed, 137 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index ee2d0879c292..6df716533fbf 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -191,6 +191,8 @@ enum damos_action {
> >   * @DAMOS_QUOTA_NODE_MEM_FREE_BP:    MemFree ratio of a node.
> >   * @DAMOS_QUOTA_NODE_MEMCG_USED_BP:  MemUsed ratio of a node for a cgr=
oup.
> >   * @DAMOS_QUOTA_NODE_MEMCG_FREE_BP:  MemFree ratio of a node for a cgr=
oup.
> > + * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:        Scheme-eligible memory ra=
tio of a node.
> > + * @DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:      Scheme-ineligible memory =
ratio of a node.
>
> Nit.  Let's wrap the line for 80 columns limit.

Will fix it.

>
> >   * @DAMOS_QUOTA_ACTIVE_MEM_BP:               Active to total LRU memor=
y ratio.
> >   * @DAMOS_QUOTA_INACTIVE_MEM_BP:     Inactive to total LRU memory rati=
o.
> >   * @NR_DAMOS_QUOTA_GOAL_METRICS:     Number of DAMOS quota goal metric=
s.
> > @@ -204,6 +206,8 @@ enum damos_quota_goal_metric {
> >       DAMOS_QUOTA_NODE_MEM_FREE_BP,
> >       DAMOS_QUOTA_NODE_MEMCG_USED_BP,
> >       DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
> > +     DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > +     DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
> >       DAMOS_QUOTA_ACTIVE_MEM_BP,
> >       DAMOS_QUOTA_INACTIVE_MEM_BP,
> >       NR_DAMOS_QUOTA_GOAL_METRICS,
> > @@ -555,6 +559,7 @@ struct damos_migrate_dests {
> >   * @ops_filters:     ops layer handling &struct damos_filter objects l=
ist.
> >   * @last_applied:    Last @action applied ops-managing entity.
> >   * @stat:            Statistics of this scheme.
> > + * @eligible_bytes_per_node: Scheme-eligible bytes per NUMA node.
> >   * @max_nr_snapshots:        Upper limit of nr_snapshots stat.
> >   * @list:            List head for siblings.
> >   *
> > @@ -644,6 +649,7 @@ struct damos {
> >       struct list_head ops_filters;
> >       void *last_applied;
> >       struct damos_stat stat;
> > +     unsigned long eligible_bytes_per_node[MAX_NUMNODES];
>
> I understand this could make it time-efficient.  That is, without this, y=
ou
> will need to iterate the regions for number of node_[in]eligible_mem_bp g=
oals
> per scheme.  By having this you need to iterate regions only once per sch=
eme.
> I'm bit worried about the increased size of 'struct damos', though.
>
> Do you think the overhead is really significant?  If not, what about maki=
ng it
> simply iterates the regions per goal, and add optimization later if it tu=
rns
> out really needs?
>

Got it. I'll change it to simply iterate regions per goal.

> If this optimization is really needed right now, I'd like it to at least =
be
> dynamically allocated, for only num_online_nodes() or num_possible_nodes(=
) at
> least.

Got it. If we ever need to implement the optimization, will follow the
dynamic allocation path.

>
> >       unsigned long max_nr_snapshots;
> >       struct list_head list;
> >  };
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b438355ab54a..3e1cb850f067 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2544,6 +2544,111 @@ static unsigned long damos_get_node_memcg_used_=
bp(
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_NUMA
> > +/*
> > + * damos_scheme_uses_eligible_metrics() - Check if scheme uses eligibl=
e metrics.
> > + * @s: The scheme
> > + *
> > + * Returns true if any quota goal uses node_eligible_mem_bp or
> > + * node_ineligible_mem_bp metrics, which require eligible bytes calcul=
ation.
> > + */
> > +static bool damos_scheme_uses_eligible_metrics(struct damos *s)
> > +{
> > +     struct damos_quota_goal *goal;
> > +     struct damos_quota *quota =3D &s->quota;
> > +
> > +     damos_for_each_quota_goal(goal, quota) {
> > +             if (goal->metric =3D=3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP =
||
> > +                 goal->metric =3D=3D DAMOS_QUOTA_NODE_INELIGIBLE_MEM_B=
P)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +/*
> > + * damos_calc_eligible_bytes_per_node() - Calculate eligible bytes per=
 node.
> > + * @c: The DAMON context
> > + * @s: The scheme
> > + *
> > + * Calculates scheme-eligible bytes per NUMA node based on access patt=
ern
> > + * matching. A region is eligible if it matches the scheme's access pa=
ttern
> > + * (size, nr_accesses, age).
> > + */
> > +static void damos_calc_eligible_bytes_per_node(struct damon_ctx *c,
> > +             struct damos *s)
> > +{
> > +     struct damon_target *t;
> > +     struct damon_region *r;
> > +     phys_addr_t paddr;
> > +     int nid;
> > +
> > +     memset(s->eligible_bytes_per_node, 0,
> > +                     sizeof(s->eligible_bytes_per_node));
> > +
> > +     damon_for_each_target(t, c) {
> > +             damon_for_each_region(r, t) {
> > +                     if (!__damos_valid_target(r, s))
> > +                             continue;
> > +                     paddr =3D (phys_addr_t)r->ar.start * c->addr_unit=
;
> > +                     nid =3D pfn_to_nid(PHYS_PFN(paddr));
> > +                     if (nid >=3D 0 && nid < MAX_NUMNODES)
> > +                             s->eligible_bytes_per_node[nid] +=3D
> > +                                     damon_sz_region(r) * c->addr_unit=
;
> > +             }
> > +     }
>
> Seems the above code assumes entire region will belong in the same node. =
 But
> the region might be laying over a nodes boundary.  In the case, miscalcul=
ations
> could happen.
>
> What about getting start/end addresses of the node, and checking the cros=
sing
> boundary case?

Got it. I'll add handling for regions that span node boundaries by
checking the node's address range and splitting the calculation accordingly=
.

>
> > +}
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damos *s, i=
nt nid)
> > +{
> > +     unsigned long total_eligible =3D 0;
> > +     unsigned long node_eligible;
> > +     int n;
> > +
> > +     if (nid < 0 || nid >=3D MAX_NUMNODES)
> > +             return 0;
> > +
> > +     for_each_online_node(n)
> > +             total_eligible +=3D s->eligible_bytes_per_node[n];
> > +
> > +     if (!total_eligible)
> > +             return 0;
> > +
> > +     node_eligible =3D s->eligible_bytes_per_node[nid];
> > +
> > +     return mult_frac(node_eligible, 10000, total_eligible);
> > +}
> > +
> > +static unsigned long damos_get_node_ineligible_mem_bp(struct damos *s,=
 int nid)
> > +{
> > +     unsigned long eligible_bp =3D damos_get_node_eligible_mem_bp(s, n=
id);
> > +
> > +     if (eligible_bp =3D=3D 0)
> > +             return 10000;
> > +
> > +     return 10000 - eligible_bp;
> > +}
> > +#else
> > +static bool damos_scheme_uses_eligible_metrics(struct damos *s)
> > +{
> > +     return false;
> > +}
> > +
> > +static void damos_calc_eligible_bytes_per_node(struct damon_ctx *c,
> > +             struct damos *s)
> > +{
> > +}
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damos *s, i=
nt nid)
> > +{
> > +     return 0;
> > +}
> > +
> > +static unsigned long damos_get_node_ineligible_mem_bp(struct damos *s,=
 int nid)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >  /*
> >   * Returns LRU-active or inactive memory to total LRU memory size rati=
o.
> >   */
> > @@ -2562,7 +2667,8 @@ static unsigned int damos_get_in_active_mem_bp(bo=
ol active_ratio)
> >       return mult_frac(inactive, 10000, total);
> >  }
> >
> > -static void damos_set_quota_goal_current_value(struct damos_quota_goal=
 *goal)
> > +static void damos_set_quota_goal_current_value(struct damos_quota_goal=
 *goal,
> > +             struct damos *s)
> >  {
> >       u64 now_psi_total;
> >
> > @@ -2584,6 +2690,14 @@ static void damos_set_quota_goal_current_value(s=
truct damos_quota_goal *goal)
> >       case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
> >               goal->current_value =3D damos_get_node_memcg_used_bp(goal=
);
> >               break;
> > +     case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +             goal->current_value =3D damos_get_node_eligible_mem_bp(s,
> > +                             goal->nid);
> > +             break;
> > +     case DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:
> > +             goal->current_value =3D damos_get_node_ineligible_mem_bp(=
s,
> > +                             goal->nid);
> > +             break;
> >       case DAMOS_QUOTA_ACTIVE_MEM_BP:
> >       case DAMOS_QUOTA_INACTIVE_MEM_BP:
> >               goal->current_value =3D damos_get_in_active_mem_bp(
> > @@ -2597,11 +2711,12 @@ static void damos_set_quota_goal_current_value(=
struct damos_quota_goal *goal)
> >  /* Return the highest score since it makes schemes least aggressive */
> >  static unsigned long damos_quota_score(struct damos_quota *quota)
> >  {
> > +     struct damos *s =3D container_of(quota, struct damos, quota);
>
> I'd prefer passing 's' from the caller.

Will change to pass 's' from the caller instead of using container_of().

>
> >       struct damos_quota_goal *goal;
> >       unsigned long highest_score =3D 0;
> >
> >       damos_for_each_quota_goal(goal, quota) {
> > -             damos_set_quota_goal_current_value(goal);
> > +             damos_set_quota_goal_current_value(goal, s);
> >               highest_score =3D max(highest_score,
> >                               mult_frac(goal->current_value, 10000,
> >                                       goal->target_value));
> > @@ -2693,6 +2808,10 @@ static void damos_adjust_quota(struct damon_ctx =
*c, struct damos *s)
> >       if (!quota->ms && !quota->sz && list_empty(&quota->goals))
> >               return;
> >
> > +     /* Calculate eligible bytes per node for quota goal metrics */
> > +     if (damos_scheme_uses_eligible_metrics(s))
> > +             damos_calc_eligible_bytes_per_node(c, s);
> > +
> >       /* First charge window */
> >       if (!quota->total_charged_sz && !quota->charged_from) {
> >               quota->charged_from =3D jiffies;
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index fe2e3b2db9e1..232b33f5cbfb 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1079,6 +1079,14 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs=
_qgoal_metric_names[] =3D {
> >               .metric =3D DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
> >               .name =3D "node_memcg_free_bp",
> >       },
> > +     {
> > +             .metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> > +             .name =3D "node_eligible_mem_bp",
> > +     },
> > +     {
> > +             .metric =3D DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP,
> > +             .name =3D "node_ineligible_mem_bp",
> > +     },
> >       {
> >               .metric =3D DAMOS_QUOTA_ACTIVE_MEM_BP,
> >               .name =3D "active_mem_bp",
> > @@ -2669,6 +2677,8 @@ static int damos_sysfs_add_quota_score(
> >                       break;
> >               case DAMOS_QUOTA_NODE_MEM_USED_BP:
> >               case DAMOS_QUOTA_NODE_MEM_FREE_BP:
> > +             case DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:
> > +             case DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP:
> >                       goal->nid =3D sysfs_goal->nid;
> >                       break;
> >               case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
> > --
> > 2.43.0
>
> So, the overall concept and definition of the new goal metrics sound good=
 to
> me.  But I'd prefer having less optimized but simpler code, and nodes bou=
ndary
> crossing regions handling.
>

I'll prepare a v4 addressing all these points:
  1. Fix 80-column wrapping
  2. Remove eligible_bytes_per_node[] array, iterate regions per goal
instead
  3. Handle regions crossing node boundaries
  4. Pass scheme pointer from caller

I'm currently on a break and will send the updated patch after March
10th.

Thanks,
Ravi.
>
> Thanks,
> SJ
