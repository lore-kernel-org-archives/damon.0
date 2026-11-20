Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163787;
	b=UVC7/ELqlQ8oCmcGwjfkjnbza8UV5pE7gyY90c5ODYCAOkTFlD/u5kHOGfneIBC2b6U7
	 I6f8FsEvrQBuEOmeunjplgHz0ahJCxZzGSmOuCFE4yIQqqU9oaTYxI0q1XAdG0ui0TNPM
	 8aVO3hjcCchG9yNl2WF/r2tww2qkA9xBYgCj31WZWVL+G+49xjUxLgb/rc/DMY0ZHmS7A
	 FjpyOGTFUQlLhKxNQE7Bauu8H0ti6RL4Cl/cK8Qi0rcDPBCsIonACpRq7I59N6sJ/EN2K
	 cQNHtga22uAOTOEuBSlJAlwZGHTXrrZy+VpeO/SIy24eF2nOBmo0HAvcl8Mh9ey4ZOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3PBPgn34gFSzs0WFCPqDxaDrqwWGqL5ASuJDkNQ3rM0=;
	b=1tMf2NdqQZgBTwsx9uwzUg926fD9tQ3ZLHMOr5EvrSLf9lr+cS3xrllNm8bpQwJorNfh
	 U96o7v7rza0r37wvn5RExxTekhtUDKaWyR/rg+eJs3zf0pa9F6U0U2d/1maO/EDlsYzMw
	 E7TJof8vETVZdI7OvJ6y0IzhuIyKHrDMJfG8STV3eGUDdW2VFGj0dSxshqNfRsA7It9Ba
	 3l9X8Zg6UK0iV6HI5vWw/q6qnzR2QV/jXHwfXJY+2P/k+cm+EsUa2rJOqzFr/ll7w3Q/D
	 AZEUZ/8dVK6MNnsqntH3FtHWkWmT0TK+jbGMhgMiL/rFdpszrJxpVghircmzVaY0M1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uYiqF/iw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC14606A326
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC14606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYiqF/iw
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so1038185a12.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795163785; cv=none;
        d=google.com; s=arc-20260327;
        b=E2N7/Lgo5LIV65II0jv0Jfu0lbp3ZAu37hS5uR6x5T6NlaJfHa4KZCAJHsrEucnFb3
         OrOSwzqiJg5c8dRSDqkgocYDfVCHE6Ygg2h0FW/+QOf5NQ30Gj8EqA21HJNB1r3fV1lj
         BgbFSAE5Prll7L51R1SlRjVzbwyUN9CeidXMnGNUyK7pu8hb1fUtiDGugIVV/GWe/OkT
         mmu7mNBWTo5OoXCILmvQYs0TLkizs9e3hAsh8T7qfpQVVJ80BgNFm63ItqeZ1acJIz20
         7uEE+iCAr92v2fGJY32MwqsyKOQhJiJRca1th4emXOS2c30eBWydm9idZ7o4W9uZeZlQ
         CcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3PBPgn34gFSzs0WFCPqDxaDrqwWGqL5ASuJDkNQ3rM0=;
        fh=H69uUZwh1j6a9HhSCtjI7J4YwPEfCfZhdTYJiXLWDMw=;
        b=DptBffCH0gd5yXV++dSMcjiAHIByz8/mmUIFIgT4l2fqxSR0uMZpbzhXe56jH5dj69
         5CmxhcBe/b3SBGek6G//55f5QgiCvolzrIQ+mb+hqC/0fsUqZB9CcmPxQNbZ2rAX6Kyu
         DPhpelR8eLLNqCO0IF6oJipISmbBYVzpRmSSFOO4ZP8fx7G0PfTHxNZ6//epjWKejU2v
         /B/LfX0YTVfhI//Jz7rHqkLUqBc9xFHmQHsrnbkuccVKmMd323VaimSYp4Kq8vpTxCyH
         4dGjM7UpWXaF2ayXTUv3l0coID2hbvvSMa79GinFSRwMWaR0kdkKg1+R/R8S41Romx8O
         eP7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795163785; x=1795768585; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3PBPgn34gFSzs0WFCPqDxaDrqwWGqL5ASuJDkNQ3rM0=;
        b=uYiqF/iw3FqdpF+oZseWazw4HmVPt1Q1+HTsS1ZsTWfKRM6qmRfURTIDgShFF8Jlas
         exj4rIoPbgAB7hT/77cxog6uTJWxuK0rRzYNzmbAz81KcMKKXhzacxBQ3xZLy3TGsVPw
         d3v9ZlrhlMccAqB0sjLRt4FRQZe0kGmYjpBjB86JX4BLOnGb4E14BEj/0w/XeQxhg32F
         KLvSxEyEsv85u4tCmGXpMTvcTzxSeCbeLpykOABmyLWvSERhJTByoD0l3xXdIwwCA++3
         JxRnuIhxcDkpBmqSzy/jMTI9XuTepE4T4hvwpKrSqzP5CpSEmsecRkeSuLO21rBwaLXk
         l35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163785; x=1795768585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PBPgn34gFSzs0WFCPqDxaDrqwWGqL5ASuJDkNQ3rM0=;
        b=npxk4jHjOeYt6ut8CYtPm0EHCKOsMjGZpbcfLK9SXOTQpCet/2mcdz3RECRTikvY4M
         o99Mb0frp7ws51DP8drNCQIlPK8zSAsgr8MgYIPEi5jl3EVjSVjaXxbEWpqYGsmvXd7K
         wB583oCu4nvKzM8Nco8LJssyy+k57bG6fhhgMMw6S0RRpdGIHXdBhW7peD3Y4lL0wTh/
         JngNLgOtfYjSaSf4x/S8V/4M1+SmPVi6QvUTtbh5HzoRWqmwq+Pv9ozbvRK+qyf3pGsQ
         rgPv8psW+2brIlqb1M7xUB9T+0I0sw2uDS58sRa0FEWKpCQfMc8szdFScXPScCRWiAxl
         x3Ag==
X-Forwarded-Encrypted: i=1; AL+hErGghLHEOkRRPMGpYqo7sZMsyGL6dOp6fHeL6NZU7U5yzrz54Ln1XZCb3OgiSgnjirk+E7PQxw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8kj42j1vkQL/idmIeS8LmepOvNykPu6GYyS+lwYQykvLk5Wexa
	jZ0jWKCqRcywYOjvGTCFrC4Tyw16flKg345HQ7wxQrNTMqiGppjnQ994AnGjuHphn73+eXaEv1t
	opUpy3NOxWMUeuO7CUlrmQG5+KKabTdg=
X-Gm-Gg: AZFdTZeJ+csj6NiIt2XoBhlvu+GndWmecoYmhOAdPll/ZAeWGlwRz+Qf1aAZ3x0Pkwc
	ZhAc8WuZZPfEFw3pjtI96tmQS7EvTvysgskmtEeeGZFrO2HWJ9f2YOoFIHb5o1zhK5opZEcEX7P
	/ePmcgLiPirAQPGiouM9Vg1UmxayfA4MxvEYt25HgGDOdv6WKBgg/tzHnslUs+AKaUi/pCfUxg7
	X7hhKzJqVt41H0owqu8QM2C3ZZaZEMFWjCi+npJ5tGEPPlMcvz3+cXY2dFvqrn71xapFJqd8UfX
	5gRzlvxuwWRglbJN+ME1e62T+8D8MQ9Nj614EzWkeIkEYjzn1mDFPDNtX8vfGAqx+jk/k1OBfxC
	5y4Km8MMfxpKNcfdM2duUVhIYN1Djh0jtBlyfT2ooERYcPuGZWGcBerilN09+38Sn9w==
X-Received: by 2002:a05:6402:1512:b0:6ba:12e2:46f2 with SMTP id
 4fb4d7f45d1cf-6ba37d18d2emr1237841a12.8.1795163784752; Fri, 20 Nov 2026
 00:36:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-14-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-14-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:36:11 +0800
X-Gm-Features: AclHuK9a_uzFGbOjQzRBvuGpHT7FEd2GEgizUKayktzr9rLjRf8PKuN-UHaqZ64
Message-ID: <CAN_Opa9qsHLGSPUjUJB5rCfD8T_zE8R1YpipcmYCqv3tGYuO1Q@mail.gmail.com>
Subject: Re: [PATCH v5 14/17] mm/huge_memory: mark folio as accessed more
 accurately on split
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
> The behavior of updating the folio's access info isn't consistent for
> huge mapping splitting or ordinary unmapping. The page table's young
> flag has to be translated into folio's access info.
>
> Right now it only checks and sets the folio's referenced flag, which isn'=
t
> enough since folio flag updates on access have their own rules. Ordinary
> unmapping (zapping) calls folio_mark_accessed(), and it also checks
> if the VMA has recency to avoid false updates.
>
> So first just use the right helper here to be more consistent. Keep
> accounting the young PTE as a cache access, sticking to the current
> behavior.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/huge_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0d589be136d2..1a415a6704be 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3104,8 +3104,8 @@ static void __split_huge_pud_locked(struct vm_area_=
struct *vma, pud_t *pud,
>
>         if (!folio_test_dirty(folio) && pud_dirty(old_pud))
>                 folio_mark_dirty(folio);
> -       if (!folio_test_referenced(folio) && pud_young(old_pud))
> -               folio_set_referenced(folio);
> +       if (pud_young(old_pud) && vma_has_recency(vma))
> +               folio_mark_accessed(folio);
>         folio_remove_rmap_pud(folio, page, vma);
>         add_mm_counter(vma->vm_mm, mm_counter_file(folio),
>                 -HPAGE_PUD_NR);
> @@ -3227,8 +3227,8 @@ static void __split_huge_pmd_locked(struct vm_area_=
struct *vma, pmd_t *pmd,
>                         folio =3D page_folio(page);
>                         if (!folio_test_dirty(folio) && pmd_dirty(old_pmd=
))
>                                 folio_mark_dirty(folio);
> -                       if (!folio_test_referenced(folio) && pmd_young(ol=
d_pmd))
> -                               folio_set_referenced(folio);
> +                       if (pmd_young(old_pmd) && vma_has_recency(vma))
> +                               folio_mark_accessed(folio);
>                         folio_remove_rmap_pmd(folio, page, vma);
>                         add_mm_counter(mm, mm_counter_file(folio), -HPAGE=
_PMD_NR);
>                         folio_put(folio);
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
