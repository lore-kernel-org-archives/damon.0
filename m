Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216810;
	b=KKXcrGqv9yxF2jMt3lfD1r0EWtkdiY+4Z6qrAVfq3+l4DZgXUmJCgr+kju1KtA79ICj7
	 XIt56HI8WEmBTPJaIIO9rVaKM/TFfVyTqoHZE0I08+LXZoHvvWNYzb2o73u3NlYEPIgoN
	 r3fpSiBy0O97XGz7MUyjqhYqMCb71FZkOfrG5tBU/p/Wwqb+lkXwVpSFyZtOABO30rQlW
	 gCXo5JkBnptue1oiTF74wHEpVw/cdbjfVZCojLeoeRT3kvHGox94WEUAHMLhbdM4bpj37
	 kh8R+tmzFx6IJbI5n4NkNBzHFYrG7VZfsyf8IZcXhOW8JvL4wKJixif88bFUiMHQd0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HqOJkLXd0wmKotueuMhbylT2sufy9bI1CVmczzNeuOY=;
	b=Yl9+E3cqshpGpS6zwJSXY2qCrLC7h0khhgvzbRYoUBenebnhXnO1XccPfLhTS1478hNN
	 tPg710vDQydc3wna6swlryHwXCJ2IJiBWMTa2lGSUeDiCh8d34uyRlVF/Mxk/xN3r02xe
	 zpmrLNE4INwImQSehXL3fnMH1T0d0XTlmXks8GQmkZpnmnMq0ZlDOCSIsJZCJ6Mf1iItK
	 W6otUA2UDL63dczj98LvzRx1W0VIBDTQfyq6lbEWk6+48YR6zYaKzekEwtl0zmJ5748d9
	 9tcFdQtj75FAjZpAp0cUWssBWTGBDWwuXAnu5R0vFrbkgpL8fPEdQiQmb1Vix4xUl5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="nLqQo7/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878E606A322
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 09:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7878E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nLqQo7/x
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso90366666b.3
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 01:33:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794216808; cv=none;
        d=google.com; s=arc-20260327;
        b=AUttnB+UMhAYD3waXMpi6ae8C7A1dDj8eIosiRysHNPTTbUbl0A542ul7/htmrJBVL
         hYfmolYGIYs8h9jTSAgQaYCQ2IBVaji727T7uhZE7t4MKeVXeyHBaqSdi6GXughL18z3
         H1VFsGSSb9pkXeFc7s0LD4+pdSNiJV+IO18uao9eJXKqLWO4QRg9i0J4GYet3s97IyHb
         cDW6s3+W3mFoGR7ywasQnjiTEfO4JDGnhyZSUdxZQVxoV2CUW9DIllnLGHTytHWkgilW
         zlY8s3aC/pMGM/md35BVgkVqM2ErDIZjUQYpoj6hCOQ4c5bT7BxWqPn8fuJGIui9dcnp
         WkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HqOJkLXd0wmKotueuMhbylT2sufy9bI1CVmczzNeuOY=;
        fh=qKSJUJej31H8ulSUH6K6MlQJBw/bViGhs9fZ9aCLnlY=;
        b=pTyCjY72LBeJfoIO0ER9SFqMI4WMsUMWxWNt/Ac8lrmJ+7HhpIvGK+YozGV2tK0Jza
         hLA8u8dqF17dVghp7HrNLXLYEiM/rdSDHRr1NTwd+z6pdx7WdNlaVgsia09Xu0CUxJ9F
         AbmiyZDtkll1WLBGRDVJEEFtG/rQMCcAZeQ3qCrjbnmBjLriLwLsE1yo9iaoAfSlwHfB
         qOg1STpb2DOLIwwpc1kc7aNPgDzI7EP32FdnO8VBEOX+E3DWMSLPkKyFb5z6Bgri3xeY
         bAm7A3yj5UKsgYKdR30p3acdeRdRZZOSInZD99x9lxtFG0lXyBhs98WCzLagvTIRqGo1
         PeXQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794216808; x=1794821608; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqOJkLXd0wmKotueuMhbylT2sufy9bI1CVmczzNeuOY=;
        b=nLqQo7/xB1x0tJOVZuQ6QPK79ZKy4efcM6djDKk/BhdQrgtWIBFxFuYBdeWlxr2e5R
         g2PZN/4kqwGgae8bqaW/Fhg3PsvLvjKYMuY/fpQ/XdCaKCNOGSlhofZ1c6pSfEhKMF+E
         JNmRieWYQOVFiG+efxCWa8gGi2leCSFA1SmB+jVR5o85NqB6wyM2wKnSgsr2A5K3t1Aq
         Ig3bC8zBl+Q5JDj35OwhGb02bkwhezOyNFEl934AqCXzQnYtb5EvmaYxBFae0pgumVWc
         knDKTE8c6RU542mHlgbeOUNP6yaDgP+IispVYIcOkmqR+km8OXUkAyoeaghnbWWCulD8
         SdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794216808; x=1794821608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqOJkLXd0wmKotueuMhbylT2sufy9bI1CVmczzNeuOY=;
        b=NmS4yvSfer6H6M8tTqJfWJEyNz0N3+F3P6ukSxaDBGH24uZeSMTTkGjSAi2NPtDV4q
         TZ7mOhRAmcHUxMntSLQbmKpiFGMJLN+v9LvONkQ2aVpMkuvpNOaVSpEegdWE1bnoMFGO
         3X/NF7YWXXcgpE9B5oY2XPNK+EZ7JjN+FJUo7WjjvHAPt4BMFTPRHIjBMm4rxVOHC7pX
         WNHMCHih/8eHq910zNC/At2GUXw4KWewA4IvWm2mXuPQmcgZuLHePfqFx9mYo0TrD83b
         AGgosmY94bIKkRvqqAiqz9TPUsalkDpEDYEqTvlNd8N4P1kMD/3k5jZO1KASS1PHXJl3
         YDEQ==
X-Forwarded-Encrypted: i=1; AL+hErFQsk27ZZ2EyWxrMwRCVL2NKsqm4IsALkWY6v3L8Fg+VT2ZJ1ubn6Ogqya1BuKSMYT7I50BJA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/ipD7CK7lPZ7BRNc2zRdn5D7x09XYm114Fsm+qdYGMqPrc5BD
	QqxX4aNDjy057/Bnc6C3hwdpoZ6a355QyTeCy+qzUfQCLjhXewwoPyxJkbW2pP0MJ4foSLjDyhE
	iR5zYlQBt//LYVyZW0yiLx0tfGGsLteM=
X-Gm-Gg: AYBFou0FIX0wAvxA8EDLaDuxMJM9/2Ep2AI9KE+67nQBR9N9adkG7+iU5Msqq2jvkEw
	3DJU2zp8/MtETf+aZm0LsckUinjhhW4xvBv7o+RF+fTA+/gl7LT7PKLZ2qoiizwwasYjLAZcVfx
	oN2cmLdKAsLm+UyJ1l/twGLob9vSxXICmHu9IGXKoTkPZf2yyr5iabgKlp412PiiQOS8wgyA8yO
	zyfcKMHNA65r1as6Y4ENqAemGsx1QtwOhtcb05QZ9PAX3X45YiJbNsKQgUR8f45SAD2OUpbBvFg
	w0QfjyzIe/4O593R5yzyOIWyXFob2CBNOSzPmKfhPu8aDa2wIBvXdqG8wbJ1nkyS8T27eptGMtJ
	58GhUznUmD2SuBrv1XUgG9mTIzzzgmfKSwQdFblBtoCLzPB1ez2X4USj//1xbYD1Jy7Qa
X-Received: by 2002:a17:907:2d94:b0:c40:3a99:3f96 with SMTP id
 a640c23a62f3a-c4d6d35c245mr238537266b.10.1794216807560; Mon, 09 Nov 2026
 01:33:27 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-7-2106750c0bfa@tencent.com> <CAGsJ_4wSDOgCC9AmLS-z670W-nkF3DXB_cNvNFnptX5F95fGMA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wSDOgCC9AmLS-z670W-nkF3DXB_cNvNFnptX5F95fGMA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 9 Nov 2026 17:32:51 +0800
X-Gm-Features: AclHuK-CEIJ-OmAap_Q_FmrC7aIH9q-wRCoxV2MMC7FO6jMxD0d_umEF-d1s_Ho
Message-ID: <CAMgjq7Dw6QtM_VgTuReNs5duPeAZbRukVFZkGuDgbQOXLm7Mjg@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] mm/mglru, gup: mark folios referenced via a fast helper
To: Barry Song <baohua@kernel.org>
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	zhaozhengzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 5:04=E2=80=AFAM Barry Song <baohua@kernel.org> wrote=
:
>
> On Fri, Oct 16, 2026 at 2:15=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> > LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> > classical LRU as before. No counter update, promotion, and guarteens
> > no other complex operations in following commits.
> >
> > Convert the gup fast-path sites. No behavior change for classical LRU.
> >
> > Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/mm_inline.h | 25 +++++++++++++++++++++++++
> >  mm/gup.c                  |  6 +++---
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 65415eeac802..effa13c63632 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -454,6 +454,31 @@ static inline bool lru_gen_del_folio(struct lruvec=
 *lruvec, struct folio *folio,
> >  }
> >  #endif /* CONFIG_LRU_GEN */
> >
> > +/**
> > + * folio_inc_lru_refs_fast - Bump folio refs count without promotion.
> > + * @folio: the folio
> > + *
> > + * Raise refs from 0 to LRU_REFS_REFERENCED and leave hotter folios
> > + * untouched. For the classical LRU, a plain PG_referenced set.
> > + */
> > +static __always_inline void folio_inc_lru_refs_fast(struct folio *foli=
o)
> > +{
> > +       unsigned long new_flags, old_flags;
> > +
> > +       if (!lru_gen_enabled()) {
> > +               folio_set_referenced(folio);
> > +               return;
> > +       }
> > +
> > +       old_flags =3D READ_ONCE(*folio_flags(folio, 0));
> > +       do {
> > +               if (lru_get_refs_flags(old_flags))
> > +                       break;
> > +               new_flags =3D old_flags;
> > +               lru_set_refs_flags(&new_flags, LRU_REFS_REFERENCED);
> > +       } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_fl=
ags));
> > +}
>
> What is the actual purpose of this patch? Is it to skip
> cmpxchg() when the folio already has non-zero refs for
> better performance?

Right, as the name suggests, it's a faster helper, sacrificing some
recency accuracy (limited to LRU_REFS_REFERENCED, so it never touch
any counter). But the low bar for this helper is still equal to
mainline so I think it's fine at this point. I can add more commit
message or comment on this.
