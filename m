Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794352270;
	b=vlzAeaL0cdehJwVz3h+Rjofg+EcQhVtIBS0EIHQN/WVzcyPiIvLSrKcCe+BkAGiPGv+J
	 HZm40TKPrJ7ugLaxlsmLKdXJkGyw/wi+cD7WWGYk+gxuGmmx4fdwu2gKd3ky3dlejQX1O
	 teuCjwHGA9hBUBznmdzAEFqp9tEb881ONK3e4x/ZzT4H0i5D7nb+zkQ/Fi7vfAmB2AIxp
	 zCp6F0dK0Kjr4cokixJcuJjiY8vGeRPpkakfM/kydVkUzmhzcDGXb6vvzmCQDrczySajI
	 Sa3Ou5STwiFT1dnvBwwklmdlpFiOD+m+xFMqQLGw2s5LNA0iz6HQ/h27xtGbTDmKxVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wahlQe2g3fyZOdMzE4NOHeW/SspvW2KMChHvizkHdbo=;
	b=jr4gaTJoQ/MH8M+Xy1+897cP1TfKBrcURWNAAb9wWmtU3Y8LNlRm65HnWklhLEUZ9hSX
	 sseE98kQ8LC36/F3JQ1hKmgM0wEaw0lgzdYVJOTS2I79DYwXYOdEvLr8MVB1AxgvkCfwu
	 URvQfZkIaZJ/Ml1kYOdIusuks51nK4DmgrQqJ3gtwB9koRimbTk65LSFnsV3TUVrH/2h5
	 9hzGtCJdXLNh2LxAyfQ/LNWbf5+lbwNG0y+FHBiL/9/kD9o+ja5+iPonfXdv1WU3RLVoq
	 Xd82TlAxKYJTi31rNxxi0/uY+AMwkhZgBlTLHp3Vf+f+HBVLGjxGSzP7eUk9xlt2K4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBK2Aveh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693D606A333
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 23:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D693D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBK2Aveh
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0d63f60bcso35294377b3.3
        for <damon@lists.linux.dev>; Tue, 10 Nov 2026 15:11:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794352269; cv=none;
        d=google.com; s=arc-20260327;
        b=AKWS8HtpOjqAiAbUW269mWX0JFe9LTK1M8YHQ4ZZ+WxjeO+yRxcMe6ICFXTN0u8MJ/
         DT3fwLPukeQpnx4A6atMcR+iba+KHT0AWuybvj++fIkIOfBb6JPKdkGC643rb83BEPT3
         K29WlycUk3e2/R5PIUp2QtPVOzJJSRemtKAzXKLiaE9QfnecmgW08XIPx4YSFnjXfKLh
         /sTK3OpQBB7fETFvZ36aOVIjaULX8nBQdDlVK4PsDQiXieEYF/ScPmWIhXdMuNhaAypx
         kPYzs7YlECTaqon0+Ug5R5E1dxthYnzpLVk8v0EdY6JvFMu2+S+DVo6bzMFM9Mk0Y2wo
         inKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wahlQe2g3fyZOdMzE4NOHeW/SspvW2KMChHvizkHdbo=;
        fh=qpBjJOsoI75i7+iKHvFcJVpXhYZixLbQ+Mglv76OF30=;
        b=fLgfuyrooKttOwRdTw3q4icgy4EUThUpXlZq9KBsMN7gpyIU96HFaNfl01v9DUfen4
         uXmsdi+P3yekBn14cEcpaONQVfDZOKPx1J5jUqO2w5J9Gc2rAswrs8tva4UeNN1Nan7+
         P2BsPJO6/VR07Q2LOZz8p7J0hcK0Iby7A9izzA54guR5fiQ+dIqaMDV0V8GJnn6hUE9f
         R9V5pJKv4GfPAWJjRh3IgjRD/e3O130f+Lmp0yy+fNLWWcYMJ8dRePew3j6EeS8Y+ubc
         t4tkvjLkWUafvJHwy5GXtx9LYff56LYs5iCgEs/6Mbgdw77vrS7S/r457SQD4A90dKPm
         EIxw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794352269; x=1794957069; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wahlQe2g3fyZOdMzE4NOHeW/SspvW2KMChHvizkHdbo=;
        b=xBK2AvehuwVNtpG7glMYgOo8T39bClnzdxBrpDfCKDKHwDN6IK8KDpzfqUdFelknmc
         C3oT2bsd969oH0NCNfkYPnWxp0FJ7H4+Z/hvppMeZHxpkHSER47/dEEAxAvoeG22FtF1
         PfwvIhQ89T7qOEYRH5PRK5WOKWgpqdb3t7cLnID9DINmWMMVot9D+2K8NjQmXU6TgFgU
         HVoZaB5eiR0QJBFZYeD+XM0RLo9FM7sEIvAyTm9w8wZqxyi7br6RdSmZrE6RWarKysrT
         C9LezvHe6TbUXQduCJ5+inG41JF4bpweXSSZHuJrsIOAtRFfLxhy/6N3ThrUdzbdj4js
         7taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352269; x=1794957069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wahlQe2g3fyZOdMzE4NOHeW/SspvW2KMChHvizkHdbo=;
        b=Nsw/UKk3fv5fBGlAiFGEkST94ibhLM2Vx2Cl9sT2rECBPgeIN/6SCQTJ+2Lj6iewki
         irvx5fhiH8SRt3HvjE0DqxJNDG4KLgEYpcV6pOGwK1ROcdNsLIcfbtGZ6v6m3QIQAnOg
         zSMXsIYdaE5Ropgpih05ECZXJQy430IKEA+6Zlg02SHkQgPoidiQVLlTE0Dcpej0gqf+
         L+VfUMdH/G2drZydFewgmKbLB1+4wk1m2CnmfRk9A6bwzn/i1vq707I5Joiv2OgSngV6
         mSQ/5uSvDkt2vEKE2lgOXkfjxszKaTya+8v2mmdc5vi+rCT2Vf0yLhge1ei5gOTmhpZ8
         +L/w==
X-Forwarded-Encrypted: i=1; AL+hErG1wZTidQC5uQujauHi34lKa1KS6v4DOdfyFUQR3p+3od2j2b687+obaJuxSjyaaJopiwXNSQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VJ+K3WZ8cdmxqOiz0QRCm1BBvnSjXaM3pTmdSx04znVOuEnkQ
	INmzd8vYUf5exuXeBwPm+CNZjDkIRgpGJx4m0/jP+GWRNFWO9w+uJaGZelKaGvCtaZDvSuZ6EQZ
	qXIqAkbVRSxYqnYXY8uHY3SRo9THk3DE=
X-Gm-Gg: AYBFou14Pgrvp+pyGRlaxYV214vsW1JnR9viQCksJrXUgPKe8MwiwcSHMTrp6gXJ25L
	f0yJ2vD2WN5/UaOPp7lBCIbq2Pjm9g+FFhz+dp19KGk2KKv8LLw25+xgyhg88X+v3Kjz2JAJFs7
	jnUeLvhfLKHjZbbk7wjMiDljYO9ZYZHBd27J5clU68VH7EbOd9kMYY8Pzc1pQw/RiUx2lIFjssG
	MVmzEhJrIOVtJ06pzThmd4DslATe67yT7peK94Wjrbyft5AXTbm/YH1f66B5GM5vu9Z+VKyrr3l
	MdPSwWooVEuF7xuj3FaPLuD9T3kdoiKEDvPgirB1fLbHXjqhnLd5R/MNxYbpod5/PD17u9cFMAd
	RTZ4La35FagxSkpqIPZ+yOX8ARrdplcscBGtB5BahPjbQIfg5S345VAqhIIjVmyoIQE8EZsTLAN
	S6SxHKQyuOxiFJb8iVGw==
X-Received: by 2002:a53:c3c2:0:b0:67c:191a:b1b6 with SMTP id
 956f58d0204a3-67c6804a36dmr465377d50.92.1794352268572; Tue, 10 Nov 2026
 15:11:08 -0800 (PST)
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
In-Reply-To: <sashiko-outbox-206041@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Nov 2026 15:10:54 -0800
X-Gm-Features: AclHuK_x9P6OqkboG6qb5NIkTUFkL-irsJ3EWWNoTZvU-iCZdnPmiRbQT2ahxgc
Message-ID: <CAJnrk1aQrRE78wqd2yZWS2Sk8MiCHd9x0dveZBh5LHE5w75nkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm: memcg: read root lruvec stats from the node counters
To: sashiko-reviews@lists.linux.dev
Cc: akpm@linux-foundation.org, yosry@kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	sj@kernel.org, david@kernel.org, ljs@kernel.org, linux-mm@kvack.org, 
	damon@lists.linux.dev, tj@kernel.org, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 6:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] mm: memcg: node_stat_includes_unaccounted() omits file and
>   writeback stats
> --
>
> commit d2ba314724a8ba015e3bf2a30f155f1beba25a8c
> Author: Joanne Koong <joannelkoong@gmail.com>
>
> mm: memcg: read root lruvec stats from the node counters
>
> This commit changes lruvec_page_state() and lruvec_page_state_monotonic()
> to read per-node vmstat counters instead of rstat values for the root
> memcg when querying stats that only track memory charged to a memcg.
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1ebc9330aeae5..2575bf2ba0ea6 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
>
> [ ... ]
>
> > @@ -504,13 +511,52 @@ struct lruvec_stats {
> >       long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
> >  };
> >
> > +/*
> > + * Whether the node counter for @idx can also count memory that isn't =
charged
> > + * to a memcg (eg kernel memory that isn't accounted). For these stats=
, the
> > + * node counter can be larger than the root memcg's value, so the root=
 memcg
> > + * has to read its rstat value instead.
> > + */
> > +static bool node_stat_includes_unaccounted(enum node_stat_item idx)
> > +{
> > +     switch (idx) {
> > +     case NR_SLAB_RECLAIMABLE_B:
> > +     case NR_SLAB_UNRECLAIMABLE_B:
> > +     case WORKINGSET_NODERECLAIM:
> > +     case NR_VMALLOC:
> > +     case NR_KERNEL_STACK_KB:
> > +     case NR_PAGETABLE:
> > +     case NR_SECONDARY_PAGETABLE:
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +     case NR_HUGETLB:
> > +#endif
> > +             return true;
> > +     default:
> > +             return false;
> > +     }
> > +}
>
> [Severity: Medium]
> Should node_stat_includes_unaccounted() also include NR_FILE_PAGES,
> NR_FILE_MAPPED, and NR_WRITEBACK?
>
> For NR_FILE_PAGES, swapcache operations such as __swap_cache_add_folio(),
> __swap_cache_del_folio(), and __swap_cache_alloc() update NR_FILE_PAGES
> only in the node counter while accounting swapcache in the lruvec under
> NR_SWAPCACHE:
>
> mm/swap_state.c:__swap_cache_add_folio() {
>         ...
>         node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
>         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
>         ...
> }
>
> Reading node_page_state(pgdat, NR_FILE_PAGES) for the root lruvec
> therefore includes all swapcache pages, which inflates the "file" counter
> in the root cgroup's memory.numa_stat (double-counting swapcache alongsid=
e
> "swapcached") and causes it to diverge from memory.stat even after a
> flush.
>
> Similarly, __folio_mod_stat() -> lruvec_stat_mod_folio() updates the node
> NR_FILE_MAPPED counter without updating memcg rstat whenever an uncharged
> folio (folio_memcg(folio) =3D=3D NULL, such as a driver mapping or a
> root-cgroup __GFP_ACCOUNT kernel folio) is mapped into userspace, and
> nfs_folio_mark_unstable() and nfs_folio_clear_commit() update
> NR_WRITEBACK only in the node counter for unstable NFS pages awaiting
> server COMMIT.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015321.61=
1093-1-joannelkoong@gmail.com?part=3D2

Thanks, this is a good point about the folio stats.

Hmm... I wonder if we should go with an allowlist instead of a
denylist. The allowlist is longer (31 stats vs 11) but would be more
resilient to failures (a stat missing from the allowlist just reads
the rstat value whereas a stat missing from the denylist will silently
report the wrong value) for any stats added in the future. Any
thoughts?

Thanks,
Joanne
