Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794529342;
	b=hHp7r7ZP4+EdfBND7dNgkWbZU/0J+zEU/YVsix90wQQMvaJkJNZ0Lj9f8iBvv5e3UazG
	 TYxPaknseMLDS0rdBZvwVH7Rfs98JG+NzeDG8n59zc5iWJL9Y+pgHxzE9p/ytCDVUVX0t
	 XMcpDBJT/NR5UUBKgnXhKJgFmj8dAhpVM8wleXzkZFUv7fXUSnT14GEG6vHJhi3VsaB1g
	 fDdj8E4Js/16mlsnab8SrvusGIKeIiwt+3COvnINoENSDWXkxL5rcprerv9bDgEc4uoF+
	 HL0mr2oN3eMCWr20ZQVyxHQnBs5n2mU3P9ZoblVUaNd7MHQ+Ea84yl4TG4iVSrEiZNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XX5CDk81th6KGJ05rM9qF5DM1I+16UZB6M36vnln6PU=;
	b=0w0ob7PUSDnkZgOJVvE5lfvLbCRXOGdKL/fy8XS30vCcgnnBEggej8rBeV8fwQF1H7AL
	 Lpg1ZtbQvd/5uhBieYUDjA9BdUFRXWpf55k2RSgrLVa152oxC9GwO7N4X50Xvr1b116b5
	 QfjpQpkU6JCosq8bIx4SUhXiPuVsYT8m2U2LimZNWUucQdZG8D8woWzRBf223Nhj5HjxP
	 tmWEi9AhpO0dDDvFrw63Bo3s8j1StlRZLrylSRa/VQvyw/Au/5D4nr7auam/QOAbWmzY+
	 mU2YIx4jXObtTvhw24H4EUTQtKnOTRM0MZMOYAgZw2rBCA1md7aXhLGtmLcjKolQh0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTADjmNx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6462606A327
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 00:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6462606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vTADjmNx
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so359381f8f.1
        for <damon@lists.linux.dev>; Thu, 12 Nov 2026 16:22:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794529340; cv=none;
        d=google.com; s=arc-20260327;
        b=lpvm9Luu5As9toRYXL1BHAWunWLOiNobUdXCSoKQedvKaKMDm2aiVXnUnPhGkAE6JH
         QB6mnOs3+oZsDi2XOgadJUHQbApMXBKU4A9eMxF0QgtuGrQspDA1MzpDOiRkppXCYl5k
         rE87iqZWmgQKztGk+COZMqWR23O6DmrvGGs4zbI8kdc1ZghRzIHw4Aqvi5dgpsW0EpOj
         HkorM6fFQ+YVxGKlusw6TBRdhdLfPrxQ3yaCIzWMuLKFTEQs8jQLnigsd9qY3r3Ett7u
         5pcMxrdnz8N8+tEiD1iVNRYkKx0hUEOG5dCvyX7j4+geV2xBy0s567uSXvSCGatcYRoj
         cnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XX5CDk81th6KGJ05rM9qF5DM1I+16UZB6M36vnln6PU=;
        fh=WQh+4E4BtaHamojusGv4PqnJBkmyviwCEZTXYMztBMU=;
        b=htuhiLkpf711S8/kMnKQcDAF0lMlaNdOj0SICl5diVUlnDg+/kvtrnFN+ErSsG2g2E
         5RfMzfJQgozewD0cTl4HRGBuwzI7O46+mjjVr1efVcYBkEXY2n1DSm9Gg0C/KCJ30yTx
         apoglP++frwAgpLJCXbq+iEydll7q3LIRpUqZP0hmsiF9aZ8TOOx2sBHvGF2cIrNlK30
         H1poRctStGq9XeVTwaoipqWz5LyxDe7NjEcPjY5xI3TvKXqOY+m9KiRDHiuGTpA5UdfU
         V7dtDPD16mzuLvNRYWfT+FiEEypBCShTHhv3PTS3c9yxbJoUa5Ybh02oQFo9UhAWhLiI
         1MUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529340; x=1795134140; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XX5CDk81th6KGJ05rM9qF5DM1I+16UZB6M36vnln6PU=;
        b=vTADjmNxO8XAjSk28w91sziMss0DPllydyVAfjN8ULnil0Sp4J973cPe4YvAzSW1/m
         Vm1SdK4BDLFW6xgYXehYdnqpcQrKbZWpdGHfW62J6cih5XwiEqZi1qY6f7UY1hC6BYyB
         bsA5ZIeUNYs0CfbQVA8TPlgQBUjz1p4AKvQ4IKQA0U134tVwuGnmAIdJiDCrDdpdD6kJ
         YXEfOLAInsfcRT5mkmey/qhLOwZ8+2ZzTcD7egY3OvGsMxzfTIjyN6+3FWk3P5mPFMvC
         em2LDeaftYhS/9/UnJlD2mz6poh1FfU26/UMepj0E9i9WIWOCvfHuJONhXI/vUajxRm7
         ClQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529340; x=1795134140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XX5CDk81th6KGJ05rM9qF5DM1I+16UZB6M36vnln6PU=;
        b=ZnuXYNr8PItUNLvMVTndv+WfqsJGOBgXfG8MHFbpItwu0uVBFrXdk6NDP7m8jreB7F
         qNXNqHIZykoYFWAFKiwK653Z/qiEQUAuqHLfwG6bBi4yjoB6Ru3Xx73QdlLywyPpq/dh
         bqSE1H7+SUlj5rRht5RHaL6O+xSpnNvG2nAFbN6lHLWuxxT427ABUjcMdPA7ukCLBtPP
         yLrdctxevB8Qrq63/ETVZT1uVrFZwEJMqzrSzgFiMo+Yv7ahqRga03OUxYKff8j3txRn
         rg2Cz3qdf5sHkY6e/8LmeHxuSDZaYN2a9XQ0K6nnpBhrZtsC6dD7SSuGMTy2QT/BFTkD
         bXgQ==
X-Forwarded-Encrypted: i=1; AL+hErG5wYLTbLiUQR4oNlnXkiK7zAx0Ltrxc1Ky8Gu0Xv1UJG4V+WEN3Hv3wMF3TVfF9EOgH1MrqQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z97NUsxp1QogPq8q4pyMcIQ/EohVafYRrQE1UDrpJAKOfnlf4iw
	PhBTXP+e3M9V+h8oCPTgjkBkExY+xpjjiknlHf2N2uscft1yMnLs1sHwYNMaZtnEskmdeNTaaC9
	em0lgoNZQk6clBtK/Hj23bdkPTUtH6dE=
X-Gm-Gg: AYBFou2XEH262qUmePMzNSNAN2xnyqZoiJTAAIsUH/cxMoTEXtjJGpQic7oV5GgTjvs
	UfBT05SxTnNTShnqX3cZ5a4y84rXSbMZifKf937zsiRC97XdoASSMizeOMGeJJJaXiijN8T5FzE
	ftOmLHENtsP6IHUiMElKhunzrABTVi+sfOwHDcWrxSx1FX7g//+ddALNaoWenDlJxArutUw/vuO
	FccBIpn63V3Al9YlBFv/lk9qTMlcaygzj5kTKVRVUrdbTvILS3tLrylT0YVwJIvbruPK5v5t0RB
	qbi4Gcc12ukGSPFBq+d1iG1dBMfRqAle7HHerPuYMHkbYyRrczGSL0HMWfy6/Rr+U1fo7j9sWlU
	OedDCkfLUC50yD2AtRxqWwgJXnnBsNaZ7Z0tr3L2r5wpYDNzPBmxDpLlxHogjebscWbB5bPBu4w
	mH6Xsk3GwkrvV2r9v5RZjyLrBrFMnXBVTdrIGi9f0=
X-Received: by 2002:a05:6000:2388:b0:48c:414f:cc12 with SMTP id
 ffacd0b85a97d-49c72306b9emr2108990f8f.40.1794529340174; Thu, 12 Nov 2026
 16:22:20 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-3-joannelkoong@gmail.com> <sashiko-outbox-206041@kernel.org>
 <CAJnrk1aQrRE78wqd2yZWS2Sk8MiCHd9x0dveZBh5LHE5w75nkg@mail.gmail.com> <avSqMxGjwYPrQLlV@localhost.localdomain>
In-Reply-To: <avSqMxGjwYPrQLlV@localhost.localdomain>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Nov 2026 16:22:08 -0800
X-Gm-Features: AclHuK_k_bmCepdQWwN9flpYp_ThMtbbs9t9wCfxy4WdI4tskUDaThwNWD8_PFU
Message-ID: <CAJnrk1YbqyCfA26M184RWL__vjo3G=_MJ8k-AEf8vCqvKBsmew@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm: memcg: read root lruvec stats from the node counters
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: sashiko-reviews@lists.linux.dev, akpm@linux-foundation.org, 
	yosry@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, 
	ljs@kernel.org, linux-mm@kvack.org, damon@lists.linux.dev, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:47=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Nov 10, 2026 at 03:10:54PM -0800, Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > On Mon, Nov 9, 2026 at 6:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue to consider:
> > > - [Medium] mm: memcg: node_stat_includes_unaccounted() omits file and
> > >   writeback stats
> > > --
> > >
> > > commit d2ba314724a8ba015e3bf2a30f155f1beba25a8c
> > > Author: Joanne Koong <joannelkoong@gmail.com>
> > >
> > > mm: memcg: read root lruvec stats from the node counters
> > >
> > > This commit changes lruvec_page_state() and lruvec_page_state_monoton=
ic()
> > > to read per-node vmstat counters instead of rstat values for the root
> > > memcg when querying stats that only track memory charged to a memcg.
> > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 1ebc9330aeae5..2575bf2ba0ea6 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > >
> > > [ ... ]
> > >
> > > > @@ -504,13 +511,52 @@ struct lruvec_stats {
> > > >       long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> > > >  };
> > > >
> > > > +/*
> > > > + * Whether the node counter for @idx can also count memory that is=
n't charged
> > > > + * to a memcg (eg kernel memory that isn't accounted). For these s=
tats, the
> > > > + * node counter can be larger than the root memcg's value, so the =
root memcg
> > > > + * has to read its rstat value instead.
> > > > + */
> > > > +static bool node_stat_includes_unaccounted(enum node_stat_item idx=
)
> > > > +{
> > > > +     switch (idx) {
> > > > +     case NR_SLAB_RECLAIMABLE_B:
> > > > +     case NR_SLAB_UNRECLAIMABLE_B:
> > > > +     case WORKINGSET_NODERECLAIM:
> > > > +     case NR_VMALLOC:
> > > > +     case NR_KERNEL_STACK_KB:
> > > > +     case NR_PAGETABLE:
> > > > +     case NR_SECONDARY_PAGETABLE:
> > > > +#ifdef CONFIG_HUGETLB_PAGE
> > > > +     case NR_HUGETLB:
> > > > +#endif
> > > > +             return true;
> > > > +     default:
> > > > +             return false;
> > > > +     }
> > > > +}
> > >
> > > [Severity: Medium]
> > > Should node_stat_includes_unaccounted() also include NR_FILE_PAGES,
> > > NR_FILE_MAPPED, and NR_WRITEBACK?
> > >
> > > For NR_FILE_PAGES, swapcache operations such as __swap_cache_add_foli=
o(),
> > > __swap_cache_del_folio(), and __swap_cache_alloc() update NR_FILE_PAG=
ES
> > > only in the node counter while accounting swapcache in the lruvec und=
er
> > > NR_SWAPCACHE:
> > >
> > > mm/swap_state.c:__swap_cache_add_folio() {
> > >         ...
> > >         node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> > >         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> > >         ...
> > > }
> > >
> > > Reading node_page_state(pgdat, NR_FILE_PAGES) for the root lruvec
> > > therefore includes all swapcache pages, which inflates the "file" cou=
nter
> > > in the root cgroup's memory.numa_stat (double-counting swapcache alon=
gside
> > > "swapcached") and causes it to diverge from memory.stat even after a
> > > flush.
> > >
> > > Similarly, __folio_mod_stat() -> lruvec_stat_mod_folio() updates the =
node
> > > NR_FILE_MAPPED counter without updating memcg rstat whenever an uncha=
rged
> > > folio (folio_memcg(folio) =3D=3D NULL, such as a driver mapping or a
> > > root-cgroup __GFP_ACCOUNT kernel folio) is mapped into userspace, and
> > > nfs_folio_mark_unstable() and nfs_folio_clear_commit() update
> > > NR_WRITEBACK only in the node counter for unstable NFS pages awaiting
> > > server COMMIT.
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026111001532=
1.611093-1-joannelkoong@gmail.com?part=3D2
> >
> > Thanks, this is a good point about the folio stats.
> >
> > Hmm... I wonder if we should go with an allowlist instead of a
> > denylist. The allowlist is longer (31 stats vs 11) but would be more
> > resilient to failures (a stat missing from the allowlist just reads
> > the rstat value whereas a stat missing from the denylist will silently
> > report the wrong value) for any stats added in the future. Any
> > thoughts?
>
> I agree the opposite predicate would be more robust and potentially
> easier to review (review only the _listed_ cases, not the "unknown"
> complement).

Hi Michal,

Thanks for taking a look at this! I'll switch to the allowlist for v3.

>
> Also, instead of
>
>        if (something && !mem_cgroup_is_root(eviction_memcg))
>                 mem_cgroup_flush_stats_ratelimited(eviction_memcg);
>
> I'd consider
>
>        if (something)
>                 mem_cgroup_flush_stats_ratelimited_opt(eviction_memcg,
>                 1UL<<NR_ACTIVE_ANON|
>                 1UL<<NR_INACTIVE_ANON| ... );
>
> and collect the exceptional handling in memcontrol.c:
>
>         void mem_cgroup_flush_stats_ratelimited_opt(struct mem_cgroup *me=
mcg, unsigned long needs)
>         {
>                 if ((needs & ~node_stat_equivalent) =3D=3D 0 &&
>                         mem_cgroup_is_root(mem_cgroup))
>                         return;
>                 ...
>
> This way in-kernel flushers will be expicitly annotated so that
> potential mismatch is more obvious to spot (and it adds possibility of
> future optimizations).
>
> (This is all only a concept, it may turn out uglier when worked out to
> details...)

I think there's a few cases where this doesn't map neatly
unfortunately (eg global and root reclaim reading the LRU sizes of the
root memcg but still needing the root flush since they also need to
read the rstat values of their children memcgs). The mask would also
have to be a bitmap given that node_stat_item has more than 64
entries, which makes it a bit more cumbersome.

I wonder though if the same idea could be conveyed by having the
callers use a shared helper function like
"mem_cgroup_flush_lru_stats()" with the root special-casing logic kept
in that function in memcontrol.c. Then the call sites would look
something like:

  if (flush)
          mem_cgroup_flush_lru_stats_ratelimited(eviction_memcg);

instead of

  if (flush && !mem_cgroup_is_root(eviction_memcg))
          mem_cgroup_flush_stats_ratelimited(eviction_memcg);

which seems easier / more coherent to read. I'll give this a try for v3!

Thanks,
Joanne
