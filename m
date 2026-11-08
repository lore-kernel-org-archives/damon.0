Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176103;
	b=NWm8pkGhBrXfFvc3EB0QNLaSYQv7OxIupPSMbVkftFc4GjTked3wLupzR77b+LDPs0u9
	 KdJvCFBHNtJhUItU8iSMsEv/RyhgmeaU6+W4zH1g9/Xh+e7ZiJIR22eaGBn4XmnlgRRbg
	 0fjeRqXZZpsr3MlkzjJvVsNzVW2BQOuzWwy4RWhY/s68ZwPVs7DE7WYGqueazE8gLodae
	 Js9OV98hvEmEuYBwpsJTJ7itiFhWGe04v6QBDM2jGlCqlq0ok/lbm2UotXOS7H/LYxQPA
	 MxQvlQCWb7zQmU0DFybSCmn5AcYGHqe1LiXJ49a/D/+OJAV6JPqM+2PKRFZnY/Rc70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176103;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dYkSOS7lW77R25JXZ1I8J7Ye6eXp2ev/AWCnfjt0ivY=;
	b=jv/Uxa92EsODy9fQFa1Exmfrh+PgTFkGzOS7dCpi8zqEVdSxaV6lZdRsp5KwBFYrcFaP
	 WtKqKNw6HigcRgdmaxEsN63QqP142FQJ+6AsHPIx/ZvX0FsoQLpGY+NPyM0SOfMHetMxU
	 MFOvS9ApLF+wM/BJ+V1cQdUFvLFj4C6QzBC3jnTZ2Y3kWZk64mjnAgFt/dO7JgMIgWPRt
	 k6W6gUfzSfOp/jM3f3MT5+eFH2YY6l2igyShu3y4PHFzEluoUezP3pB+n2Fs82JDmp5sR
	 EgvChz9SK/M3mGMQyFenZlqKCZUnCXY5nvL3HmNCDVjFBTtqublMqo9Bt2rtIrdef2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNOAjJAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67392606A334
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNOAjJAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5D81F008A4
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 22:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794176102;
	bh=dYkSOS7lW77R25JXZ1I8J7Ye6eXp2ev/AWCnfjt0ivY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jNOAjJAUB9a5aYsLRCJIKZOrkvp62x+LRh+SAJ6hq+z/ORHz60AAku0ZqnCL1nSWS
	 7VYzKUeoA57kkrXLINYL9o0nYQMBtMkVNuYbwXLsJ8nl5EUVvu4h+36JEgt4XZgi8D
	 DpPN+rSGyV5/kKS1HNQ20LjavR22Z7q7iAGmR8mjwFXg63qqkS/PwHnn8VYLwQEGmR
	 Zv9IwO18q6fTrgAqBiRwOKHoETQizGgNe2so8WecWkjjyb0zkgFj4prkS3el8iCOeF
	 0pu7ODqxBGoUedgqMMj2SfGn4jLuibGeEQ2hLPrXmvwm+6fVLRxn15vVUulCkWFUTM
	 8otq0ntBcjynw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ea2e29d90so3976416d6.1
        for <damon@lists.linux.dev>; Sun, 08 Nov 2026 14:15:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG3KOibEX1mpTlk8uEK21X3ra2BZ8aNY7JOpON0qfvZQdqsMoyuZVs0+CsvUjt/yfyhwtzuTg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KZYDOnBHKaT339HUraUJcWKb6A00LPlzAqzgJE5EirmX0RtrJ
	+rNwYnWBqtDo5OvhIjDDnZyJcCR1y3Y7P4zEMDbSKf6VsysvFydwJ1O6IlW3uyOL9Iljf4PyhLV
	HJIAC8yi9+A1cMBZzuZnDg68Thb5mPN8=
X-Received: by 2002:a05:620a:458b:b0:945:c3b8:62f2 with SMTP id
 af79cd13be357-94604df4c5emr848358685a.34.1794176102003; Sun, 08 Nov 2026
 14:15:02 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com> <20261016-mglru-fg-v4-12-2106750c0bfa@tencent.com>
In-Reply-To: <20261016-mglru-fg-v4-12-2106750c0bfa@tencent.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 9 Nov 2026 06:14:50 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y-7R07wFJTY2a8tMQ1xvG2kjuG0Q1rLjx8DOg4u3UwZA@mail.gmail.com>
X-Gm-Features: AclHuK8HmC-Mujf1pZixYM-Y1dMwxxenrB0ml0fO-vwqyERAvkVtIlGDnC9BHUE
Message-ID: <CAGsJ_4y-7R07wFJTY2a8tMQ1xvG2kjuG0Q1rLjx8DOg4u3UwZA@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] mm/huge_memory: mark folio as accessed more
 accurately on split
To: kasong@tencent.com
Cc: linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, Zi Yan <ziy@nvidia.com>, 
	Gregory Price <gourry@gourry.net>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	David Rientjes <rientjes@google.com>, Yu Zhao <yuzhao@google.com>, 
	Vernon Yang <vernon2gm@gmail.com>, Zicheng Wang <wangzicheng@honor.com>, 
	Chen Ridong <chenridong@xiaomi.com>, Tal Zussman <tz2294@columbia.edu>, 
	Kairui Song <ryncsn@gmail.com>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> The behavior of updating the folio's access info isn't consistent for
> huge mapping splitting or ordinary unmapping. The page table's young
> flag has to be translated into folio's access info.
>
> Right now it only check and set folio's referenced flag, which isn't
> enough since folio flags update on access have its rules. Ordinary
> unmapping (zapping) calls folio_mark_accessed(), and it also checks
> if the VMA has recency to avoid false updates.

This might be a bit off-topic, but I once proposed
recency fading for the zapping case in Android workloads:

https://lore.kernel.org/linux-mm/20250514070820.51793-1-21cnbao@gmail.com/

folio_mark_accessed() might not be ideal for Android
apps that are being killed, as we expect them to be
relaunched only after a long period of time.

But for the splitting case, I guess there is no doubt
that the accessed state should be set.

>
> So first just use the right helper here to be more consistent.
>
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/huge_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd44d58e8684..1e2b6448c010 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3093,8 +3093,8 @@ static void __split_huge_pud_locked(struct vm_area_=
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
> @@ -3216,8 +3216,8 @@ static void __split_huge_pmd_locked(struct vm_area_=
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

We now have two inc_refs paths:

- folio_inc_lru_refs_walk() for mapped folios;
- folio_inc_lru_refs() for syscall accesses, or possibly
  mapped folios with the appropriate flags such as
  LRU_REF_MAPPED, LRU_REF_EXEC, LRU_REF_FORCE, etc.

The interface is:

void folio_inc_lru_refs(struct folio *folio, unsigned int flags);

Here we call folio_mark_accessed(folio), which is the
syscall path with flags =3D 0:

folio_inc_lru_refs(folio, 0);

Are we somehow applying the syscall access policy to
folios accessed through the page table?

This seems a bit strange to me, no?

>                         folio_remove_rmap_pmd(folio, page, vma);
>                         add_mm_counter(mm, mm_counter_file(folio), -HPAGE=
_PMD_NR);
>                         folio_put(folio);
>
> --
> 2.56.0

Thanks,
Barry
