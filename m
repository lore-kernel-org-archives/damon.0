Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793666069;
	b=RzidJDUOP50QVQ85hDRKO2n3LA30DqKkrEqvPrBr2kxPMthJKC+3auB7ZQIUwUP0HwxW
	 Ttjr9hLcENIIyH0HuyEpEHL3Qx6rdxnJFu2+qc7t2XJiZtpjfOc/6DOhxQMk0pauC1kwe
	 zxryF/kzCJODThFIMAZCCoLmv1Rvo/6xWun/Q9Hd2iGsi8Bm4IUKmhBJZ53UavWyXGAzI
	 6Py15Yast8FnBdE6tWsc8wmz34QPpGbAARI96q3NAytSMaGfD8xnDWWuFzfIK9XNq1VFK
	 YKtM7Rs3cj/NywLoBxounLaQJ8WzULPtOTHU4MIUfy+r8gshQWH6CFodpbPbGjpMhdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XRINIeGwYTp4FrvxpE2WlXAbCO4jFumeYsCTIBvLXl0=;
	b=fsRcx4o/Ff291epg9eDaiOHAQLYjwi4gsyEWbwf27QHWP53iOTmp3tLfHKsBUEI+h2X8
	 k+pKGX2Zvz7rfXsS3G0wcBYkqMAD5aYQtzUISdApm1N8ERW+D9EP82XxpezVU9RoEOo8Z
	 mJXYDqYJcSHHgQkGDHISzk/MOOFQHP0ysUFw+dfv8z/Yn5Sqshpn/MUNhh0esaRPUqZx9
	 SDNk93ESTYWIfASOjt6X+y6M+6vhOp8AwmYw6mWOjZh+r/aKgC75r9xXtDsHecgChB+Wy
	 ARDpV/nrhA8J76Q0nRxdZjm0wLnD3IhBcf876IRxrS7itTtYW1xAxbW5jbDorIY82gQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzmlf5mL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39C606A326
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 00:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E39C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzmlf5mL
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so18541235e9.0
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 16:34:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793666067; cv=none;
        d=google.com; s=arc-20260327;
        b=pEjkjDp4HVSqnp6fuoMxGxpjcWie/YEicyIGihVXwX3rAkCKFS0LdxUfVapqu0NBQ6
         4pDzTLYPfKpRnc0Q62ANz/kXchBOvfYhtTmUtAA/gXXkUebdez3V2CoPD4hQt/4HLBzP
         /oo7UdhCyT2FlEUPuOIbCgEsfBPyEkjtx8GE3NOy05zZ4SwFefe1Oxh6vtdRyU5Gv1pP
         efTpYgNzBu5zGDZb9n5UOMMAE1K1HmsKlyKEAlITx4d/2RfHplCr7cHlKjlWb9KPL9fY
         Mqm5E7XfvMgxqDtb/kXiT71gbKd7gmDy9tBfq5p+GWPyyD5+9QFb1rFjp2LJ4nPrmaol
         cmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRINIeGwYTp4FrvxpE2WlXAbCO4jFumeYsCTIBvLXl0=;
        fh=ijnWaiokitCy9zFhgxKjZ2T05hbGM+qP9KFbPR1Ozg0=;
        b=foPYSgV3LSoTLYqOZHWdIu7r+bVn8WL8bTGTJbBl2tbBzJsYBZGd8NacZIGxu+RpQG
         whCCiykkwCvr4vHdjDVWPsBoQWf+KeuYuQK+QWhwTx8SILivL2eqiUlySXSmpCJ/2807
         qcNszXAgPVD/51xV1HljrTcW3tFXt1efR8ZndzTquoZQF8lvLEMDTvTHTdOao1n+3ejd
         C36FjQFcyBtUkj9jVQKfyF16IqZkAXoaZ0DwJRW5vXz569M1XSmJUCAdfp5DHKs41Yoo
         PtQMGum4GokzDDaonrr7yWTVRrwzippvpWb9EXCUXh07lztoDktW5xMykiByYSmPaars
         0dRA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793666067; x=1794270867; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRINIeGwYTp4FrvxpE2WlXAbCO4jFumeYsCTIBvLXl0=;
        b=pzmlf5mLONiXx+/cijEfGwMTpjjM8oRZUnEn7/w1i7vGFPMaV6bkSk9yoe9uW2QDFJ
         f2ZL7imVu2X0TMcJ7YkNJmKHLo/fv/HdX8UjsRu6m4sJvFVuWicek+WPjL/m66BDhOde
         3UYkRaqdT2GqVwDtCZoK80GrhksFBPRY/Kd9Fo5n87upIvUDRQkt2ME8zfwlYChU5hRs
         PdduwV3x87tj0YT98RJOxBSu0mwuO+HiDCRfn8TdtjA3NyaG2zBkJYRs0ZmOQal8NbEk
         MACHhUxgXg7r7FT64y14Q0jcxfivYyl4khAreU509/MT2uRfo1SKWpKR1nyvOUopG7G7
         e5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666067; x=1794270867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRINIeGwYTp4FrvxpE2WlXAbCO4jFumeYsCTIBvLXl0=;
        b=cE9qeQzldiEzrmck+DCzZhwwRfH74wCOgcS7z0yCYp+OvEMBj0lawXE4FMQ3RTSDPC
         WdAg9ug5Oq5aYG7S5NeNgJBHRcIrqJI2jTDscqF+IKW71NjHR8eg7XdTrwGTFLysw8/M
         kQkzRoY+R4H1ujJ4fMe2/Ijw0JZPVWDoOn3Jw/bEHrfieYoZX27Rg9jrvKvXQ9bXAjtR
         niy7K+uqoF2TWaVIiR6mwUH/aXiK/b/OMJP8pTH8Q3+Uz4WOoV0jaljYcBI72gnOiieY
         Ek9XOXXN2oHo5747XNy5ZbqHxJCAxE3eE6siEuFsvzOwzg28CpGm1YAuE5kdK1iiCJB3
         n5xw==
X-Forwarded-Encrypted: i=1; AKwUvBwgm7JEUvKrFwQPuI3gdS5pqe15wngZpCdfL4PFbrfLElM7t/e/4BZ7UB+cEdcht55Dsu0h5A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRxUVO+8hbLjkCjvRXo1Op3RD7BZDodavpjkAW09WWfsNIl72d
	tKb/q3jq3di/PcomynmHpsEohTF+zl4eU6TDB9UD48BXA6Baw/KXzuSL5SMIwTNere8F/70BV3m
	CuMGhfnauUs1RtdinjV67DfRnXfWj+d8=
X-Gm-Gg: AYBFou1RSHEy1DHggxi9sRHuIk0XJ9sUbERnkco1UVvyBJ7vDTZbDtabG17uPE+m5Xc
	BQ6Nn9o/gIuIhuQBvpy1TBVQCfGyySBS2KCV88f6UJxBSNa6A8aMlZSpd0CuGUmTJqMrWjmYipl
	fEDryo3qGdVbtkTeVDjqQomBh8a9NOVfXrc2utCIyuQGS9TVxWpEIk4z9ur1jG3QMT0V1yh51I6
	tajHbZSMEOhE7FxBCnyD7diMwA7vm+JtTBSe/IkzfGBtM8jR6ulKhC89O2/0pQmANY95LlrH2ui
	gxdI2DpBVYIjsiR5Ah24NmlkNdTOa/eLKMdL5FkXvnPeOIiacQeG2NmKNEFAfIAkEqi43s4DNQV
	WXZyd8U2adEZDXd/GGpoRpcOioOEkGWUCAa2pYLKq4WkyXeEy9oKzqcNI8zsRKXGB9sfCVdJmAu
	XWrS3QQEU6dTMoLMgi4A==
X-Received: by 2002:a05:600c:83c5:b0:4a1:f377:5c75 with SMTP id
 5b1f17b1804b1-4ac19329ea4mr232160515e9.33.1793666066806; Mon, 02 Nov 2026
 16:34:26 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
 <20261102225030.2743129-3-joannelkoong@gmail.com> <CAO9r8zP87zRuoFqeKFcAJoCrOG8M+7HCtX6hvxwdLzuHUXD0Gw@mail.gmail.com>
In-Reply-To: <CAO9r8zP87zRuoFqeKFcAJoCrOG8M+7HCtX6hvxwdLzuHUXD0Gw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Nov 2026 16:34:15 -0800
X-Gm-Features: AclHuK-wLxIuA5jPEmYu8qdZs5cxSk24od2LIZMBLDhfUz5W71RVH8v1q8qN5MA
Message-ID: <CAJnrk1bv-P_TQztAGiHYdfg=5hbj4GREML2M0Uxp5oC1R9J-Mw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: memcg: read root lruvec LRU stats from the
 node counters
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, 
	ljs@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ac6c43ea8c5a..938843346571 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(const struct=
 lruvec *lruvec,
> >         return x;
> >  }
> >
> > +static bool lruvec_is_root(const struct lruvec *lruvec)
> > +{
> > +       return !mem_cgroup_disabled() && mem_cgroup_is_root(lruvec_memc=
g(lruvec));
> > +}
> > +
> > +/**
> > + * lruvec_lru_page_state - read an LRU stat of an lruvec
> > + * @lruvec: the LRU vector to read from
> > + * @idx: the node_stat_item to read
> > + *
> > + * Like lruvec_page_state(), but for the root memcg the node counter i=
s read
> > + * instead. For stats that only track memory charged to a memcg (LRU s=
izes,
> > + * workingset, rotation and reclaim writeback counts), the root memcg'=
s
> > + * hierarchical value equals the node counter. The root memcg can just=
 read the
> > + * node counter directly instead of going through rstat, which require=
s
> > + * flushing. Flushing the root memcg flushes every cgroup in the syste=
m.
> > + *
> > + * Use lruvec_page_state() for other stats (eg slab).
> > + */
> > +unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
> > +                                   enum node_stat_item idx)
> > +{
> > +       if (lruvec_is_root(lruvec))
> > +               return node_page_state(lruvec_pgdat(lruvec), idx);
> > +
> > +       return lruvec_page_state(lruvec, idx);
> > +}
> > +
> > +/**
> > + * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() for delta=
 sampling
> > + * @lruvec: the LRU vector to read from
> > + * @idx: the node_stat_item to read
> > + *
> > + * See lruvec_page_state_monotonic() and lruvec_lru_page_state().
> > + */
> > +unsigned long lruvec_lru_page_state_monotonic(const struct lruvec *lru=
vec,
> > +                                             enum node_stat_item idx)
> > +{
> > +       if (lruvec_is_root(lruvec))
> > +               return node_page_state_monotonic(lruvec_pgdat(lruvec), =
idx);
> > +
> > +       return lruvec_page_state_monotonic(lruvec, idx);
> > +}
>
> Why not do this directly in lruvec_page_state() and
> lruvec_page_state_monotonic()? They already fallback to node stats if
> memcg is disabled, why not do the same for the root? Are there cases
> where the node stats are not the right thing to do?

Hi Yosry,

Thanks for taking a look at this series! I don't think we're able to
do this directly in lruvec_page_state()/lruvec_page_state_monotonic()
because I think there's still some places where the node stat and the
root memcg stat are not guaranteed to be equal.

The stat I was looking at last week was slab's NR_SLAB_RECLAIMABLE_B
and NR_SLAB_UNRECLAIMABLE_B where for those, the node counter value
can contain memory/stats that wasn't actually charged to any memcg,
which I think means for these cases, the node counter values can be
larger than what reading the root memcg rstat value would give. The
functions I was looking at were account_slab() and
memcg_slab_post_alloc_hook() where the logic adds every new slab page
to the node counter but the memcg stats only get updated if specific
criteria are met (eg the cache had SLAB_ACCOUNT set or the allocation
had the __GFP_ACCOUNT gfp flag set and the allocation was not from a
root memcg).

Thanks,
Joanne
