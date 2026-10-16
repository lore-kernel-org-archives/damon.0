Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A641D647
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137297; cv=pass; b=gajL0oP8UacZEiToD8qs0ra30prAiqmT6uaafq+StFFaEGiI6uvRlEa3pmUVCC5CjBl6vTCnbtUsnVkzhdislObTzjywzAr8aaZ5dYl6C6GSeYwIr8dNL+h9vzsSWz+TOPv1B5zE0roWryAAav5HoaoVzQm0Kjn0G6iB2l+0gQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137297; c=relaxed/simple;
	bh=Asd1LyXfmZ/wMvQJmtWaI8YOR4sVcoYcjj3fIBEE5QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbHWpPFVVIlZ9umZJnnX2leXFvkN3eAt4iyi61HFonruEPRC0uJsv7VpgmaNzcPLzRPQQJro7hN/oedmy6c2ydRzWZ8RvKDNqmMtIOve+yOV3laUuD7d9L+6g+UsRFceuKgO+R5YbA3STIncBEGVZW2A0ow9c1rh3+RhT+3iQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hps6FuMh; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hps6FuMh"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40e9aff12fso22924566b.3
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 00:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792137293; cv=none;
        d=google.com; s=arc-20260327;
        b=W2wz+DTEFrYzB+/94GKHE276iECZRrYLgOmmXKyVhb6BoNCSrvmvaXNVHG5sBZMdIJ
         6U1vjfD9idwLjNxGKW/bpHinVKDCwiC6FdfIDaLg9IWscK/+88K/x+xFp8bsvNePkjF6
         nvqBG5ai+1+T9ijqqwtuePWAIpA3ZH3nnRpKDFwAvvzyHR0iofdfJvrA6lHBzyqNaGJj
         TxQDx7W28u7y87MKr27Zdd54OqIPU1ngQEBPVAGzB+skNM6xaHNfUJnqPJs6xHYG/eKH
         JEIf29ZiQ2ft2ptffYus27zuC52Nsxo9ylikOSK4UOUiVsHc8vp2WuId8MhIY9DHY8Fq
         wX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTydiIf1dz0lwLgVUeftG7/xPlIHpWwfPGV7qf09584=;
        fh=YkFzgh1vmXDK/tmPOh5B83qsiU6ALWya40qyiEazY2g=;
        b=rNfsoupK6Qp0sjcTsFcLmNvjC7C13+GqEcmcCYoIcw8ZzHuI0axi2q5eh2wsOYrZ17
         P9B+JiRUTJ/JGf5DXzrWUwKwq7JQR5XmOOJwfmjijQVrqKrOdXGqGixosKoNWzbazwmF
         oDTeiYvLvUDRllS3W8WIks1q7YJudmn01GIEQS+WRRfBUziFjnBego9PTk+3oB0EIx6N
         4zaqbMdNDB6EYpNYJ9FbnqYF7y/tS8fF/JptE0ceOxQXKHo7lQTHbqaK4X3zTwvmGHff
         t9KdOnPqWEUO6VK46/ZCDMh4dAGTIOwwS3bRQxuchyiOdM/xlxhNfXj7t1WF5Ei9EN8p
         0gpw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792137293; x=1792742093; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sTydiIf1dz0lwLgVUeftG7/xPlIHpWwfPGV7qf09584=;
        b=hps6FuMhN+rJ6zqHjpj7ddwJ473a13EdVFGva7eGxZKXrg3IsEuMgCSFwbZ73RvToR
         rpLEYTlTjSeuKtAhY3+IYJajG/rkGWcxK/xhcUnz8cINp2GKo4xpnZCwCkvSzMNYLb/e
         ZYMkclP0Pp7CK0HscOvFQsEhlgMTsv1k5x85xBueOWvrs5nT++kGz52e36JNURWHGHMe
         fD5qDSrptAHjSX6uaCCmiNyfE8MTZABBsKOvgW4+O/e4LaCs+K577ia0BOYci1ZbvdYB
         Sb6tkUL44vKg+Gw2HoIJhCmVNOM0dBCCSbNzb46NV2fZs4xMeeotsTbfYUHq0IZBm/kE
         yY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137293; x=1792742093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTydiIf1dz0lwLgVUeftG7/xPlIHpWwfPGV7qf09584=;
        b=kRK7niG7NYoaBEtYd7H6MhG4MuQE8IHaYLhA4y35ZkwUTlAqcV4OlEJvIYebgGOtlQ
         JxTriYb5q/oR6cPpwk5k6j64Psm2Kk9DA5kDC3/xqfcZBuZKRFDteIq2OKtr1N4VbW9L
         LL0b7ieUyDgqvt7ioZducS2IYWgQ8iM3w2UQPxSrUimILB69eslKYoiURDYO06bxNvJW
         XY33Hghq8DouLxrD6pRzGC9RwdRfd1KVrklf6Ie267tDIKMMCMXd6sPB8JUd0SN3vY3u
         zUqWnrpTTXWYjDxY+c8pWl3KJcH+FiUP1wMJvuor6tVdS/LYGTuuZ5yX6eRz6WccT4tW
         hCAw==
X-Forwarded-Encrypted: i=1; AKwUvBy17Ysyz0JxSZwXM0xvQQx7BsrLTzaiTGrq6r9stQCBiZUd064rg2tI1htSsYVRgWqqF2d5Xw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI9g2QxngzB0Augj+MjcCecv+7TfuAT2OuntAZPwH/hHE3iznv1
	AyE54//5+ghZchzVLT39PQdbpxSWGOQoLldZD9u0vi2PqmY8UtkTYDHfmLPNR/l+7QenLTpkSII
	dnQir8DQZd3w7nIPhdptgQnD5EBCiOYw=
X-Gm-Gg: AYBFou3m1RqcZs01paGvlUcKclv5vU4gMDW6WoI9aAYviKeqlplpKBcS2iNkhXDciZ8
	HGmqR65EaoR8Zvoqm6Qq0CB2uyBKaZ2JPFAxpcV6Fj+hUw6Y34GCpr/SmpC6EKEr+ixAEBLGp5d
	UIzsTim6ZiqDJ5/r6sSNHTnG+Lm9VN3wfPsaoiuI+CvstLVVneGd8QgIFYPraNIJvlCMAnEzMtl
	9kLxieFv8wgag2e21pzMcK4F6JI9LuCL4+VHF+wHQo3zvgShWrOsLVs15m+L56rnu9O3bAqRX4M
	bgEKNR786HSPjV0iwCZfbqXdhWlNAWW1M5kxpr0QD17CJvtC2yNa4IriWqMtWgxU8M+4fDGYS3x
	Wsga5DGE84Ok1dMNuW2TU74cfA0838ifie8rsypnY+SjqkN2Gd3skvlcp7TFxPDCD53DP1g==
X-Received: by 2002:a17:907:7213:b0:c31:6bd8:b13e with SMTP id
 a640c23a62f3a-c31a9fd33d1mr1854131766b.11.1792137292409; Fri, 16 Oct 2026
 00:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-3-2106750c0bfa@tencent.com> <342E57E7-9B7F-4193-805E-D1EBB41299FF@linux.dev>
In-Reply-To: <342E57E7-9B7F-4193-805E-D1EBB41299FF@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Oct 2026 15:54:16 +0800
X-Gm-Features: AclHuK8lfaJLkt55oh9aygbGuPc6XqqQ5L-gpY7DcUfl3-ol56sFY5yxSCzcN1I
Message-ID: <CAMgjq7D-2HyvuD5U58ohv4YuyuCEbxYAO_wxkx==WxhsNQrXXw@mail.gmail.com>
Subject: Re: [PATCH v4 03/17] mm/memcg: add folio-based lruvec live helper
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, SJ Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:39=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
> > On Oct 16, 2026, at 02:15, Kairui Song via B4 Relay <devnull+kasong.ten=
cent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Add a helper that resolves a stable lruvec for a folio under RCU
> > without taking the lruvec lock.  It takes a folio directly so the
> > lruvec lookup happens inside the RCU read-side critical section,
> > which a lruvec-based interface cannot guarantee.
> >
> > No functional change.
> >
> > Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> > include/linux/memcontrol.h | 39 +++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 39 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 74110a324f9e..829ab776ab44 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1535,6 +1535,45 @@ static inline void lruvec_lock_irq(struct lruvec=
 *lruvec)
> > spin_lock_irq(&lruvec->lru_lock);
> > }
> >
> > +/**
> > + * folio_lruvec_live_get - get a live lruvec for a folio under RCU
> > + * @folio: the folio
> > + *
> > + * Computes @folio's lruvec and walks up to the nearest live ancestor
> > + * if the folio's memcg is dying.  Paired with folio_lruvec_live_put()=
.
> > + * The result may be stale: RCU keeps it alive but does not pin @folio
> > + * to it.  That is fine as the counters are fixed up on reparenting.
> > + *
> > + * Return: the live lruvec, with rcu_read_lock held.
> > + */
> > +static inline struct lruvec *folio_lruvec_live_get(struct folio *folio=
)
> > +{
> > +#ifdef CONFIG_MEMCG
> > +     struct lruvec *lruvec;
> > +     struct pglist_data *pgdat;
> > +     struct mem_cgroup *memcg;
> > +
> > +     rcu_read_lock();
> > +     lruvec =3D folio_lruvec(folio);
> > +     pgdat =3D lruvec_pgdat(lruvec);
> > +     memcg =3D lruvec_memcg(lruvec);
> > +     while (unlikely(memcg && css_is_dying(&memcg->css))) {
> > +             memcg =3D parent_mem_cgroup(memcg);
> > +             lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> > +     }
> > +     return lruvec;
>
> Hi Kairui,
>

Hi Muchun, thanks for the review.

> Actually, we don't have any means to guarantee that the memcg
> to which the returned lruvec belongs will not become dying
> after the return, right?

Yeah but Qi once mentioned that RCU prevents reparenting, right? Even
if the memcg is dead after return, things happended to it
(non-hieratical counter reparenting, ones in __lru_gen_reparent_memcg)
will only occurs after RCU unlock so we can apply counter update to it
without grabbing an ref, just hold the RCU.

> > +#else
> > +     return folio_lruvec(folio);
>
> Then, I'm wondering why folio_lruvec() doesn't apply to the
> memcg scenario.
>
> Internally, folio_lruvec() obtains the memcg through
> obj_cgroup_memcg(). So when the memcg becomes dying, it should
> be reparented to the parent memcg within a short time.

I wasn't sure if grabbing RCU can ensure an already dead cgroup has
not been reparented yet. If we apply the counter update to a already
reparented lruvec, then the counter is leaked. This new helper is just
a folio version of lruvec_live_lock_irq.

I got the idea from commit de4660898b7a, which says:

"""
.... check CSS_DYING under RCU before
flushing the pending batch.  A non-dying memcg keeps the original lruvec
stable against RCU-delayed offlining; a dying memcg redirects the deltas
to the first non-dying ancestor.
"""

Applying counter update to a dead but not reparented lruvec is fine though.
