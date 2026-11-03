Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734424;
	b=FhaG34y4fK/FEh7t1cQ3zOyTOcavOKnNpkK0SvKyuNI6BfjLNmnIyxbRd1cIrd2uV3iW
	 mHsxwpsR4fj+tjMSL7eBj1DXdMGz5CTD/q5PfUAI/TvTf1jGlQglW2EVSUy9OnhRJ2SXy
	 7/t+Pk5waWzQ88QTQhId0FRQDJzE2vYy1DyOBTV5BfqeHWhuo11L2N1hhzpNrlC1EW/u4
	 yUPBfkt3T2bxr1eC2J98s0o3ch28ibBn0PCi/CIpD5m3xKwiFNyTXpbWMap5ByGcgfOOs
	 UQvOtxe3361bd0fpRTp6KMzJCePL8gy4t3eR0fYSgwLwsqk5B6NfSlMwXlMYt4AqTmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734424;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jRv7FYipiH4DqQ5+rCUwDRkUzjzUXk5k5BQEMlfi6u8=;
	b=2hDAXA+l97AZ3Gf7aVOCKrFjFO/ajs1euqH/lsc/x9cMc0mDYdkmT69lDqhHiPmy+4Q4
	 jBOhzf6yM4MjM2ThkQOmQOCm2wdQCdy5uAiNpEM/XIhqlDEu6GGqaJeea3URMXzJxNh2H
	 D9Ez8RD50MYIDlPNm3nzYtmLrlji7Fk34izdAAxxXB8riq91Hsaz8MeZN34143hEnbl7u
	 ekM+po2wP5A2H7Q/KFaYSr9ogzqdiJLrvVpt2cpb9TrIlSTGksB9wy7odWKN9motZ9LHN
	 HVjJZuL2I5jrKC6rwHZNWG9LQi7wH8jOqqZWq4fBdOr+4mwGZNDBW1cKWH87OphsTwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/1z4d1T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8A606A31B
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/1z4d1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0D51F00A1F
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734422;
	bh=jRv7FYipiH4DqQ5+rCUwDRkUzjzUXk5k5BQEMlfi6u8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S/1z4d1TPZ9AcH+itxhMJEsw7wWjDKsp1RhfAa1ULOi2R9gDWetOGvR2jk6/GEyRH
	 fuBBzNAg2iz//ldqgURus9EkJ0S2wOSPk0v+MwwZnjCNcs8S+agrd7Fu6LnDbE2oAk
	 pnEJNU9iKM9pUUSZcfrn2KxDeuzKOnexULXxOpZmOARDFmwKWqpSTtId4OnAo2oYed
	 ZEijnUNo6yvORH37NXVEgJXnHTGb1KR23roqIh6FVzZyYpYX258TBIoVbBn1QL3pmz
	 v4HecQOsrQPtceEMqj1L7Pv3n5hqbO0+g7Cfn/V9N1qSlxfc0qIxtLQKOVnBjVgwBC
	 nl6sR03rPZKUg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2e8c710847so662677766b.0
        for <damon@lists.linux.dev>; Tue, 03 Nov 2026 11:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx60+JokZnPMbLVETqW5nQ0HAUeHFMeOHKpYROTn1J4nADfGK/82eBKrlW8n+RCT4hNqor01A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zEgEYGIKL9E39oULVM90RrbPuDzzzR4PnJYyxWBkO/BvnvKQX
	0H7HfMl2JzRqoTwsKlslCJ/GtUrI98qRWAsVuohAnGip0T2ahZ4JIztc+qJ/QwFY5Yb1npoPRvC
	KW9ba2jZi9cgiXm4MMAvhJQkN+sZTLIk=
X-Received: by 2002:a17:907:2d25:b0:c2d:c739:30e1 with SMTP id
 a640c23a62f3a-c4ca7a9fa75mr1143730166b.32.1793734421515; Tue, 03 Nov 2026
 11:33:41 -0800 (PST)
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
 <CAO9r8zMvofnW-6OsiasiocOBqoRbZuD71dp3RQE5746YGzamNA@mail.gmail.com> <CAJnrk1ZAz2ro0-8CC7n8mEjpuRQ64=v0rABtygaw5e2Aohq3=w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZAz2ro0-8CC7n8mEjpuRQ64=v0rABtygaw5e2Aohq3=w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 3 Nov 2026 11:33:29 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOa52hMRTXFQVnSWJPmijm+D-97AeZDH-MMK_-rGiSwMA@mail.gmail.com>
X-Gm-Features: AclHuK9sBnbDrZh0YD95eyRdj4qiL2VNLTMVMO8HPo8s0hHhnjt9YDtLQC8vHkU
Message-ID: <CAO9r8zOa52hMRTXFQVnSWJPmijm+D-97AeZDH-MMK_-rGiSwMA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: memcg: read root lruvec LRU stats from the
 node counters
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, sj@kernel.org, david@kernel.org, 
	ljs@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:28=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Nov 2, 2026 at 5:00=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
> >
> > On Mon, Nov 2, 2026 at 4:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > On Mon, Nov 2, 2026 at 3:29=E2=80=AFPM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > > >
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index ac6c43ea8c5a..938843346571 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(const =
struct lruvec *lruvec,
> > > > >         return x;
> > > > >  }
> > > > >
> > > > > +static bool lruvec_is_root(const struct lruvec *lruvec)
> > > > > +{
> > > > > +       return !mem_cgroup_disabled() && mem_cgroup_is_root(lruve=
c_memcg(lruvec));
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * lruvec_lru_page_state - read an LRU stat of an lruvec
> > > > > + * @lruvec: the LRU vector to read from
> > > > > + * @idx: the node_stat_item to read
> > > > > + *
> > > > > + * Like lruvec_page_state(), but for the root memcg the node cou=
nter is read
> > > > > + * instead. For stats that only track memory charged to a memcg =
(LRU sizes,
> > > > > + * workingset, rotation and reclaim writeback counts), the root =
memcg's
> > > > > + * hierarchical value equals the node counter. The root memcg ca=
n just read the
> > > > > + * node counter directly instead of going through rstat, which r=
equires
> > > > > + * flushing. Flushing the root memcg flushes every cgroup in the=
 system.
> > > > > + *
> > > > > + * Use lruvec_page_state() for other stats (eg slab).
> > > > > + */
> > > > > +unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
> > > > > +                                   enum node_stat_item idx)
> > > > > +{
> > > > > +       if (lruvec_is_root(lruvec))
> > > > > +               return node_page_state(lruvec_pgdat(lruvec), idx)=
;
> > > > > +
> > > > > +       return lruvec_page_state(lruvec, idx);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() for=
 delta sampling
> > > > > + * @lruvec: the LRU vector to read from
> > > > > + * @idx: the node_stat_item to read
> > > > > + *
> > > > > + * See lruvec_page_state_monotonic() and lruvec_lru_page_state()=
.
> > > > > + */
> > > > > +unsigned long lruvec_lru_page_state_monotonic(const struct lruve=
c *lruvec,
> > > > > +                                             enum node_stat_item=
 idx)
> > > > > +{
> > > > > +       if (lruvec_is_root(lruvec))
> > > > > +               return node_page_state_monotonic(lruvec_pgdat(lru=
vec), idx);
> > > > > +
> > > > > +       return lruvec_page_state_monotonic(lruvec, idx);
> > > > > +}
> > > >
> > > > Why not do this directly in lruvec_page_state() and
> > > > lruvec_page_state_monotonic()? They already fallback to node stats =
if
> > > > memcg is disabled, why not do the same for the root? Are there case=
s
> > > > where the node stats are not the right thing to do?
> > >
> > > Hi Yosry,
> > >
> > > Thanks for taking a look at this series! I don't think we're able to
> > > do this directly in lruvec_page_state()/lruvec_page_state_monotonic()
> > > because I think there's still some places where the node stat and the
> > > root memcg stat are not guaranteed to be equal.
> > >
> > > The stat I was looking at last week was slab's NR_SLAB_RECLAIMABLE_B
> > > and NR_SLAB_UNRECLAIMABLE_B where for those, the node counter value
> > > can contain memory/stats that wasn't actually charged to any memcg,
> > > which I think means for these cases, the node counter values can be
> > > larger than what reading the root memcg rstat value would give. The
> > > functions I was looking at were account_slab() and
> > > memcg_slab_post_alloc_hook() where the logic adds every new slab page
> > > to the node counter but the memcg stats only get updated if specific
> > > criteria are met (eg the cache had SLAB_ACCOUNT set or the allocation
> > > had the __GFP_ACCOUNT gfp flag set and the allocation was not from a
> > > root memcg).
> >
> > If it's only the slab stats, it probably makes sense to special case
> > those instead of the rest of the readers, right? It would be nice if
> > the default behavior is reading the node stats that doesn't require a
> > flush.
>
> If we were to special case it, it would need to exclude more than a
> couple, I think. I asked a LLM and it says NR_KERNEL_STACK_KB,
> NR_PAGETABLE, NR_SECONDARY_PAGETABLE, NR_VMALLOC, NR_HUGETLB,
> WORKINGSET_NODERECLAIM would also need to be excluded.

Interesting. So for all these stats, root memcg stats (from
memory.stat) is not the same as the node stat? They all draw a
distinction between "accounted to root" vs "not accounted"? I wonder
if this is intentional for all of them.

> We could add
> this special casing in, but we would need to make sure any new stat
> that gets added in the future that belongs on the exclusion list gets
> put on it. If it's missed, the failure would be silent whereas with a
> separate helper, callers have to explicitly opt in. I'm happy to go
> either way though, so if there's one way you prefer, I'm happy to do
> that for v2.

I think we probably want to first understand if these stats are
supposed to be different between the root memcg stats and the node
stats first. Personally, I think the default should be the majority
behavior, which I think is that node stats and root memcg stats are
the same, so I am leaning toward explicit opt-out. Let's also see what
memcg folks think.
