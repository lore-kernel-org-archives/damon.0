Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5F3AB47A
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151040; cv=pass; b=lbyrzLfujfCFVM5BD3gWFqDe2G0TfKQ7HEsmweOtoV9o1D5eGvrCwrCAmOrQ2XnowD392ZQnZHylOoIwLGGFgbGlnJTD2OhMwBsl2quKYba1j6TU9xOZJm6N6yGJjH5I1c1lshfqwPbCoOKpR3PsVg3O2rw/I2F53IG3hc6gW0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151040; c=relaxed/simple;
	bh=ateyapjZ1+Cpplrl/O9ZlmzsqV17CoauWuDhejOISq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uy2++Wys3+skHL/WC0pVWkOncftYFKjC70LQ22DqQN8OhUVQ5r4A6CWM0y5ZI5Db+o9IkUGekpUIxRdBRK/g3I+AMhXpD+/XKaMxga27ygGmEx7W+RVp4JprYev7e5EK966dZltw7KRwO2jDFxvsS7wo+fcFmCRKcPBOWpAZu7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbuNz9Xi; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbuNz9Xi"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e3846d1caso1018365166b.0
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 04:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792151037; cv=none;
        d=google.com; s=arc-20260327;
        b=ntDN7XoZ5j5hHwtd0Zo67povKtjJTaQRubzpfZu9rgx7DfDqB+okNTrO6NMHaY/Zis
         /u2QT/RFoh5L9sSsV35Hlm6H3A4cp0qdQ4YzKsQxZ7wi/0hKhvqv8suMaNTpxSItC0fI
         pJDZ9gHGeUGcZoAqpRrG5rK0b1F82y2TFSZpez3wBAQUG/ZxXbjIeFf6Kq32pXWAoKOY
         a17k244Fc5BG8OFw6AdpjueNpFAIxu9cqJDED0ULG+HE6CmRyVQkqfxCBmxeAAFE7ro2
         wow4qw9mf1S8rbcYZnDiyta6UhOhDl9Cu/+5uqEi95zrLyw5EaSYc7B5EAwvGXUeK0gO
         /aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NKuM+jtVFLfZVcVKg6kbrg0atkxIvcUrEpQMeeRVJXQ=;
        fh=Fh+8VcyV6KReEyl5biA+iVrSQT0HlJZVYpma39hBYXw=;
        b=C4qzNd/mYYTo4tLuczJ7ReMlSse36t5RdvcQ+826/vsoLplEn0QpnEyy//ppThRkP1
         OxvybRC7FJf9SVX/NV1TsJp5anj6jaFwYLpph33MZlNawVr7bEW5WuWpr0ubJIsrKDvP
         LfER0k3z++0jRNSlc3oNWa6reqyHkbu85ikgl/qpa02FsPHDOJ5cv/ulEtdJfqtS3R1E
         uqHwCn7qb26pxV53Kqii9OXHefUW6oEWc2tM0E6TtasS8xPTBKPJ4cULnIEHlcvyoL+p
         vezlqaBARY3XV5DtXGkANpuKz02vh23ZBiTJ+n315eH6cAarSeHFfaOTSkHix2v2fkXf
         v6FQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151037; x=1792755837; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NKuM+jtVFLfZVcVKg6kbrg0atkxIvcUrEpQMeeRVJXQ=;
        b=SbuNz9XigCVk1iOAO12f4f813gyQaVe7Uay9al7gqbwbdfWP7snnCOu0sd8FV9/TmJ
         K9+5ajscDi93Qxeh60kSmX9zdqjv+Q3s9rhkZPT1SbS9D+z/eu0SBLzJIxVmrUeA9TWd
         j47ME6HTPEr9TLYC1RKUfVrPuci4ojxKVrX5eyTBBKO11BZMenN3Zq7FMrpdYAtjnLQk
         A3jtylmufpFotqvPEmpShoQPmxl9wykieuLizsxKBOcvySctFXXYh7GTN0/mRLCjTzpU
         2Bpqv3uxKhrXJ4Nw01+O0YR/Vi1Xss3lpnjj5S0GBl4qFCWnHpk9Ck4QnNOquRV2PYkG
         J4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151037; x=1792755837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKuM+jtVFLfZVcVKg6kbrg0atkxIvcUrEpQMeeRVJXQ=;
        b=OAU6b5p1vrJXEeqLYvThglFgCSXliLyOitLWAmE34iR/+HUdPnSabFbSgv+wkKsMut
         pLRzqA8HXfuu3pBMEYQ/ugA5EIOfa+16Q1X6pBfj6J6463QwxWAN3vZ3yYil9unQh1u7
         yjUsUsom5cwvXJximiIS+P+0S4D3dAaRo3OUL/V+NeYEKgXycfhQJyhAuY6NWrsYlyQf
         xjd9YyiS+MCEHH75xoYDNd1MJHrWc70jg4UuhrrMvxaHUZQalIrGvShXJ0YyUxKZCbma
         jjFKtaDG5AqYQZ3zWwZeeJfksSao7CNlDs3Hgcozoe8+5tkICfdMTzUV5ZzeqUvrDmUN
         u9Rg==
X-Forwarded-Encrypted: i=1; AKwUvBzCRfIrktikwaY6OPmB0QUdsoyoKIy7bbLMMYkBFmwSnipf4T6IauOKWngX6vzTn5zakjiZQg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvioapJqznrFmvewVpE9MuB0/aDV35llQrMjRU+RIaNGQnQuxn
	8vt2HroQJ2hpGBn1LPC9GvsOKYpRIGrvIHt2EoJFgR0PhOvzA/o6RYAilV94SsYWaDp+zyAnhI8
	CfbSgmRW5/8OunWr4rRavLjKSuLI+8/4=
X-Gm-Gg: AYBFou0jKcti+8sq06XKJ36FT242ntCmzmLc7XA6W7aMjiRrzd5p9FKztRkzSQ/IrCS
	pUOEDtdvkTqwRWet9A8cb6ZGUIu7PcgMDMkQjw3vG/M3MKpxGXzW+/GiX4Ecwy/JwunpAVvkDkq
	kFnLQXT0LCcAajdctg3r9YdEvS/4sKNkLl0Y2HOYBPJT6tMLG7Xw1paSWBgFp9Hc8TUkVOawzgt
	/rq8Tx52i8ovvtYkEcyLsplI0m5S1oHpfMdYH8vre9JpbEZGzQZEncCNkW8vC/fBCeKr4N51kso
	SmHGtgHH8rLMeE3th0Knms5Dg5XFvRCzdtQK7dhUTT0oVWhQo6LqFzI29idQu9qg4/GkmYWet7g
	SdDfjmsW1MWy6
X-Received: by 2002:a17:906:4790:b0:c25:5faf:b207 with SMTP id
 a640c23a62f3a-c31a9a10e7fmr2051644866b.3.1792151036607; Fri, 16 Oct 2026
 04:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com> <20261016084256.12955-1-baohua@kernel.org>
In-Reply-To: <20261016084256.12955-1-baohua@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Oct 2026 19:43:19 +0800
X-Gm-Features: AclHuK_vD7Q6cJy-PpEfQtWOtckePrdQvkfJvtJJCDIcYrRZMuAvFqbDO7Y_PeA
Message-ID: <CAMgjq7AtuK22FsuqvGRLVZ2eWrp-N4qQ_MHoXsXDkVBprekdDA@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
 and flag cleanup
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: devnull+kasong.tencent.com@kernel.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, 
	cgroups@vger.kernel.org, chenridong@xiaomi.com, chrisl@kernel.org, 
	damon@lists.linux.dev, david@kernel.org, dev.jain@arm.com, 
	ehab.ababneh@intel.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, kunwu.chan@gmail.com, lance.yang@linux.dev, 
	liam@infradead.org, lianux.mm@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liuxiang.277@bytedance.com, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nico.pache@linux.dev, 
	nphamcs@gmail.com, qi.zheng@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, sj@kernel.org, surenb@google.com, 
	tz2294@columbia.edu, usama.arif@linux.dev, vbabka@kernel.org, 
	vernon2gm@gmail.com, wangzicheng@honor.com, weixugc@google.com, 
	willy@infradead.org, ying.huang@linux.alibaba.com, youngjun.park@lge.com, 
	yuanchu@google.com, yuzhao@google.com, zhaozhengzhuo@uniontech.com, 
	ziy@nvidia.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:43=E2=80=AFPM Barry Song (Xiaomi) <baohua@kernel.=
org> wrote:
>
> On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay <devnull=
+kasong.tencent.com@kernel.org> wrote:
> [...]
> >
> > LevelDB Scan/Get
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > I also retested the LevelDB benchmark from the cache_ext paper [5].
> > Interestingly, mainline MGLRU already beats CLRU on this one after a
> > recent change in lru_gen_folio_seq that bumps new folios with refs =3D=
=3D 1
> > to the second-oldest generation as discussed. That change accidentally
> > gave random reads a higher hotness level while making sequential reads
> > much colder as described before [14]. However it's unreliable and
> > incorrect because it depends on LRU drain timing, and hurts some worklo=
ads
> > as reported, or where the sequential part is actually hotter (any workl=
oad
> > involving hotter large file and many small cold files will be affected)
> > which is reproduced below.
> >
> > This series improves it while covering ordinary workloads too and shoul=
d
> > fix regressions:
> >
> > LevelDB Scan / Get, Throughput Total:
> > CLRU:         4708.3 ops/s
> > MGLRU:        5026.9 ops/s (faster than CLRU, but hurts other workloads=
)
> > MGLRU After:  5179.2 ops/s (even better in all cases, and no regression=
)
> >
> > The hot-sequential and cold-random workload can be easily reproduced wi=
th
> > SQLite and grep. SQLite continuously scans and looks up a small hot
> > portion of a DB file, while grep iterates over a set of small files muc=
h
> > larger than RAM [6]:
> >
> >          SQLite scan & lookup time:       Grep iterate time:
> > CLRU:                       14.51ms               13281.37ms
> > MGLRU mainline:            567.05ms               13694.47ms
> > MGLRU After this series:    10.58ms               12930.43ms
> >
>
> Thanks, Kairui. I'll do a thorough review of the whole patchset over
> the next two weeks.
>
> BTW, do you think we need a quick fix patch like the one below
> for the above problem before this patchset, so that it can be
> backported to stable? I assume your patchset is too large to
> backport?

Hi Barry,

Good question, I think we can patch it first.

> From f9683205d2ab6e3b185022d7d5af3496dfe5f35f Mon Sep 17 00:00:00 2001
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> Date: Fri, 16 Oct 2026 11:48:06 +0800
> Subject: [PATCH] mm/mglru: fix using folio_mark_accessed to replace
>  folio_set_active
>
> Commit 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to
> replace folio_set_active") tried to avoid over-protecting
> fault-around read-ahead file folios by placing them in the
> second-oldest generation instead of the youngest generations.
>
> However, it abuses `PG_referenced` on read-ahead file folios
> for this purpose, potentially coupling their handling with
> normal syscall-based file accesses that also use
> `PG_referenced`.
>
> This could regress some workloads, as reported by Kairui Song[1]
> and Ehab Ababneh[2]. Many thanks to both for reporting these
> issues!
>
> The long-term fix is Kairui's MGLRU-FG, but in the meantime,
> we also need a quick fix that can be backported to stable.
>
> This patch reverts all of the original commit's behavior that
> abuses `PG_referenced`, while preserving the semantics of
> avoiding over-protection of fault-around read-ahead file
> folios by adjusting only `lru_gen_folio_seq()`.
> Specifically, fault-around read-ahead file folios with
> `PG_active` set but `PG_workingset` clear are placed in the
> second-oldest generation.
> Activated file folios and refaulted workingset file folios
> are still placed in the youngest generations.
>
> Build kernel cases in a memcg shows it not only perserve
> the benefit of original patch, but also even improve
> performance further.
>
> w/o fix:
>
> real    1m49.094s
> user    25m31.484s
> sys     3m40.959s
> pswpin: 662112
> pswpout: 2504415
> pgpgin: 4424336
> pgpgout: 10355273
> refault_file: 359626
> refault_anon: 670724
>
> w/ fix:
>
> real    1m48.913s
> user    25m31.639s
> sys     3m30.875s
> pswpin: 689815
> pswpout: 2689894
> pgpgin: 4422659
> pgpgout: 11043464
> refault_file: 326566
> refault_anon: 697138
>
> Revert original patch:
>
> real    1m50.044s
> user    25m37.137s
> sys     4m4.493s
> pswpin: 1349087
> pswpout: 4317933
> pgpgin: 7083597
> pgpgout: 17602735
> refault_file: 337676
> refault_anon: 1368542
>
> [1] https://lore.kernel.org/linux-mm/20261003-mglru-fg-v3-0-cbd4546a5bd9@=
tencent.com/
> [2] https://lore.kernel.org/linux-mm/20260901180704.168106-1-ehab.ababneh=
@intel.com/
> Fixes: 6cbdd9726fb5 ("mm/mglru: use folio_mark_accessed to replace folio_=
set_active")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> ---
>  include/linux/mm_inline.h |  8 +++++---
>  mm/folio.c                | 16 +++-------------
>  mm/vmscan.c               |  9 ++-------
>  mm/workingset.c           | 10 ++++------
>  4 files changed, 14 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index ab69b9930893..7aaff4e06e80 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -311,7 +311,8 @@ static inline unsigned long lru_gen_folio_seq(const s=
truct lruvec *lruvec,
>          * | Accessed through page tables and  | Accessed through file de=
scriptors |
>          * | promoted by folio_update_gen()    | and protected by folio_i=
nc_gen()  |
>          * +-----------------------------------+-------------------------=
----------+
> -        * | PG_active (set while isolated)    |                         =
          |
> +        * | PG_active (set while isolated)    | PG_active (files|       =
          |
> +        * |                                   | fault-readahead)|       =
          |

This comment is not correct I think, faulting file folios are not
access through fd, we may just better leave it uncommented.

>          * +-----------------+-----------------+-----------------+-------=
----------+
>          * |  PG_workingset  |  PG_referenced  |  PG_workingset  |  LRU_R=
EFS_FLAGS |
>          * +-----------------------------------+-------------------------=
----------+
> @@ -319,7 +320,8 @@ static inline unsigned long lru_gen_folio_seq(const s=
truct lruvec *lruvec,
>          * |<---------------------------- MAX_NR_GENS -------------------=
--------->|
>          */
>         if (folio_test_active(folio))
> -               gen =3D MIN_NR_GENS - folio_test_workingset(folio);
> +               gen =3D MIN_NR_GENS - folio_test_workingset(folio) +
> +                     (type ? !folio_test_workingset(folio) : 0);

This looks a bit hard to follow. Does it mean that for active but
non-workingset files, they are put into the third newest generation?
It creates more divergence of file / anon but if it work for now, I'm
fine with it.

>         else if (reclaiming)
>                 gen =3D MAX_NR_GENS;
>         else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(foli=
o)) ||
> @@ -327,7 +329,7 @@ static inline unsigned long lru_gen_folio_seq(const s=
truct lruvec *lruvec,
>                   (folio_test_dirty(folio) || folio_test_writeback(folio)=
)))
>                 gen =3D MIN_NR_GENS;
>         else
> -               gen =3D MAX_NR_GENS - (folio_test_workingset(folio) || fo=
lio_test_referenced(folio));
> +               gen =3D MAX_NR_GENS - folio_test_workingset(folio);

This is a nice change, but meanwhile the LevelDB and cerain workload
gain are gone too, we will again have a ~40% regression for similiar
workloads, I just double checked it. But that's fine, though, it was
never meant to be optimized that way, and the long-term fix can be
done later.

A quick test on another of my test machine using Tal's LevelDB test case:

CLRU: 3098 ops/s
MGLRU mainline: 3035 ops/s
MGLRU-FG: 3233 ops/s
MGLRU with this patch: 2194 ops/sec (should be same result with
reverting 6cbdd9726fb5)

>
>         return max(READ_ONCE(lrugen->max_seq) - gen + 1, READ_ONCE(lrugen=
->min_seq[type]));
>  }
> diff --git a/mm/folio.c b/mm/folio.c
> index 35e242b48870..2af724cecb31 100644
> --- a/mm/folio.c
> +++ b/mm/folio.c
> @@ -474,20 +474,10 @@ void folio_add_lru(struct folio *folio)
>                         folio_test_unevictable(folio), folio);
>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>
> -       /*
> -        * For refaulted workingset folios, set PG_active so they
> -        * can be added to active generations.
> -        * For prefaulted file folios, folio_mark_accessed() sets
> -        * PG_referenced so lru_gen_folio_seq() places them into
> -        * the second oldest generation.
> -        */
> +       /* see the comment in lru_gen_folio_seq() */
>         if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
> -           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC)) {
> -               if (folio_test_workingset(folio))
> -                       folio_set_active(folio);
> -               else if (!folio_test_referenced(folio))
> -                       folio_mark_accessed(folio);
> -       }
> +           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
> +               folio_set_active(folio);
>
>         folio_batch_add_and_move(folio, lru_add);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index daa7e37c2236..e82ba737c028 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -952,13 +952,8 @@ static bool lru_gen_set_refs(struct folio *folio, co=
nst vma_flags_t *vma_flags)
>                 return false;
>         }
>
> -       /* Promote on second access */
> -       if (folio_lru_refs(folio) > 1) {
> -               folio_set_workingset(folio);
> -               folio_set_lru_refs(folio, 0);
> -       } else {
> -               folio_mark_accessed(folio);
> -       }
> +       folio_set_workingset(folio);
> +       folio_set_lru_refs(folio, 0);
>         return true;
>  }
>  #else
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 1504f91cdca5..10d4ce202cca 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -319,13 +319,11 @@ static void lru_gen_refault(struct folio *folio, vo=
id *shadow)
>
>         atomic_long_add(delta, &lrugen->refaulted[hist][type][tier]);
>
> +       /* see folio_add_lru() where folio_set_active() will be called */
> +       if (lru_gen_in_fault())
> +               mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE + type,=
 delta);
> +
>         if (workingset) {
> -               /*
> -                * see folio_add_lru(), where folio_set_active() is
> -                * called for workingset folios
> -                */
> -               if (lru_gen_in_fault())
> -                       mod_lruvec_state(lruvec, WORKINGSET_ACTIVATE_BASE=
 + type, delta);
>                 folio_set_workingset(folio);
>                 mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + type, =
delta);
>         } else
> --
> 2.34.1
>

The rest most looks clean to me.
