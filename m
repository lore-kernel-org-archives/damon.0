Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795486047;
	b=F6hLQYvaxMctyqGgFsGCk/LNmz/N0CiJKe6I7B4atiVOrcwg66OHBPMmTQq1HLzWKplf
	 lycSwlbZEgyAayA74I/9DdugnjBX1hnQ7vU9WevUSPMvhtju7NyGsmkoaN7yh+F7R+g+B
	 JG/jIFdIe46A6CzsoZLS1om/kGqC9/mXbm6P0mPynFDQCKvgjRwOGL/AECj6xalIk2J/i
	 rqRGn/evXixIVcBz7Cl6ZKkKAia2r1aMXzHaWlrL2aCRHkOijFmuu6uYM1wpSttF89mO0
	 puKI3TUXBXkmkaG8A8OG0OdMSXr7oJ4lqtVeRRxsFSyaMMPdFVuLP7xkjh9SYIdIBCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/nOEK6bBKHw6MpZVBmQwMq5VAH7bCtPDjb3P4ihpZ+U=;
	b=t9eQTEtdVfEiColYX5Gk0EGrljpT+W0dfuoJob/y1dKhbSqCT0xvkCgdQiJurOc5pvmu
	 oEqqxl8EzJcd2Bb5E7mJaGBdVT82KWyJrZsNCQ2uZ7/PEi8IhMmR+l2irokj+i+mOpd+k
	 xQFpYFjyPlkxtoh5akm9o5iZcM2ji8x4tzQ0DWW8b8zICVZsvE5L+TxWebEDoplQ+FCsM
	 SSSGtdqP03ZCqbW+JJxC4DBoLM8qnV/A9n/quq4IvHjjm+c7EFsm5Y60nA1Hg5u5709EN
	 opCBoY7J8ujPziZSQyU+FP3LAK3RuCTen2+RA6GFdM/Ka4foz5hMZm9oSmdoaRm0zGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmYgFfX8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56C606A322
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 02:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A56C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmYgFfX8
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so30607035e9.2
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 18:07:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795486045; cv=none;
        d=google.com; s=arc-20260327;
        b=q90Om9ee50RkkLUhrpz4K5mo1+5L7OjgX4+dF+5PuVOhmWu8PdUDiGcv4tdJySKeb9
         Pc8aiyeufxYrrt+1CBL4h0kamO+cICZFzWvxcwmVA/4WK2NjwgcZt/pKM7qWneqRpxkd
         z4I56pL+lFGL7eyd1nNOzjumNPocYSX5yjh1CpKQKmebuHoeUUuAV70DbkPb7lqdrByP
         ZvArNuJwhEdEMMFH2Ath3nmkkUUZQsJ1zgHv3PUfGnU1vJ2N6ng4Ts3zJA/ht3lZr7UU
         n3Xz33g0pJawSfu6waF7h5mdpWqfHclep6fA0cs+CW6sBZ2jchQsY0s0GrnJIsgSxAOG
         +Dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nOEK6bBKHw6MpZVBmQwMq5VAH7bCtPDjb3P4ihpZ+U=;
        fh=ez5mUoYntuYykdMECMcoGGZhjRWh3Q6Ze6YmpM15Xso=;
        b=d/3zVlFVKIBldwd0bz8sNTOQFICBmRwuVV5+vCc2tWyc8V3v0r6GPOP6bo6VaDMrzy
         VXDgdOE7ZURLmcCjfo/OMPGF39JDVXYa6bcvgWScLcfpPN99tbQ6rCCEa/gZZmnixvS4
         5thME+n+8sVcY3e1aNEaXGhpjLyKkLThNdIZKMU1Bi1GME9hXQQ4SbkppyzPrPomHV7i
         ix3EH2ciEoxvlf+FvAFzbcWkciSnIQeGw8R6JBYqQe/+AsS3gHO7eLKjlUCgElHUiDYb
         JSpVD3xbBxafRrkVDsq91OHjY6Gg5IjkEluU6ngaUBiYrzVvmhUylBrzFMsFL+1emI19
         +Qlg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486045; x=1796090845; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nOEK6bBKHw6MpZVBmQwMq5VAH7bCtPDjb3P4ihpZ+U=;
        b=HmYgFfX89VH6gMzV/dDJtlMGdXoAtxY0DnJ+XaJ+Twt5IjfEWkDmoD9wqcKHJuFdpq
         kNHKu3Bp9Lv/qkvtngP6Yk/OaZrZD8r4hFKQekXvv4KtlC0D03tmbUddl/nXmbau30Xz
         /y1l+9Mw2hHYNvIMu3FpaO2XwY1vypTepd4XeDGGsYtK3zQdr+NndBUkphYxa8kVWCg7
         R+XN6s2tIiJRmUi3hibR96XHsUWMR3FBOjqnxuFyqdRh7TIYfeIOCfmtTgtwfo//G3YH
         beFXTIanTkPRNQ//iCD5TRZ4IwFRAROfKdtC1Gnwu/LbBDJzSmUO5XUNNC4mUdmDlmpW
         Kbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486045; x=1796090845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nOEK6bBKHw6MpZVBmQwMq5VAH7bCtPDjb3P4ihpZ+U=;
        b=vrq9nheH9md31bVPvmus8sPRY4V3lhlB0GSoF/1DVWueNLGJJnmYSMp0G10VFygnjd
         xWKGxoNUFDAEUxR6ZP686uUu81DTIa2ynr9/8vLeADsMbfA1yVdie7nygmu5F/zvndV7
         IHid2naUjpC7p4dlOlWxN1y9o1VCVtC1Z0Ti832I5nJZl4uEUMSuwhUTdPqyafEwG3R5
         nh20z1oDfdAWEpXNLp9us6AL/glPNbuvUIB3WX+ZMO8u8XjJFls5E/LJCCr+HbTFa8jM
         h9VN1qFk2o18rtbp6mFZMRiDaKD0ibDLHUAP0Qg9IfBEv9Dw697vDYNbrVOdy0pFr2DV
         taKQ==
X-Forwarded-Encrypted: i=1; AL+hErGbPDG1Cq7hQXVlaryBdWnZe4vxagB3RUNDHeS/CyOM1rOnmUfTbBS72FqveNjpREsBuXCyWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iiYQauxkkg3aRB5TBNAUH5kMP5d/jlyV6pTOuFxGkCVr1FJW2
	aT9LXC4u1VeW0quiJ6AelYRL6oiwSFsfAW4vLLijsX5DjPNjZ5clzaW/PN9Jff92ajxV612d1PD
	2i4UBsbnhkjIFvPeRpEChTmTUtynYOSs=
X-Gm-Gg: AZFdTZey9m8KiWnX6pMLQlBSqQVIzipf077EBBboPrnNNru08mi0526HMfR92p6bFuM
	3R/fZaDwk7HnlJpyB92qVEt0Kgol3jidnRBJTtek8RYMNESNchWqbWuKhoxbJ7oYBpckcgVF2Vj
	T56+7R5TSTc+toh0MJbcY2N47JIfiQUBW+xPwwc/NJFHq2CVGcZrpgqh3m+rUNOhvfGanmQdZSB
	LSYlKN3YOi8lPG0pPL8Tk13UwSoChB1QeKyTfH8KLlqXy0H6K8DJWXxH9nlEsVjHN1NLbDhfZDC
	vkYEf/DBLU4mZ8xlJWFk4iuKRM83+EfzARRd9UYiqZSriHuVe7naoHM//RuY5v5gjjtotOl6s4G
	+YzU2VBfN2Btvmx50maB8VvdPvVMsc9pLo+t9W7N1lHu2En6MQFEva6Xm9hjF2T6AxMdnDPTm1E
	VmGmhLbhyfCRHT9yLn5kl9eK8uoZxoPXYkLnbYJYJBghRYLsH7WK4nh9xkGlmYohHJhfSWgbCCs
	Q==
X-Received: by 2002:a05:600c:a11:b0:4bb:69f2:87f7 with SMTP id
 5b1f17b1804b1-4bb88812c92mr280620945e9.18.1795486044232; Mon, 23 Nov 2026
 18:07:24 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com> <20261124-mglru-fg-v6-3-8ffea39934a6@tencent.com>
In-Reply-To: <20261124-mglru-fg-v6-3-8ffea39934a6@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 24 Nov 2026 10:07:12 +0800
X-Gm-Features: Aa3M54oR3KlpB0bkG1vPMJxZCKqEDSLHTpf01h2UkcgR_PoelqiPBgymN4KGxg8
Message-ID: <CAN_Opa-UaAUu=dOGmDAUiaU+3-s89Y+Y2krz6zGEsNLHB3k-Wg@mail.gmail.com>
Subject: Re: [PATCH v6 03/18] mm/memcontrol: avoid potential counter leak when
 reparenting local stats
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
	Tal Zussman <tz2294@columbia.edu>, Kairui Song <ryncsn@gmail.com>, 
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:53=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> lruvec_page_state_local() clamps negative values to zero on SMP.  That
> is right for readers reporting page counts, but can be wrong for
> reparenting once MGLRU updates the counters without the lruvec lock.
>
> Reparenting runs after the forced stats flush, so a negative is a real
> balance that has to move to the parent, not be discarded. We will
> introduce lockless MGLRU promotion which may cause following problem:
>
>  1. A refs CAS on a folio on the child's lruvec moves it from
>     inactive to active, and its active/inactive counter update follows
>     as a separate step.
>
>  2. A concurrent isolation of the folio reads the folio as active,
>     debits the child's NR_ACTIVE_* by delta before CSS_DYING is visible
>     to it.
>
>  3. The child is killed, and the two __update_lru_size() calls from
>     step 1 land on the parent: NR_INACTIVE_* -delta, then NR_ACTIVE_*
>     +delta.
>
> The child is left with NR_ACTIVE_* -delta while the parent holds the
> matching +delta, and reparenting the child's raw value is what cancels
> the parent's credit.  However, if the child happens to hold few enough
> folios for that counter to be negative, lruvec_page_state_local() clamps
> the child's negative to zero, which drops the debit instead, so the
> parent keeps NR_ACTIVE_* overcounted by delta, and its active + inactive
> total overcounted as well, permanently: the child's local counters are
> gone once reparenting is done.
>
> So use a raw signed helper and reparent with that.  Ordinary readers
> still keep the clamp.
>
> Reported-by: Kunwu Chan <kunwu.chan@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/CAN_Opa-+nb0vxQ+HsENCG2fEEMZoxG9=
Sy_DBC4CLkWjNLzDWKw@mail.gmail.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memcontrol.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 091401cecf39..3f551e2e3206 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -562,11 +562,10 @@ unsigned long lruvec_page_state_monotonic(const str=
uct lruvec *lruvec,
>         return (unsigned long)READ_ONCE(pn->lruvec_stats->state[i]);
>  }
>
> -unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
> +static long __lruvec_page_state_local(const struct lruvec *lruvec,
>                                       enum node_stat_item idx)
>  {
>         const struct mem_cgroup_per_node *pn;
> -       long x;
>         int i;
>
>         if (mem_cgroup_disabled())
> @@ -577,7 +576,14 @@ unsigned long lruvec_page_state_local(const struct l=
ruvec *lruvec,
>                 return 0;
>
>         pn =3D container_of_const(lruvec, struct mem_cgroup_per_node, lru=
vec);
> -       x =3D READ_ONCE(pn->lruvec_stats->state_local[i]);
> +       return READ_ONCE(pn->lruvec_stats->state_local[i]);
> +}
> +
> +unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
> +                                     enum node_stat_item idx)
> +{
> +       long x =3D __lruvec_page_state_local(lruvec, idx);
> +
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -595,7 +601,8 @@ void reparent_memcg_lruvec_state_local(struct mem_cgr=
oup *memcg,
>
>         for_each_node(nid) {
>                 struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, NODE_D=
ATA(nid));
> -               unsigned long value =3D lruvec_page_state_local(lruvec, i=
dx);
> +               /* Reparent the raw value: the clamp drops the child's de=
bit. */
> +               long value =3D __lruvec_page_state_local(lruvec, idx);
>
>                 __mod_memcg_lruvec_state(memcg, nid, idx, -value);
>                 __mod_memcg_lruvec_state(parent, nid, idx, value);
>
> --
> 2.56.1
>
>

Thanks for following up, Kairui. Reparenting the raw signed count
fixes the case I had in mind. I also checked the clear_refs and
workingset changes in v6. Both look good to me.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
