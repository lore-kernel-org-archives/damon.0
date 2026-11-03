Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793745423;
	b=I/cu068A/HSZO18eS6w/5pGXeg+8TsnlFtbtG8+W30Aw24oViRhXZRfrQr53vjJVspXQ
	 fpXbHK1IQs10rIyodiDy3zdnwJ1WQG4fsHQtDsjwe/Uhvv+W8NNqwRucCQpHDQAaSdh4z
	 Cc6LOM+zoA/rQl4OxQf6nDx05ZXao2Zn80bzexP43pJdUsNGA4vWbcrpRpUEvH3cOYUqm
	 kqansazt/xFsezU/Xljj/o1LU9UkHhc5J/uGt5s/9vSVL5/7OCMFVBwVGCBWWSkylxVRi
	 ynnDBH/0jn1ia5vfQzOhLvEP9Mv2TD40aAReM78w1LJYwAgqJF1n4ikcikpSfucfAqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QVC6zXtmTlj5EAbSSjNHwPP18DR41YQR4sifDw97zsg=;
	b=nQKYjucGtsigDlhwGTBRwyXYiJksvNIqPk4tX8ll9el0ySk3DXEJWqTwqKAJQr4nXZNy
	 CxcmcqSoFHH9ZLbe6Kgddr8rIfVQQhyZ+sHJGPiLGP84XTpKwPJifMsgax4e300Oh8l3p
	 AGs3COSdJjp29E0Y42izGWGQZkJ69UW/49qjE7Wd2bjHZabbf12heAJRcd/XGh0cDa+Al
	 oigU47izhomZX0/Nb1DBXtjKWys+dbipd9UW/G1lLcFpnpUlIAiAqUd0huyCaFEGpsGyM
	 F3T6NoRb/LbymhIAa75bRj3CmR67bWKGLSamclXTGozAfeDhXO4v3eZaMFZhbOVlsjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbsaTqdk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB44606A326
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 22:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB44606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbsaTqdk
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso67314f8f.1
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 14:37:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793745421; cv=none;
        d=google.com; s=arc-20260327;
        b=N6FIAhnl5IpHwgziLczOvjFRtMMgaPfZQI7XHSNgkDCNYTtfs9T//4e4cXHRRZ2KmA
         hmg80D/kDtf/DdSjmbyAs8XKQImZP+bYjtBQrMh4SRisXAE4qXiReARRZFH4FUCiZwtC
         FBJ/3k3D+CcFafmO1KYKeTf23mMEm3vvCmriiVFvRRuI7et0JMjyUaAjBZn0ivIYTn8c
         CiD1VxwfitNEf/uSl1Pf3wbapx2mRgfB7EFOX1WCvaLlRTV4QCfvvEPQNHTMg+k+cjw4
         oz7lx0DlW6wYelUJ0zv64mepzwqz+8Q8o5NponuPyK4rdaz+qYFDpA7c4KPj4rK3Y39z
         YtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QVC6zXtmTlj5EAbSSjNHwPP18DR41YQR4sifDw97zsg=;
        fh=Uyz6uov84LL21LMcw7MvpoN6BToxnCshBwvcZmjJXw4=;
        b=mznkKURDOnXuW6pBVG6MUO55X8U+PgxPm8YqPSaFa66NWV+MdbeuHRN/KY0YcypVtG
         qyStb2Wwgbw0b7N+yNgXHQofz6nPYZU6J50bMMjBk9gVlWPqcGFSjfF9Kwa5eCAVbYiu
         sRf5TT/ni7is3zqBm4czsis5+B5MB4O1KboupxL22bjjetWkB34GWrOvssvHr0yBL3xm
         16d8uoI+EADd6SY1JO58Z309qaNgWhPY0+lwXitRs9pii2bCh8oTykwoMIHqcmpkHjhp
         zRVBes39YGeE5+x/ChtwEHs8MUKISIa+BsWnd/SapP3TdChXU/lVmf7KAF0DWR4nSQ1c
         sN5g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745421; x=1794350221; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QVC6zXtmTlj5EAbSSjNHwPP18DR41YQR4sifDw97zsg=;
        b=wbsaTqdkVJnRAC49JtV6UXitxfV99KTUYXJxzerng5H0yiKF2SgslaC5At5QwD7pGm
         uXEcjoLJYVbHoUztuV2TSzExjGunaGgslTjVrs+cQI9V4+B9q+4ePDxFf0wsNGYJp1Rj
         lIEY7TmH51tOppSdwe5J70Ser5s2jjM/l774TJqGDhFZMdSrP8nejGDtRg0BY0/NVzII
         QRqZZah6fNxSdTJYvhDSYaqyYyToPrl20lbXBr5E05vQfTgR/d4ewLyqhwVtbeC0Nb1V
         WgmR3kxjItzvMAGKMozsX+l4xzDWczDbCcG8AzfQqFXPzA9auAJTIQDcQMGRuClE5wpr
         pxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745421; x=1794350221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QVC6zXtmTlj5EAbSSjNHwPP18DR41YQR4sifDw97zsg=;
        b=JIMNR8O2e2/EFa1xWDQ4RMO8709+SlhXP4C5dazFHDLv9YSbXMsA65Aeq/J61DbB/v
         J0/73FSY8vmjvpurtFjeXBm8+LN2TCvOSREzEi3JCEgWa4GJFmCTWrAChlXj72vuqZj9
         01ihk2QgPKbp5P7fOG22Jf/FDiP/MfvNCNBXtvWPz2Xo7/NfiXwSjIVCQrWI+mPH3QBl
         MruHqaQQ2/w9Xq12nxCNj6WgQTDws032GWDV5UC8t+jSnm3RRhjQ6S8VD0tlb7qIJFGl
         xXOR+b48nLCocKbdIZ4c2TPV0Qxpk4FBWGyG+d7NcBHcq/p3ocW1dVjslmBCV5uQ7hi6
         mndw==
X-Forwarded-Encrypted: i=1; AKwUvBxfmre4SklE0XXZD1ZJXKcz/Jiddc2rUXYHlLnk4VCakGi+rzsj5J5MKGkj2ZiLZ1MZ8ZpiEA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8X8vXBQlC0OVdCGaQBSUvOQflFPkz0reFAjlzwJMUfqGitZq/G
	tmudvfmgdHUj9coxUnDPxfgM/7Ox2xU1JbD48MF5THqUp2zXCVmPAGAmaqyoS34OwU0ebIant3c
	aS+2CgXsTgMYowkj2oydud09uYu5SaYk=
X-Gm-Gg: AYBFou2yu2nB2+7/ocNOOgexMEEzRxx9qghWhnNlXMyPGQ1h7XyROvOq5+yw7qAHcu3
	nnKqEwYtWCo6p7UabEKO3PW6zmYO9amYThaO5GXj2B/rck4wpJPKeixK2vXn+ic6RFd16bqe2oR
	Dh7Xm8kUHzdyGYcvp1zVBOowMbcEm46JyLfKTWnyeP2iPOgnDia0nAD3vh2q+8v5HJrOgiK96JW
	jg0B/P/gc9UDneczswrAc9F0jr/syG4gMBPt6zwWFFG6pOZq7Y6mpoSzBFKMm1IIYqOb/pk1FRK
	2OmaDPl4G9LE0Y7pls5OyAhqwpyiKH+PUlqcemyjbpDkzzauuNUDxHrTGTqvADxpYTzDDrzQ3Tw
	Ck2W+2aoPoZCQiTMLI2ZYDDw6XJk74qxRGPm/Jvsd+ta4aq+LbzOKugma+QHiZrEEi6uyFHsNFn
	VVIUR31TM8XJPwXGi10g==
X-Received: by 2002:a05:6000:4027:b0:48d:f3ee:7cc with SMTP id
 ffacd0b85a97d-48e6e4f4cc8mr30979021f8f.30.1793745420854; Tue, 03 Nov 2026
 14:37:00 -0800 (PST)
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
 <CAJnrk1bv-P_TQztAGiHYdfg=5hbj4GREML2M0Uxp5oC1R9J-Mw@mail.gmail.com>
 <CAO9r8zMvofnW-6OsiasiocOBqoRbZuD71dp3RQE5746YGzamNA@mail.gmail.com>
 <CAJnrk1ZAz2ro0-8CC7n8mEjpuRQ64=v0rABtygaw5e2Aohq3=w@mail.gmail.com> <CAO9r8zOa52hMRTXFQVnSWJPmijm+D-97AeZDH-MMK_-rGiSwMA@mail.gmail.com>
In-Reply-To: <CAO9r8zOa52hMRTXFQVnSWJPmijm+D-97AeZDH-MMK_-rGiSwMA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Nov 2026 14:36:47 -0800
X-Gm-Features: AclHuK-AYBaNZSpJUjEtODEKJtvEXTubSyokZTs8vMfIpK79wH5577sQO81jRN4
Message-ID: <CAJnrk1ZZdkrz+WSOFTCmCh0dwTLXcoCOOuufrh2JZMXqGw=Xtw@mail.gmail.com>
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

On Tue, Nov 3, 2026 at 11:33=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Nov 3, 2026 at 11:28=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Nov 2, 2026 at 5:00=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
> > >
> > > On Mon, Nov 2, 2026 at 4:34=E2=80=AFPM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > > >
> > > > On Mon, Nov 2, 2026 at 3:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.or=
g> wrote:
> > > > >
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index ac6c43ea8c5a..938843346571 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(cons=
t struct lruvec *lruvec,
> > > > > >         return x;
> > > > > >  }
> > > > > >
> > > > > > +static bool lruvec_is_root(const struct lruvec *lruvec)
> > > > > > +{
> > > > > > +       return !mem_cgroup_disabled() && mem_cgroup_is_root(lru=
vec_memcg(lruvec));
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * lruvec_lru_page_state - read an LRU stat of an lruvec
> > > > > > + * @lruvec: the LRU vector to read from
> > > > > > + * @idx: the node_stat_item to read
> > > > > > + *
> > > > > > + * Like lruvec_page_state(), but for the root memcg the node c=
ounter is read
> > > > > > + * instead. For stats that only track memory charged to a memc=
g (LRU sizes,
> > > > > > + * workingset, rotation and reclaim writeback counts), the roo=
t memcg's
> > > > > > + * hierarchical value equals the node counter. The root memcg =
can just read the
> > > > > > + * node counter directly instead of going through rstat, which=
 requires
> > > > > > + * flushing. Flushing the root memcg flushes every cgroup in t=
he system.
> > > > > > + *
> > > > > > + * Use lruvec_page_state() for other stats (eg slab).
> > > > > > + */
> > > > > > +unsigned long lruvec_lru_page_state(const struct lruvec *lruve=
c,
> > > > > > +                                   enum node_stat_item idx)
> > > > > > +{
> > > > > > +       if (lruvec_is_root(lruvec))
> > > > > > +               return node_page_state(lruvec_pgdat(lruvec), id=
x);
> > > > > > +
> > > > > > +       return lruvec_page_state(lruvec, idx);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() f=
or delta sampling
> > > > > > + * @lruvec: the LRU vector to read from
> > > > > > + * @idx: the node_stat_item to read
> > > > > > + *
> > > > > > + * See lruvec_page_state_monotonic() and lruvec_lru_page_state=
().
> > > > > > + */
> > > > > > +unsigned long lruvec_lru_page_state_monotonic(const struct lru=
vec *lruvec,
> > > > > > +                                             enum node_stat_it=
em idx)
> > > > > > +{
> > > > > > +       if (lruvec_is_root(lruvec))
> > > > > > +               return node_page_state_monotonic(lruvec_pgdat(l=
ruvec), idx);
> > > > > > +
> > > > > > +       return lruvec_page_state_monotonic(lruvec, idx);
> > > > > > +}
> > > > >
> > > > > Why not do this directly in lruvec_page_state() and
> > > > > lruvec_page_state_monotonic()? They already fallback to node stat=
s if
> > > > > memcg is disabled, why not do the same for the root? Are there ca=
ses
> > > > > where the node stats are not the right thing to do?
> > > >
> > > > Hi Yosry,
> > > >
> > > > Thanks for taking a look at this series! I don't think we're able t=
o
> > > > do this directly in lruvec_page_state()/lruvec_page_state_monotonic=
()
> > > > because I think there's still some places where the node stat and t=
he
> > > > root memcg stat are not guaranteed to be equal.
> > > >
> > > > The stat I was looking at last week was slab's NR_SLAB_RECLAIMABLE_=
B
> > > > and NR_SLAB_UNRECLAIMABLE_B where for those, the node counter value
> > > > can contain memory/stats that wasn't actually charged to any memcg,
> > > > which I think means for these cases, the node counter values can be
> > > > larger than what reading the root memcg rstat value would give. The
> > > > functions I was looking at were account_slab() and
> > > > memcg_slab_post_alloc_hook() where the logic adds every new slab pa=
ge
> > > > to the node counter but the memcg stats only get updated if specifi=
c
> > > > criteria are met (eg the cache had SLAB_ACCOUNT set or the allocati=
on
> > > > had the __GFP_ACCOUNT gfp flag set and the allocation was not from =
a
> > > > root memcg).
> > >
> > > If it's only the slab stats, it probably makes sense to special case
> > > those instead of the rest of the readers, right? It would be nice if
> > > the default behavior is reading the node stats that doesn't require a
> > > flush.
> >
> > If we were to special case it, it would need to exclude more than a
> > couple, I think. I asked a LLM and it says NR_KERNEL_STACK_KB,
> > NR_PAGETABLE, NR_SECONDARY_PAGETABLE, NR_VMALLOC, NR_HUGETLB,
> > WORKINGSET_NODERECLAIM would also need to be excluded.
>
> Interesting. So for all these stats, root memcg stats (from
> memory.stat) is not the same as the node stat? They all draw a
> distinction between "accounted to root" vs "not accounted"? I wonder
> if this is intentional for all of them.

I think there's 2 categories:
a) the allocation isn't acccounted to any memcg (eg kernel page
tables, hugetlb when hugetlb accounting is off, unaccounted slab
caches and kmallocs w/out __GFP_ACCOUNT, and most vmalloc). These
values only get added to the node counter

b) the allocation is accounted, but it comes from a task running in
the root cgroup (eg kernel stacks, user + secondary page tables,
accounted slab, etc)

I think a) has to stay as is since it's not linked to any memcg. For
b), it seems intentional from the original commit that added kernel
memory accounting logic (commit 7ae1e1d0f8ac ("memcg: kmem controller
infrastructure")). The commit message for that explicitly says
tracking kernel memory pages to a given memcg "will happen whenever
the caller includes the flag __GFP_KMEMCG flag and the task belongs to
a memcg other than the root". (__GFP_KMEMCG later became
__GFP_ACCOUNT). I wonder though if this was to avoid extra overhead
costs (eg for systems that don't use cgroups) on the hot paths, since
it would need to do non-trivial per-object work. If root read the node
counters for the stats that are in category b (excluding the stats
that are in both category a and b) instead of going through rstat
(which is what this series does for the LRU stats), there wouldn't
need to be any extra overhead at allocation time, since nothing would
need to be tracked.

>
> > We could add
> > this special casing in, but we would need to make sure any new stat
> > that gets added in the future that belongs on the exclusion list gets
> > put on it. If it's missed, the failure would be silent whereas with a
> > separate helper, callers have to explicitly opt in. I'm happy to go
> > either way though, so if there's one way you prefer, I'm happy to do
> > that for v2.
>
> I think we probably want to first understand if these stats are
> supposed to be different between the root memcg stats and the node
> stats first. Personally, I think the default should be the majority
> behavior, which I think is that node stats and root memcg stats are
> the same, so I am leaning toward explicit opt-out. Let's also see what
> memcg folks think.

That seems reasonable to me. memcg folks, do you have any thoughts on this?

Thanks,
Joanne
