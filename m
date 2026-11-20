Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157568;
	b=W3u0BP+VpJje/gBQW9AHjiL/mEROjbnxO/qx3+9rRYt7Xg3hKlVyK0KCYHazucJb1oiD
	 t7bhg/HQnnweetZyuOSQu8U5VlBW4XS5ymRiD7T+1aEWB35e6/0Jepk7y1NRmCvehgXPE
	 3iAG6aPOmUfM2phX5ChryFkL10YWqJMVG9H7rAP8OtPsIkX0/3RqrHCjEynqXgGJ2nGvj
	 uadqVxTIDxhcI05fwlun7O1fDzSHQ4C6QD59U/e/EvT5dEAXmymk2LkuU6EF+l3Hwtuo+
	 t/iVIw1rwuHVGZ3Xe1N3wc5xma/gFQciAwWpUXlA8YupdlpUejVi5kPhyvCqVoXLTmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F2X1sxbD16pOIjQDxmX5fcIE93gciH00EyIBtJDwIOc=;
	b=NgRz+Vc3dJ/ECPFcZFv9n91ugJN6e8l4q5s6mlAfqG1+N71/TEYqfsGR6NddKKdyEkQ3
	 5jDlomgZ59scmvwWH2hFArMM+6SjmXOTsAyYmeMSzBngqKLE4LUTiMpRDtptW28/7FDQI
	 Bk41PDSd2yFiGciTDByJs7FWJcKBUuFu2S5kixUEIl/WNISOuzabtuQ8VRUPSijRYKa+c
	 1g8NucalzZfhgtany32kx5LIH2xYhBMi0Z6z5YWov97kI1MyUZaonugvhLfSH0jW83vhv
	 ZeFO2v78jRX/T4Vz2gR+RlL3291a/lIk5rW8YuHf7561U9eG/yIf1/74rxCtJf9b90A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vNEaMlCB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795C606A326
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5795C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vNEaMlCB
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb606491faso2368775e9.3
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 22:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157566; cv=none;
        d=google.com; s=arc-20260327;
        b=IZKRobz3FuAe4Y97TNnMv0xq4I7eksb0p5UJHYyNaEMN6AReWPOliuwimhyZSamTPc
         AR1xcWPGekNABRtzIYKVOFphE0myp8eh03kNzXQ41Cq9Bae70rkp69NvVwxuw/ppELSl
         qvQ6llb6Qxw7/sGSuHXf5Rhfw9B81XUz4JDgbiUBs2Pg6xL2p7er15ws/h/84MoLGaOX
         nsFx+kS+8mbAIRBju+O/8ujmMPq0sfzWBmZlDuWgyBndioxXZlrOPcmg98PeAxUAEgWq
         jiP4TKTBzUCnDa+JzA1yqgeZW5dDc6W1/S7lyR8QUEW7oynroX7aLl8LV5AOxZMOnf+8
         oXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2X1sxbD16pOIjQDxmX5fcIE93gciH00EyIBtJDwIOc=;
        fh=LS0m34PW097SivKhkhZySUkyIaTsNjy1ARIgMlbPrcM=;
        b=T79XcSSNrDLfvraiJtMx7xm75aF3qgCbLveiVN3QaI/X/pDGP32+ZRz8OCV2wkG9Jb
         gboa1lVwyCZByo+5Bsh/iek82i1L+Zo4fJ8twg2md9oDhcNzDCcwIV8YYfUATtAXDm69
         MmC0g4ps1WqMpKHHMG8hNdCNtF7txjdxlGU/dYoaSijaDfdlo9UCgioA4PEmM+VKdfPJ
         tI+g+2UWvJ8Qhs2Pfr0CfQZnJNiUuxvYwy4+vp9Zh4rIa+jSU/Gh7dIVTWlKSu9yHNpy
         pKZ2+2uP1y5oP27mUpRcaxcsfhDYBvHWn2MMbruapDpAhx8GVDs0u3mYtP+kk960fjdA
         VlUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157566; x=1795762366; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F2X1sxbD16pOIjQDxmX5fcIE93gciH00EyIBtJDwIOc=;
        b=vNEaMlCBA46y9BifO52XgpN4YRX2ID+A1blj/Lt+Z52jcz08ohrCt8oawuy8Is/pp4
         y/BR77YnSwsz24M1Puh3/WXp3hI/2GwQ/5S8GzVdvcpqypfHmBenMu/2Twnrcp5s+r+P
         VOsp1CwuF0nyARX1EMNR0pfUNiFRLtKT48nkdFPBEoJaLZWreGk04z+4cjF80+FgGvgZ
         w7dmQomhl9yuBKEqMOM3HSgYQHfPZZrTmxP2aPEIC2stpUkIxcXRA0QBRSzbebA3zlqi
         keaBtR/3tM/em1lo1yguPypOeJbAuL/xnM3A7nEYkiSLTm3yYYuNB/A3zE7gykSrJ79g
         uBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157566; x=1795762366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2X1sxbD16pOIjQDxmX5fcIE93gciH00EyIBtJDwIOc=;
        b=Iygk7CH1CYRuOs/dlTH+3tE+HbYxxe951VB/3KhvJsKv5DDg9neecHcOiAk5eqwkAL
         M5oMY2Rb4Z38LOTgLy2mHrkYKxavoctweQoHHWuwq2T4fA3nrV7byzG8wa3rOxMkQGAn
         X85XhFj0I1oWuKqPgLK8Vqy900gqVH2gULNCv71SI1DIgzPcvP4zpj0AQB8dw06wp5/R
         0cyJA6Ii/6lePGpILGTGYi/ojOUHuwU3121O09PdND7edFiWyWiitv8k+O0byonYXRIS
         Iz/t+F4uhEC09Cgryhq/bVDeSlxgP/nsBx1KQiq808se5ddQICPCSSWLvQ5KZxqi/mOY
         54LA==
X-Forwarded-Encrypted: i=1; AL+hErGwrZJShIycsfQ1L8K9iYwVnCvZIvbYgzpGkggZnP9JTkLTMbf6sMbtUfjFlgn8M7qHk5qXRQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/R/bJO+SGtkDevKQvP7ds2waRKgfXGOn1jUWDfM3+3uBmKLd03
	1HFX5oh5qU7bKLdNYdC5aN40t+BQ+Ybd47EDbdjMGYiAOHnGTiF2SltqMVz0kwzX5sO/0ybNxM6
	4jUoFBQru8HIhwe/I9YooUNY2XTmjQLE=
X-Gm-Gg: AYBFou1dW0DrPbuKma5PhQfvdWSTXplJZvFQsX5lSCBU7xlPSVubaaMxqHyhvByvbxi
	wI3HSjXyv2uJ/KIiiFtvFrUVH+43m7R2RL1fID0F+0X/OymyPDKB3ubXCEusqOfv266h6x8bc4L
	+FC8Abw5W92RTk9/4LijL8jIIFY1RJxGovaLT/sPgMlf/P/iHEc/Na7imCMBKyu6hTq96rWk2DO
	wu5kDItvTR3lPrHY9IjAQ0Kb7SWx5JP2wqR6AUMGbPqGPqvjpsnoBQPrF/dwBQ+gnlCubZNrSLU
	YAYZxaiEqo0jNB2qen9qvPFVGybIs8JUGa0y22locm6tZZCeEghmAODWtBmVaNuOf1xAPOUCcUr
	Zh8fqDbz9cjRheiC/FqeHgS/cPezxo/9CDjAFkl3K2BZGKv+h/b2Ti8XGUZDaOmBq8A==
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4bb8880f0e0mr43956385e9.5.1795157565119; Thu, 19 Nov 2026
 22:52:45 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-4-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-4-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 14:52:32 +0800
X-Gm-Features: AclHuK8u9ADIpuCbwIFublehlsAz2Sh82b8gcTYOiMH_psNdYRsQZkiWsXcTuLk
Message-ID: <CAN_Opa_h083WMGuehgFLYb=Rc+Kd3t3JdPiG2xkEw_+digwQyw@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] mm/memcg: add folio-based lruvec live helper
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
> Add a helper that resolves a live lruvec for a folio under RCU
> without taking the lruvec lock.  It takes a folio directly so the
> lruvec lookup happens inside the RCU read-side critical section,
> which a lruvec-based interface cannot guarantee.  The first user is
> the lockless folio_inc_lru_refs() path later in the series.
>
> Factor the ancestor walk out of lruvec_live_lock_irq() into
> __lruvec_get_live(), so that both entry points share it, and spell
> out why the walk is enough while only the RCU read lock is held:
> reparenting of a memcg that starts dying waits for a grace period,
> so it cannot race with the caller until the lock is released.
>
> Move memcg_is_dying() up in memcontrol.h, next to the other memcg state
> predicates, and use it for the walk rather than repeating the open coded
> css_is_dying() test a few definitions away from where it is explained.
>
> No functional change for existing callers.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/memcontrol.h | 71 ++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 980358bc6f49..441a5d57e723 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -571,6 +571,11 @@ static inline bool mem_cgroup_disabled(void)
>         return !cgroup_subsys_enabled(memory_cgrp_subsys);
>  }
>
> +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> +{
> +       return memcg ? css_is_dying(&memcg->css) : false;
> +}
> +
>  static inline void mem_cgroup_protection(const struct mem_cgroup *root,
>                                          const struct mem_cgroup *memcg,
>                                          unsigned long *min,
> @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_online(struct mem_cg=
roup *memcg)
>         return true;
>  }
>
> +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> +{
> +       return false;
> +}
> +
>  static inline
>  unsigned long mem_cgroup_get_zone_lru_size(const struct lruvec *lruvec,
>                 enum lru_list lru, int zone_idx)
> @@ -1510,28 +1520,41 @@ static inline void lruvec_lock_irq(struct lruvec =
*lruvec)
>         spin_lock_irq(&lruvec->lru_lock);
>  }
>
> -static inline struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
> +/*
> + * Reparenting moves a dying memcg's LRU state to its parent at any time=
,
> + * so anything added to that LRU afterwards would be lost.  This helper
> + * walks up to the nearest live ancestor while the caller must hold the
> + * RCU read lock: reparenting of a memcg that starts dying waits for a
> + * grace period, so it cannot race with the caller until the lock is
> + * released.
> + */
> +static inline struct lruvec *__lruvec_get_live(struct lruvec *lruvec)
>  {
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>
> -       rcu_read_lock();
> -
>         /*
>          * The memcg can be NULL when the memory controller is disabled.
>          * Otherwise, the caller keeps the memcg owning @lruvec alive.
>          */
> -       while (unlikely(memcg && css_is_dying(&memcg->css))) {
> +       while (unlikely(memcg_is_dying(memcg))) {
>                 memcg =3D parent_mem_cgroup(memcg);
>                 lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>         }
> +#endif
> +       return lruvec;
> +}
>
> +static inline struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
> +{
> +#ifdef CONFIG_MEMCG
> +       rcu_read_lock();
> +       lruvec =3D __lruvec_get_live(lruvec);
>         spin_lock_irq(&lruvec->lru_lock);
>  #else
>         lruvec_lock_irq(lruvec);
>  #endif
> -
>         return lruvec;
>  }
>
> @@ -1561,6 +1584,34 @@ static inline bool folio_matches_lruvec(const stru=
ct folio *folio,
>                lruvec_memcg(lruvec) =3D=3D folio_memcg(folio);
>  }
>
> +/**
> + * folio_lruvec_live_get - get a live lruvec for a folio under RCU
> + * @folio: the folio
> + *
> + * Same as folio_lruvec(), except that a folio whose memcg is dying is
> + * accounted to the nearest live ancestor, which is where reparenting
> + * would put it anyway.
> + *
> + * Return: the live lruvec, with rcu_read_lock() held.  Pair it with
> + * folio_lruvec_live_put().
> + */
> +static inline struct lruvec *folio_lruvec_live_get(struct folio *folio)
> +{
> +#ifdef CONFIG_MEMCG
> +       rcu_read_lock();
> +       return __lruvec_get_live(folio_lruvec(folio));
> +#else
> +       return folio_lruvec(folio);
> +#endif
> +}
> +
> +static inline void folio_lruvec_live_put(struct lruvec *lruvec)
> +{
> +#ifdef CONFIG_MEMCG
> +       rcu_read_unlock();
> +#endif
> +}
> +
>  /* Don't lock again iff page's lruvec locked */
>  static inline struct lruvec *folio_lruvec_relock_irq(const struct folio =
*folio,
>                 struct lruvec *locked_lruvec)
> @@ -1826,11 +1877,6 @@ void mem_cgroup_node_filter_allowed(struct mem_cgr=
oup *memcg, nodemask_t *mask);
>
>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
>
> -static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> -{
> -       return memcg ? css_is_dying(&memcg->css) : false;
> -}
> -
>  #else
>  static inline bool mem_cgroup_kmem_disabled(void)
>  {
> @@ -1901,11 +1947,6 @@ static inline void mem_cgroup_node_filter_allowed(=
struct mem_cgroup *memcg,
>  static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *m=
emcg)
>  {
>  }
> -
> -static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> -{
> -       return false;
> -}
>  #endif /* CONFIG_MEMCG */
>
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_LRU_GEN)
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
