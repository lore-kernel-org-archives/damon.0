Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734134;
	b=EXhuvz6htt8a/RNtnTP7VRz84LCvKujpqcmxcuBbwJAFKnBN3bq7CHsg7HvW3YjNzmLh
	 ntMEJ1AskP/AQXg23CT0sb4mAKDWmvcGzyRVClGFkChhRGDbcaFVQciXPGM1f3B9Ql+me
	 uDrRJObyvQZNu2YGlJ/xqTytCQhV1DIqUBBmr6JnWtRY54tWsjjmthMv7md7k3XQ6lhD7
	 BWx7p3MwH9on/p3buc62DF473ZVSSjCMGdydZm0WYOFCV7AknJkSJoDepcIAbFVJz80Nz
	 M7B2qDSLFZiDEeoxUAnNqPBUUukQApuRt2mvwyjx3dNYTYkArLYEQsUCFpYFvme1bgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t8nOrLjD6nwiDigTpfoc51j1sg2vY57/yO5mUWHgXYs=;
	b=qEBLuzhTYMpanqWn/UPB2Icvl4wo0bwoi9osk+wBFs9MtlRPVmQP4aj3cuhWBDfOZ9wV
	 RNwzYDiPsFf4AIbuHpqD8tRQ5M8TFJieI7Z4bhypTNCBAi9wXjgkKCqHkGdwGcILhGpkh
	 CciXSxJlBqh+ok4qqGCHgzjTW3POfnjeJoAmEtpDcTTv43T6xYVsctfiwXrA5X3Y4MG3x
	 Fr9+bys7i7kT7PBN2n3QuZtOD44zOjL91lPGxy8nk/REcwvUoDLdNWhuwRbxl2fVu2TpO
	 wzgmtUpEy/Wg10SeJ0e5A1k65k++xd/XUyXq4Vz5Fc2YIM4+HxeT0exYSPVHd6fs+JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ym3/6Bk1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A4606A333
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 19:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104A4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ym3/6Bk1
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so707857f8f.0
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 11:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793734127; cv=none;
        d=google.com; s=arc-20260327;
        b=AdE3RJPDNsZyxdcMhXk7V6aWb50GV6P+ph/2PdyCjcaCB6WUX0moSCxdeTUIvWcqWI
         eyEuQAL+K/QBjCbslin0ZRGXVxLd8Vw3JRhNak8ttw2hqP8ojTNBu5j38uflbsYQk4zX
         /QqvQ+bmcxtgVMGFH4bOM/5EW8jsotn2plmfxM0y755XqZiC04n+6t3Dot1BjTvgcUhS
         cM2ENKdksstlk0eTuQh+lVNmoSFfjC/hKAc0yTLey02egoSfNxrl4Mnj/G1EFSbbfRPS
         cSG8+BfruMxHc/xL6IQq3A/EpX4WlE0OJZfCdeWthboFdhrDCA02zQ5ZqTMoPVH2liRn
         2WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t8nOrLjD6nwiDigTpfoc51j1sg2vY57/yO5mUWHgXYs=;
        fh=wm4/U/c0LuynmFaYrpZsEI8mJzfgs6M1tiQbcdDvqy0=;
        b=SahGARNE08FZ0Hkvxv9/Qsw1pj7Lu/f360HGW4J/xLDGkYj0pt+N78lD+f94fdKhwP
         FWiQQU6qwSAwgKX8t5ft4GCyA/CNT9ydZmJ09LZdbRmAgN3WtVABvX9xJ9ckGQnEKuS8
         qEkFU6C/omGhdUiawiK3mAlw6o40uGhV5iHYDXwwrJULDTYutwmXL3AqYzThvKgSniCD
         P3bgVyXh260M9m3WvO7DLHvKg3gpbYjZjEHiVN+2DiwL/VV167recyWmYeod74W3rvvi
         qCTu/MN1C+j+a8T8/sl+cZ+Ks9LvJ1FlLQy/PdYfZi6KiAZmmU79C2ddBm9J65TEo+Sf
         8CiA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734127; x=1794338927; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t8nOrLjD6nwiDigTpfoc51j1sg2vY57/yO5mUWHgXYs=;
        b=ym3/6Bk1a/YwmlqHwoOW2gngb6G2PMQUDddmZ22T56wVKNsvLLwEiahQ1oSDy5LGOb
         ruAJQi9BzO6KADdOBhDlmTnm4bF7tWX0TNnBkgQwbQtOSpV2b60C4VJP587IStGusAp8
         oPcpVu4Xog10wMz6gNkDeaseHQ+F3XZfruCUUR32r+OTulXWjx5JkDKBKIHeZL5CiDfQ
         RpQfkX6pI/2paa1rhLN0NLVTqW579M9LXjZ+PuH0+ZvC6UhxUGuLloqAXy9lIOOIFqZh
         ZQTcsTo2qDP79JfzmJSIFo9oXtOO0jdEHCfSztQGVG4rTynVDaDHN+fElyZ+UWhliwSP
         kpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734127; x=1794338927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8nOrLjD6nwiDigTpfoc51j1sg2vY57/yO5mUWHgXYs=;
        b=SxvND0jYr1cHB+01iG1LIFLtPsn6hNDjBX7a5+JtoXG5niN5UxusZy8OxfiMByJc7D
         5rwPsWS8YgwDxFdd+DVtbabL7KmzgcX92V38pHEOVXwQ5F+TUxbC42SrjV3VMNCYmkFq
         QSoZLbuzMUYfQSM+eA39CoNtswcPhKXd8YkQ8hTIe+wnVhw3PUCGQKmnM9BzYHf/lrlG
         +RzV2HhHzS97G5eBibA1gZb6hoEwaOMlUGpQANmvFkqTEgxKNyUyRtTdiNB1aDLf2mox
         Y0j33sjczDeJhYBU7ljK1qhlJw261px0Y09NfaEDTuKpq9wdVkLDW1Sv594p1NzuxPY5
         +sPw==
X-Forwarded-Encrypted: i=1; AKwUvBwAN9oUhZ4YGfOCEK0CvB5S12tCMNnBxr9jChLi4NDi1N3kJl1R1BSaOawL14GaEgDX6NncjQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/faJAKDfhT3ycdeDWJDGbrNSQmtRoqvDG0V3Tq28nEdp0Y+wlK
	aEbtoKEvu2fQLUl6R/QncFCqfBmcK9oOHRNvboxjH1IeVidL6XO1r4Be8sHTFmVImwfofUqnDtg
	9Y5VQDmDD1io0B8RGHGh/xUWXbgZW/3o=
X-Gm-Gg: AYBFou2su5uS7erFr9dMe94HGrbVk3vhfx0HctnkD25fwXQTemCJGU5uJJIHo/WY0G3
	2VAaJvFN5Ucg+ve7G4GEZjyTqWVUIeNfg3vV9Vwbw8fg3XeQtNppZbxyG4H3TykvqbmsSNn6lJ2
	7JQAIVqVTmTPEevT7bZCU93z8eIGB34o5BsYkxvr68hWO5Mit6QClymK9yuj6GsbmFp5acbm21C
	N/sM+ZoEY1yofZlPLvXINInsnZmWxfJ10Jdr0dGiNOo9IckypyQuyazFDc7krtYR++081e7LL8q
	B/hlkNa3AwbKpY/zGgVb7yUeq8pl29eM4CTM7IdDDDNwgO3abmPiPNpadcR09nY5Jn4ubhdBmW+
	8B7FniQvIq8DNLxoExhWIW8OiiwoL3izf5Zo3hzvFPw5uVpHDa8Un2ajDqAELfsU8eC9yes61DH
	AQ/vfYs89SSpE5e9fCGrsYp/DvE7H87kSDYJuCw/c=
X-Received: by 2002:a05:6000:3101:b0:48f:bbb5:61c2 with SMTP id
 ffacd0b85a97d-48fbbb563a3mr5372701f8f.4.1793734127208; Tue, 03 Nov 2026
 11:28:47 -0800 (PST)
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
 <CAJnrk1bv-P_TQztAGiHYdfg=5hbj4GREML2M0Uxp5oC1R9J-Mw@mail.gmail.com> <CAO9r8zMvofnW-6OsiasiocOBqoRbZuD71dp3RQE5746YGzamNA@mail.gmail.com>
In-Reply-To: <CAO9r8zMvofnW-6OsiasiocOBqoRbZuD71dp3RQE5746YGzamNA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Nov 2026 11:28:35 -0800
X-Gm-Features: AclHuK_fv28I1LSA-uaRqmIKjly-WVjyuC4Z8VHCIcHxkEADag6Zx2F__lXwrn4
Message-ID: <CAJnrk1ZAz2ro0-8CC7n8mEjpuRQ64=v0rABtygaw5e2Aohq3=w@mail.gmail.com>
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

On Mon, Nov 2, 2026 at 5:00=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> On Mon, Nov 2, 2026 at 4:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > On Mon, Nov 2, 2026 at 3:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
> > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index ac6c43ea8c5a..938843346571 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(const st=
ruct lruvec *lruvec,
> > > >         return x;
> > > >  }
> > > >
> > > > +static bool lruvec_is_root(const struct lruvec *lruvec)
> > > > +{
> > > > +       return !mem_cgroup_disabled() && mem_cgroup_is_root(lruvec_=
memcg(lruvec));
> > > > +}
> > > > +
> > > > +/**
> > > > + * lruvec_lru_page_state - read an LRU stat of an lruvec
> > > > + * @lruvec: the LRU vector to read from
> > > > + * @idx: the node_stat_item to read
> > > > + *
> > > > + * Like lruvec_page_state(), but for the root memcg the node count=
er is read
> > > > + * instead. For stats that only track memory charged to a memcg (L=
RU sizes,
> > > > + * workingset, rotation and reclaim writeback counts), the root me=
mcg's
> > > > + * hierarchical value equals the node counter. The root memcg can =
just read the
> > > > + * node counter directly instead of going through rstat, which req=
uires
> > > > + * flushing. Flushing the root memcg flushes every cgroup in the s=
ystem.
> > > > + *
> > > > + * Use lruvec_page_state() for other stats (eg slab).
> > > > + */
> > > > +unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
> > > > +                                   enum node_stat_item idx)
> > > > +{
> > > > +       if (lruvec_is_root(lruvec))
> > > > +               return node_page_state(lruvec_pgdat(lruvec), idx);
> > > > +
> > > > +       return lruvec_page_state(lruvec, idx);
> > > > +}
> > > > +
> > > > +/**
> > > > + * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() for d=
elta sampling
> > > > + * @lruvec: the LRU vector to read from
> > > > + * @idx: the node_stat_item to read
> > > > + *
> > > > + * See lruvec_page_state_monotonic() and lruvec_lru_page_state().
> > > > + */
> > > > +unsigned long lruvec_lru_page_state_monotonic(const struct lruvec =
*lruvec,
> > > > +                                             enum node_stat_item i=
dx)
> > > > +{
> > > > +       if (lruvec_is_root(lruvec))
> > > > +               return node_page_state_monotonic(lruvec_pgdat(lruve=
c), idx);
> > > > +
> > > > +       return lruvec_page_state_monotonic(lruvec, idx);
> > > > +}
> > >
> > > Why not do this directly in lruvec_page_state() and
> > > lruvec_page_state_monotonic()? They already fallback to node stats if
> > > memcg is disabled, why not do the same for the root? Are there cases
> > > where the node stats are not the right thing to do?
> >
> > Hi Yosry,
> >
> > Thanks for taking a look at this series! I don't think we're able to
> > do this directly in lruvec_page_state()/lruvec_page_state_monotonic()
> > because I think there's still some places where the node stat and the
> > root memcg stat are not guaranteed to be equal.
> >
> > The stat I was looking at last week was slab's NR_SLAB_RECLAIMABLE_B
> > and NR_SLAB_UNRECLAIMABLE_B where for those, the node counter value
> > can contain memory/stats that wasn't actually charged to any memcg,
> > which I think means for these cases, the node counter values can be
> > larger than what reading the root memcg rstat value would give. The
> > functions I was looking at were account_slab() and
> > memcg_slab_post_alloc_hook() where the logic adds every new slab page
> > to the node counter but the memcg stats only get updated if specific
> > criteria are met (eg the cache had SLAB_ACCOUNT set or the allocation
> > had the __GFP_ACCOUNT gfp flag set and the allocation was not from a
> > root memcg).
>
> If it's only the slab stats, it probably makes sense to special case
> those instead of the rest of the readers, right? It would be nice if
> the default behavior is reading the node stats that doesn't require a
> flush.

If we were to special case it, it would need to exclude more than a
couple, I think. I asked a LLM and it says NR_KERNEL_STACK_KB,
NR_PAGETABLE, NR_SECONDARY_PAGETABLE, NR_VMALLOC, NR_HUGETLB,
WORKINGSET_NODERECLAIM would also need to be excluded. We could add
this special casing in, but we would need to make sure any new stat
that gets added in the future that belongs on the exclusion list gets
put on it. If it's missed, the failure would be silent whereas with a
separate helper, callers have to explicitly opt in. I'm happy to go
either way though, so if there's one way you prefer, I'm happy to do
that for v2.

Thanks,
Joanne
