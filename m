Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163761;
	b=tm6HRFWWVZ74q8SWqWoEAwSWk4fj0Fya1hIj4DdZgU8bFpebsYts4odmI8IzyYQ9Sy4n
	 wgB5/L70p2sfFKuWZffIBokqRCl9KPyJbvJ8tojBtdQsmbvC9bCoBs789y6OV2wxfL93S
	 r8NZnQyVUDToxemuv19v5UVU4YA9GkbXhotHaX8YjKoevjVXZlcVouUZ/+anPQ7RzK0ZP
	 W88dj1ziHdpt9kx8p3ad3xQnEr584WJ0R1RYKYknw9G4ZpKSj2umwlCS+U4I9IG5oA4ak
	 bvGTjYoeVwzcPEHG2AcqNhiE8L6M7f4AlOERwYw6r/KXb4WIKRIXbq8GwEcquyJ0img==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DSuUtXGnjpMqHENNRIfD4nz00o+v1iSCypFww/wg4kA=;
	b=evvr9KdkPR0B5lH1OG49ypCz0Xip0hZ2Jt44gNxO/3po5/+MYMesmVcThTI1b3usVw4T
	 CNVO6+sQtSd0IjwuZYZxiHTvoqD2b1sMN0DvkDs8dVMXVV62sXimwEJ5kLyPNl19xAgf5
	 mtHmHYio+QSplfBetyZc71cNJ2szuFhDM1UQrhyEx9ykbsqp8bidzLNAtXU/mU64m7QMd
	 jOUWzp8RrgsucSSl226qc6ZHYDMhazVUjYvkrqsFKiGKIkRh6qii1wR5vyXhL3CCSUBy3
	 7SRxpXyE6P1wZ+PjE2FmrBH0zh4ml7IehJLOMPSzFxMeT/hn6z2Ixl7tpIKEkuXuo6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeWEXQ8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DF606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8DF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeWEXQ8o
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b8815693e2so747395a12.0
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795163759; cv=none;
        d=google.com; s=arc-20260327;
        b=aDYQRJh2YJAdZfRE9rvb4SvNKV16SoD91ZOvwoey9UNcPv1c27/GcSDTDWhUEswG2c
         g7SDRHnKH5aM74ginteeqKwBChqDGFYknxX4TVamMrC2Zni8zpw24THLZg7i1/Dnk+I/
         TOslkZYz0MQ2RrJDROrdDA+edgENd/lFhJmsSEwb7d6G+39lM355u+UJcY1SKbmKEjrq
         sqoPJDjbz3BxLJEWVQobJMzQqBJD5tDaiJcqYc5rwRDk5enKSmNd9JokTkLjOemMVJ9k
         SWiwAb9rorU/aA9bvlGG2snYVs+hOnHWnOF1CMEbLCOb+m5faJpVqL+Rp5kmpBYuKQfW
         RJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DSuUtXGnjpMqHENNRIfD4nz00o+v1iSCypFww/wg4kA=;
        fh=DrFBBRA90Y0PTjNS0EUQ4W2fAIqA6pbLp5Qy6MY0iTM=;
        b=rwRFdH1AYitFlOXwSsyM86d2SZVucTvEJ61zVoLyOi/9YASDX3GJ3XPEKdGgxfIbJG
         aSZgnOP+VIqSFkY/llbeDcy4lU0HV3xh2Be8Td7keMAg+y/roFFlWggl0JAsB9socJHc
         jgyLMBXD++m9ALJEB5W939V6XIbc0UHhF31vX5hVONihTaDZQF8oJTAKk5cytkocrmFw
         CgXI3QKvouTX7oni++Z53NJMlYyxbm1XCMFndYF7z4eDm72ZGmbU1OYtg8Grk7Ta4SX3
         LWiBPyXPeLHf/gyM0XNDHMnmUQgWBZIRCNuucsdCHfjrxiW2W6vmvu+2zb2PkDTJEq0V
         sbVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163759; x=1795768559; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DSuUtXGnjpMqHENNRIfD4nz00o+v1iSCypFww/wg4kA=;
        b=GeWEXQ8orI4ew+rcRqsuVmJu258MLmwrwknIwh00wrcszk7Yn8Ed/SvxM3WOxIlTOe
         9gKSSTPzr9pl8eAoy4QBpLadCzddlO7XyjqKUMEwXotJ7UONQn/DPqiEjjB/TJMNEYhd
         YzFbKtxbjLvO3BbJ64P6OOFx7XUFnR0Aj1J1vzvwuGH0n+g1FBZXZsej8k7JlxBWpQkq
         e8FwkZ2tWaWAPeMaz1PoS2XgSNhcPVW334lI0/QRAExsiH1+UtWUAX7LRIJ70UOlh/6U
         cLHO/S7qP1XEiWU7qJNwHXy2WzoGeNB8Lt8p7H7s+4agcMiKc991dDYK+CQpyVyElD07
         LbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163759; x=1795768559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSuUtXGnjpMqHENNRIfD4nz00o+v1iSCypFww/wg4kA=;
        b=JDs9jzM7etxaQgwhHsn6FJe90//1zGVwMhHt53mHPfCwPMzyeD27zq5b648qhhs2+z
         MTv0fJvgBzivJh91mV0JY4msgLA/8SDwZofpAKSynNAxEo9tsneDXkSVWl9Jnf0Vz5b6
         EC+YN5I+nWbdx+AGrbnfGnBgEIt7OR0COCfrQiKWlbnRhIEetSnEIyYFodOOFVFuVvS1
         TeJ56AnaNr+U94+jMa9DwZ5J6cyYAZ+NG8ybkQarsimoIh0sPSxVKEjUBfvS0kif9ByE
         oEwT1YBPOTt4HgUHQjuPIIWyEItWCWlnIWL+tJ3OX9eAYTVOYb7dc5N5/YlZmv2vp+eN
         zhug==
X-Forwarded-Encrypted: i=1; AL+hErEQ5dUzrI0/zm95PtMuU8SWkLjpzjgo9jdUFmY0SLOU6EISmj1zptMbjfOA43AC9CFNf8wwcw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9soLQboOEmS615db2iTBX/g7pNChzKi71pw9O7XFz6lErzIr+i
	FjObbP0IeVcpbPUP68aROPvAqFmK54kD4uGNPj2JQYhLWa6lMUwQLqTDljpS08/CXfWJGhSkPJW
	STUDlx/x24zz1debFWDfu+AOi0mwAj7w=
X-Gm-Gg: AZFdTZeDF+WSY/VGmP7Eei2ePiuYCaJFBu1q5t975aMD3LzVx+gTzUiFPNNClPvJvV+
	D5BKYlCWSYYLJlqaLZL2WRVVTa9xGGhYW0Hw5uauu2rNYUeVpsEN28fIYtPisLrmmafOSLg+Uge
	SEACBPv5D3zT0ngGa7tilW4h40Zd1AlfM3/ocilMlwE8Likvs0ohPnhTo6NqR9Rl+dbXIRnhJmv
	ZIqV9kO5fr1rsjxI6LDDqlnsScw2rysKepHRbCR2Gd9dwSxsclksMc2dD54cjUFqBfGd0U5ly+e
	oRGvYEuCgA/9PAYn0IZLXhKJYamCgJTYaYyVa1kEHtLMXFknW1BJx/h1aw29mZoEinT3aih6MUD
	k8qkdOokOHyxuqedsHXFC/nwr7FR9EoPfHTimZq6APOn1gKo8/ERLx/ipD7HH+dZELw==
X-Received: by 2002:a05:6402:454d:b0:6b6:fec8:d0a8 with SMTP id
 4fb4d7f45d1cf-6ba37ece7b4mr1180315a12.43.1795163758738; Fri, 20 Nov 2026
 00:35:58 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-13-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-13-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:35:45 +0800
X-Gm-Features: AclHuK-_GFG5PkAWFBgYarA_ZH8s5VuYTvaSRhCd3qxcRhatbnu155-OV8JZlEE
Message-ID: <CAN_Opa9WKYNXyuJDixgbCzW-yWYXuoBTujSA_SWeQLzQzp_26w@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] mm/madvise: adapt for LRU refs based operations
 for MGLRU
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	SJ Park <sj@kernel.org>, David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> For the active/inactive LRU, madvise clears PG_referenced so that one mor=
e
> access is not enough to reactivate a folio, and keeps PG_workingset on a
> folio demoted out of the active list so its refault is still accounted as
> a workingset refault (PSI).
>
> MGLRU keeps that history in the folio's refs count instead, which now
> lives in PG_referenced, PG_workingset and LRU_REFS_MASK, so writing to
> those bits directly corrupts the count. The two hints want different
> things:
>
> - MADV_COLD resets the count in folio_deactivate(), which also requests
>   deactivation.
> - MADV_PAGEOUT clears non-workingset refs and caps the rest at
>   LRU_REFS_WORKINGSET after isolation, before handing the folio to
>   reclaim_pages(). The hint marks the folio as cold, so the
>   eviction shadow records the capped count and does not inflate the
>   eviction/refault counters of the hot tiers that drive aging, while
>   folios at or above the workingset threshold keep their PSI
>   classification.
>
> PG_young is cleared for both LRUs as before, so the referenced walk does
> not count stale history as a recent access.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/madvise.c | 54 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 14 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2d54cb9863ea..7486c492f437 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -360,6 +360,42 @@ static inline int madvise_folio_pte_batch(unsigned l=
ong addr, unsigned long end,
>                                      FPB_MERGE_YOUNG_DIRTY);
>  }
>
> +static void madvise_cold_prep_folio(struct folio *folio)
> +{
> +       /*
> +        * VM couldn't reclaim the folio unless we clear PG_young.
> +        * As a side effect, idle-page tracking loses recent referenced h=
istory.
> +        */
> +       folio_test_clear_young(folio);
> +
> +       /*
> +        * For the active/inactive LRU, a folio demoted out of the active
> +        * list should have PG_workingset so its refault is still account=
ed
> +        * as a workingset refault, and the referenced bit always needs t=
o
> +        * be cleared even for inactive folios. For MGLRU, MADV_COLD clea=
rs
> +        * refs in folio_deactivate(); MADV_PAGEOUT handles refs after is=
olation.
> +        */
> +       if (!lru_gen_enabled()) {
> +               folio_clear_referenced(folio);
> +               if (folio_test_active(folio))
> +                       folio_set_workingset(folio);
> +       }
> +}
> +
> +static void madvise_pageout_prep_folio(struct folio *folio)
> +{
> +       unsigned int refs =3D folio_lru_refs(folio);
> +
> +       /*
> +        * For MGLRU, clear refs below LRU_REFS_WORKINGSET and cap
> +        * the rest at it: MADV suggests the folio is cold, so the evicti=
on shadow
> +        * should not record its hotness in the high tier counters, but
> +        * the workingset classification is preserved for PSI.
> +        */
> +       if (lru_gen_enabled())
> +               folio_set_lru_refs(folio, refs >=3D LRU_REFS_WORKINGSET ?=
 LRU_REFS_WORKINGSET : 0);
> +}
> +
>  static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>                                 unsigned long addr, unsigned long end,
>                                 struct mm_walk *walk)
> @@ -434,12 +470,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
>                         tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>                 }
>
> -               folio_clear_referenced(folio);
> -               folio_test_clear_young(folio);
> -               if (folio_test_active(folio))
> -                       folio_set_workingset(folio);
> +               madvise_cold_prep_folio(folio);
>                 if (pageout) {
>                         if (folio_isolate_lru(folio)) {
> +                               madvise_pageout_prep_folio(folio);
>                                 if (folio_test_unevictable(folio))
>                                         folio_putback_lru(folio);
>                                 else
> @@ -544,18 +578,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
>                         tlb_remove_tlb_entries(tlb, pte, nr, addr);
>                 }
>
> -               /*
> -                * We are deactivating a folio for accelerating reclaimin=
g.
> -                * VM couldn't reclaim the folio unless we clear PG_young=
.
> -                * As a side effect, it makes confuse idle-page tracking
> -                * because they will miss recent referenced history.
> -                */
> -               folio_clear_referenced(folio);
> -               folio_test_clear_young(folio);
> -               if (folio_test_active(folio))
> -                       folio_set_workingset(folio);
> +               madvise_cold_prep_folio(folio);
>                 if (pageout) {
>                         if (folio_isolate_lru(folio)) {
> +                               madvise_pageout_prep_folio(folio);
>                                 if (folio_test_unevictable(folio))
>                                         folio_putback_lru(folio);
>                                 else
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
