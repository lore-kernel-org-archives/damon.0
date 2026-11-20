Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162886;
	b=ImGK30rrHXcxHKHUrzqicEz6MZ6lDtSFWhUvsC5tmUCBU+qwuG9+FF0jmKJp/VrDOkOy
	 rCtU7ci76vh4EaSZjquAvILNSix0Ngspw9MOvog5HPX32CxDiEaV7yWElMHg8xXa3LX6S
	 UeVx/0vbroVCRH6b6FH5gshEYnxNUm6whDXcpClMLuonLJFKrSXTByOKTfjXDi6hNlriH
	 KqnJVvysecBciUfOLowe0L+CbWHlTwUjy63K1Dqh1UIIWUOkH+iKxY4lEHX59For8gVPr
	 ZwHhVOLJxLfN+BeuW0SDMLjIAmJoPHQWMOGEpov99PQM00iFI/nJx8VFZ2oQEfLFJYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uOP5aWJGRtaVMkdWmgxTwssrKgIM3MZe/XfpLaSpJSg=;
	b=vIYvYureIseP51z0bCGTfLbmH4zi8Kxx9RSGVD3jz9pHZzsD9WcWoG/J5XTjEyE+XMjc
	 jpTCFrLZnct/TzqlPbdJ4uuG0nVpo9F7qhZ+x9icBhfRCV/Hv7qY4WmNjeTZXXlWKJN3V
	 NtUMil+AjrZwiYfjmj1UM6wT8v6xFK53EdHnvMmk8T5PApr1SQjRqs5/wFMiceajDseHB
	 oUlwObERqtaj3OpwOgm1bMQ02S3U6875tLTZesHHssnaUXLz+sTsppn1YD/Q4ChvKBiko
	 hjovtOgITbD8jUCYDkz1ODaClYfAyEhICR3mdUborCUttTy6++O0iO20fsptB295KBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sX0ut3TZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25628606A33C
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25628606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sX0ut3TZ
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso705338a12.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:21:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162883; cv=none;
        d=google.com; s=arc-20260327;
        b=IboFf7AgtzPhEzFf99wSrdBE4k0nOEWeo5dJOPwDyrFv1z0BkQqeHwp0nl35ePIu0m
         UY2EX0J9HMY+lR0ys7eyvbqjv9tfP8y/zov4i7mww+J18336xwESVjDTgvfNrHFruM19
         qtSoqDXPJi/E+XE6W+44vVqqIeLEJPw4xOkjxwMfc5m5UaD3m8EFLVI32QvS5dmuppMx
         YlSq+WTpXqc6XGgwJwc2e8qguuvMupCWVu9+ACGARDNFG0EvKmYJ4t54fzJQKM/UZxuW
         4y1SaSCqKZNSa7CZStdNS8WZvpocHbrc3DDgntQz8hmO+rUzv/GOSARQqUq3+pLD8Y4M
         iPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOP5aWJGRtaVMkdWmgxTwssrKgIM3MZe/XfpLaSpJSg=;
        fh=EkWoSaiVePlOF1gxDZk257+s1PugaCNfPVJUjhcKPZk=;
        b=deH4WgxNEWnqdiNtiwZqwAuy7WXn+F4FDeNRepz7DahEQhkopig44hAXAeRdX1ljqD
         jg3ammWOTFBfre9NtTXSxPe6fLEh+swc7NREAuv0E9LfkWhc6BilFWZ/MH3GMRJdm0O6
         e1fnp5JdmfeSxjGAmvJQ7UKJfdf+1F66ot2ns43O2m5udmlViracsJWylOe+f0Lqhgbw
         HYiZUNE7TpPJ5eRG4dLfaF7ZwigPqe8GAUcTuAN73dxdrsFuhYZ+cyV2bMPZbpNNRmiQ
         H6XOHjrVBC2k948F0R/1CXgEfg9g0/tHvTtQfSa69WYwfyqN/a+4vinkiMx6Tk0S+yaR
         ctYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162883; x=1795767683; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uOP5aWJGRtaVMkdWmgxTwssrKgIM3MZe/XfpLaSpJSg=;
        b=sX0ut3TZuHdHkweVm4RP+5hmFkGZnJCd3wiQcCJahl0yzNLUdUNb2wQy4LucmAzX+6
         5TTbygW/S1cE/W9Jg5NgNjx2/+QJlKbkfHlzULNAj8TqxvclEoAsonYqmcClYtv0Ujpw
         nYwNo9sWd42n5zIVpV414dVqwLZeMNilX1FB5yrY0yn1pRLvrx+DeJQIHllrfX6N89Ih
         bMcKollLMd+s0Jxl206yLfzRRVUgZJ+MYWrmSDOv6cpC5YMvx82C1zZkZhQP3v+T5O5R
         JmKajaG2/CaJIVFtNENib12RXO22SKuQatcN4UNAgNvv5PtyaAZU0I+IOM8pJWXmGDZw
         NHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162883; x=1795767683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOP5aWJGRtaVMkdWmgxTwssrKgIM3MZe/XfpLaSpJSg=;
        b=zhmWIWsWxszGa5eZPQHyoEPvSYo77R/kPPvQZzrXqQ8VozolKM/J+GgYdVzuO7ODkw
         U0jeeqb/CBBjYipE1T5r2tuOWNtsvvgJqzqWj9FgEYSZY8BNPCdBSdPp5gjiF4DjJ93j
         BYrlA/oyFE/Nr+owmz2xhhgVU2zj10/arFPmrM84ANhXDx8qqJ+zkmi/CXFP2candCST
         BY2mexD1ko7QwhA0J2RA6XJCCSDopym6q1cC0fPVm6LFRLsc+/LFgVEjyxT6VIDJFjM4
         0C/2V23PfHpxeULwAoEpf7RMl/J1CC3S7zbML3069Cl11uzDf0koQM76Uiy4SwocuWik
         Svzw==
X-Forwarded-Encrypted: i=1; AL+hErH44+tqdshJu8Gvqh5COhZ4zhe9cNcSnkCDOg1ijtYfX3HBgYwovIC3cVhJwgXV4qI6kSU8HQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9RW03YlHuOHQcoCLXhjRrEA4gKfiM1ko1klkEo6U/s1x8x3PI9
	7EVOmIgJjX0XL8dz1fIX4suzyzm50n6ncmaDX4oWO3eHdmx9F3WPDFF4lpDrSJ3PZGa/hRhnnWL
	//2Dt2sjd4xouwYLaTlsT3T1jbeW2H6k=
X-Gm-Gg: AZFdTZeoPffoWjLdJt2Gmpe/8WFda7mTA4Q7v0CRfvhvot1A97jHKvK7o8xrgpYadb/
	67YW6TDCnjq7pCQuQisIFylRWRu+GyPwPTznxqMBOYnpOoPCMti7LfKHmmUbTsfMyOHK1gaZOtl
	2FAv/EbeUnBK4BtdmQcStukvzhYUXVHr33PxOmyTwI5/xKa5NoItzUvBwNPYSV5EZ5kMlEiXRW7
	/7NFUewlVA5ScDp30/tatGhGD2nS/m5VsdJqXiXCNydSK6MENnhzfvdbv4V/KVG9q8FtOJEatXF
	QAv+YVpx7oM90I7yOWNoEDuCqSIpA5yQtqLJ9Ma6AvDy1iqtZMpacXXwA7HZfynmhhvxkbIWX4q
	rOfBTIX+jFk50dbmCg5TcEsZl9UIArlmXF9BP1H9RW39H5AiQFj5urWGShBIVmjc=
X-Received: by 2002:a05:6402:46d1:b0:6b6:efc4:9ebf with SMTP id
 4fb4d7f45d1cf-6ba37ac75b5mr1331883a12.0.1795162882855; Fri, 20 Nov 2026
 00:21:22 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-10-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-10-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:21:10 +0800
X-Gm-Features: Aa3M54pHysxbWD9vjPcsTe4RDZA-59shgtAMQxrcEcwNDlcrEAHTKKIWInyzYBE
Message-ID: <CAN_Opa-Nn_ps+x6gWkERRDWBXxt3Gqnwvfw_4rURaCdPiyTc2w@mail.gmail.com>
Subject: Re: [PATCH v5 10/17] mm/mglru, smaps: convert to LRU refs based
 operations for MGLRU
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
> PG_referenced is only the lowest bit of the folio LRU refs count
> (LRU_REFS_FLAGS) now, and MGLRU never kept it stable: promotion used to
> clear it, and now it toggles as the count grows. But with the LRU
> referenced count as a stable API now, we can use two helpers to provide
> in-kernel users a stable and sane reading of the referenced status of
> an LRU managed folio.
>
> Add folio_check_lru_refs() and folio_clear_lru_refs(), which use the refs
> count when MGLRU is enabled and PG_referenced otherwise, and switch the
> smaps paths over to them. The lru_gen_enabled() test stays inside the
> helpers, so its static key is not splattered over the few call sites.
>
> Convert smaps as the first user of them. MGLRU now reports every folio
> with a nonzero count, so the reading no longer flickers and clearing no
> longer results in an ambiguous status.
>
> The classical LRU case is unchanged.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  fs/proc/task_mmu.c        |  6 +++---
>  include/linux/mm_inline.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 22361607020d..f76a37d052b1 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -889,7 +889,7 @@ static void smaps_account(struct mem_size_stats *mss,=
 struct page *page,
>
>         mss->resident +=3D size;
>         /* Accumulate the size in pages that have been accessed. */
> -       if (young || folio_test_young(folio) || folio_test_referenced(fol=
io))
> +       if (young || folio_test_young(folio) || folio_check_lru_refs(foli=
o))
>                 mss->referenced +=3D size;
>
>         /*
> @@ -1686,7 +1686,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigne=
d long addr,
>                 /* Clear accessed and referenced bits. */
>                 pmdp_test_and_clear_young(vma, addr, pmd);
>                 folio_test_clear_young(folio);
> -               folio_clear_referenced(folio);
> +               folio_clear_lru_refs(folio);
>  out:
>                 spin_unlock(ptl);
>                 return 0;
> @@ -1715,7 +1715,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigne=
d long addr,
>                 /* Clear accessed and referenced bits. */
>                 ptep_test_and_clear_young(vma, addr, pte);
>                 folio_test_clear_young(folio);
> -               folio_clear_referenced(folio);
> +               folio_clear_lru_refs(folio);
>         }
>         pte_unmap_unlock(pte - 1, ptl);
>         cond_resched();
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 3323a3c7336b..14aab2b1ed08 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -508,6 +508,37 @@ static __always_inline void folio_inc_lru_refs_fast(=
struct folio *folio)
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
>  }
>
> +/**
> + * folio_check_lru_refs - Test if an LRU managed folio has been referenc=
ed.
> + * @folio: The folio to test.
> + *
> + * Returns true if the MGLRU refs count is nonzero, or PG_referenced is =
set,
> + * which is also correct for the non-MGLRU case. Kept as a separate help=
er,
> + * to avoid splattering the lru_gen_enabled() static key.
> + */
> +static inline bool folio_check_lru_refs(const struct folio *folio)
> +{
> +       if (lru_gen_enabled())
> +               return folio_lru_refs(folio) > 0;
> +       return folio_test_referenced(folio);
> +}
> +
> +/**
> + * folio_clear_lru_refs - Clear the referenced state of an LRU managed f=
olio.
> + * @folio: The folio to clear.
> + *
> + * Reset the MGLRU refs count to zero, or clear PG_referenced, leaving
> + * PG_workingset alone for the non-MGLRU case. Kept as a separate helper
> + * just like folio_check_lru_refs().
> + */
> +static inline void folio_clear_lru_refs(struct folio *folio)
> +{
> +       if (lru_gen_enabled())
> +               folio_set_lru_refs(folio, 0);
> +       else
> +               folio_clear_referenced(folio);
> +}
> +
>  static __always_inline
>  void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
>  {
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
