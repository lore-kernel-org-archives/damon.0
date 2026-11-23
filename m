Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795397438;
	b=WYvJHCmYg2fHtcGCTJfuAI2A1jdPtKooS3A7W4fy1wG6eqvQY0JXAVKBiEd+vD3U7Z3s
	 IQtglrCh7qilMn36dc0Ih/28HEIhUcgEZUFgk3O86lw3OxSjpfRJfXBSklAOC7jYhaIqn
	 Kg74YjJ3+fbdDSV/YbYGm86KkD7HTmEjYsMrXYw5CDlrwRZrA0mdIEf7rOIdVzV2xhqmU
	 m035xIfClU+TMYSA3t4ShlFJfCqZMVLi+gd13+crIvJSvLUiU6wCsHMxpQ+oOBArexAIF
	 Heb1NIigUXipsTEbas5vxgPBqGyEwjSnNjTnpfx166drjjVQrSo8ucnSeSqPFeDuflw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PHYlamw7fybYjzeLc3iuK4CS+fPI6wiuuTA9v+wgAMM=;
	b=CkI4PjOEZANUxGly9cdGb2xYXG/b+5qH8nGfOpq1yInu0Gx0FFa5frses1nET3o0uQnN
	 v4AZYA+puBmnaarWtpGcbxeaLucHjTdo/u8ZnjYCMt32zVPbRHu4OD/HS3709vfuruT+s
	 OWKlg5/FWMQjcvCoOjX6+tj0lLafBbcRxSkuUkqgwKYxpXdpNqPzmit1eNLQ2+8G3YCpp
	 5yody4ELCm89Ws1sKWdZAuYUWnmydke9BrWHzsGNWpzDyueZvwU8rduBkmlfezfpB7iSO
	 sR+jm+4XerU0AaZNh2LoJfjyhPw+pcIFq9/anrZnAgQpE751ex3LgOjbRorcNszEr2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0Wxdv4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3214606A31D
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 01:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3214606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0Wxdv4a
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso25946235e9.3
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795397436; cv=none;
        d=google.com; s=arc-20260327;
        b=erkDFba7+EQHEOBRm4aVOP/elgcPz3kOJX+fpETsrXNhtzASbrvWyNxprdZRaYbc+o
         QukZTgsRsQgdGPP+lM5tmaunlYn2whhPexKNFFiN6HoaltB2+MxazeCXAGFeysy0f7Ah
         uuAuHSmcMBRHtrUBcxrjubqq36tM22x/v0SJorGtIt/RiyJyuK+uRO9BT309s9i5goYC
         p1Ptq/8Sqbup7ciNLehL2xlOPWN7lU1FSXDBjVpJgVqfW1HxurSJaErixde+fCahw/J7
         iioUoaLYLCJE8Vyjkinzl+tV0MHdtdzohwffk/FHYMlC9TwUtOt3/z4efr5G3jycAaj3
         fA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PHYlamw7fybYjzeLc3iuK4CS+fPI6wiuuTA9v+wgAMM=;
        fh=VrVHfUzJpfq9pj8OOmJxHXS19MWFP6EvznxUFP2NFTU=;
        b=YJw+t2M1a2tgU/NliytajyGqMf99y76rU6RKRNQtdyKDi3MM+aPq3hWrmipbZdtNoG
         MlxvGpS6S4JxwqJ5CMPYb2GTOaGMFywnArA1nnfVz0bx0qY3fltrjDTKE0wk2whcp2Mv
         eWUZriUoT5qQgVlmyksjGpRC14FYDlYQB2MYXRbjQw8Q9UFgZv0YOaO/1GBqXpI5K0Tv
         lTE7ObqEFEGrUkiBT0X05f8u6HMPeJoVRW/R7RzjXZHg9a1zCidSSnq9qQ9onPmLA5z0
         d8/4FY9yqR3I3ultWTwbayCBClWUcCigQSfhDAPlGbMv4al0oU47+0LERwjQZztO+AmI
         GfTA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795397436; x=1796002236; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PHYlamw7fybYjzeLc3iuK4CS+fPI6wiuuTA9v+wgAMM=;
        b=T0Wxdv4as1QDTio/lWPVsCRbgiRkmCdBZ2hURwq3dGLIIibkpSIT0lYOs19qt6wKLq
         uNFju0LgpNrL80jmceAcgNUz39WOBkBJfYTHEUpnC4TYBEOkQlqJxx/U8craeMu4aafP
         nkrPkhp8vQpzWhZOaUIWBSntSGZpM9ekCro+D4zqItNapd/XkBI5z0h6tJ3FQBTkMUXg
         Y0qB3HUDpaXpvo/8SDAIQsSfb/ug/acvBxIF1xhUhzReDtVjQLCjLVsHujCc+RMmEqSw
         o3Q/Ydli60ojoJvAl3VgseIlOkgCo+WlCP4jljEd38wbAZbcNOAE+lCdvxHVVxdRWNaK
         yXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795397436; x=1796002236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHYlamw7fybYjzeLc3iuK4CS+fPI6wiuuTA9v+wgAMM=;
        b=V7UvOImCWPkyhUEpygwlGmWfBrJLjIqGw3DqPLgojJ/mqe8Qc0UGR4bvC/dtKzouKH
         j5g5zr9Z9xzyDi/S0gJx/rqKWbysSLkv3H8/c47xoKPllVsL3hpWbX5E6Y25AWJ9oubE
         zbSd+IWnlIfvrkkqnvD9WC1y1aZEw+Q8CyxOTFchXZm78Wtd00b5FC4wYdCQXpHTtbei
         bDxRP1Om2wMmcSCn7EXpcam1pfYX6oWWcT5N/RsL5kQ7zMdIwpMzHjBHFG/Br4Ake4Wo
         7LkcLK3OaZWmv9I8HyIQOIpcjT4CAeVXAMhkFaz4H/WMrrq3EY/jIzhXc+CskUqJnMlm
         Ozsw==
X-Forwarded-Encrypted: i=1; AL+hErFWH/aJ1ym9kY4mTMd3EDDtDcQaU0HQTGX8UaXfYFQJrwNa5gqtuj1x/W7pnBpIh7ZDsyaqRg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HuXHgpFh7ONO/MFNqTWr1ywsl1P0JP83oXlLFCAkgAlaDNcsF
	SIwU3qSbreP03kkZCYFIiOmOD3mrQBFbEj7wxvTjgkGs6vyi6ot1QJy08JAaAT4lkievo4Tss7L
	OcJ0uK3o73Ujt+ff933QESwicTsmOfh8=
X-Gm-Gg: AZFdTZcxq16o5E+pSdJzWVAO0qRSE6EwG4HFkWJ7wu79Ur7K6ie0qNZIEFa00m/rbgM
	unxK+gpGiZcyT52MYl4/+nwbA8i1Ks4Yp6tK9oBvNwAfCFr6B7C0pDnsJTGFjH3HDpwssNtKvHF
	hF0FkM7lXFsmzlpXzpJmnTnBoamV3zuCfcVtZxJ4UmMVHGePFA0Rs7s10i1RpPrvGoXu3i79W8B
	jyEvfVWTAXLNQvCuvvL1ZOuYCsdnw8w5QYudgXWY1d1fofU6Wb/uTjjjIo8UxrlwoceUuEZRLjD
	QBWWy4VXUMDv5n8OUyxSpATZK7RaNBG2+vhkdyWpBUK6F239ZKUv+VtC7bZosuCHzOMouUUMaed
	lGgTLJejinIjfV0/jkSaKnj6IZ4ay8723tz3w3e93JA7zekBnKB3U49D69aBELaA2BJx1B7NsFH
	tB01XW36iC2y8TXN/YKWjtefZpxRr81z2ksfjLnmDfvMv7HIsJtZ99YQQjyxvxKHEzbvb7ZloTR
	g==
X-Received: by 2002:a05:600c:5395:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb8880ca2fmr202326895e9.20.1795397435229; Sun, 22 Nov 2026
 17:30:35 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-17-9eee2fe97a2d@tencent.com> <CAN_Opa9APLNic4cnohrtZ4-HcdoNvSFvnAKiC6nn+C=thbTAAA@mail.gmail.com>
 <awFbU_VGf0hotbyR@KASONG-MC4>
In-Reply-To: <awFbU_VGf0hotbyR@KASONG-MC4>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 23 Nov 2026 09:30:23 +0800
X-Gm-Features: Aa3M54otUxeoT9sHoHYTq2p_UuIGttJQaGd17GdUT_OXTaZ8k51r48Rl1cQl1ww
Message-ID: <CAN_Opa9ppGsKPhh1jmveYDCwHgZtv0Tm38FB2WoAjTtOPMmpmw@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] mm/mglru: make folio_test_workingset() work
 based on folio LRU refs
To: Kairui Song <ryncsn@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Barry Song <baohua@kernel.org>, 
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 4:13=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Nov 20, 2026 at 05:53:36PM +0800, KunWu Chan wrote:
> > On Thu, Nov 19, 2026 at 5:04=E2=80=AFAM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > folio_test_workingset() currently tests the PG_workingset bit, which
> > > is only the second lowest access bit of the folio LRU refs count now.
> > > Folios with refs 4 or 5 carry it in the LRU_REFS_MASK field
> > > and no longer have PG_workingset set, so the bit test misses them.
> > >
> > > folio_set_workingset() currently sets the PG_workingset bit with a
> > > plain set_bit(), which also over-promotes folios at a higher refs
> > > count: e.g. a folio at refs 4 is bumped to refs 6, advancing it
> > > toward LRU_REFS_MAX and an earlier generation promotion.
> > >
> > > Move the test into mm_inline.h as an inline helper based on
> > > folio_lru_refs(), checking refs >=3D LRU_REFS_WORKINGSET.  The set
> > > stays a plain PG_workingset bit operation reserved for the
> > > classical LRU: under MGLRU the refs count is maintained by
> > > folio_inc_lru_refs(), and now triggers a debug WARN when called
> > > while MGLRU is fully on (the switching window is exempt, as the
> > > classical paths legitimately run alongside MGLRU then).  The one
> > > PageWorkingset() user in erofs is converted to the folio helper.
> > >
> > > Under the classical LRU the refs count is not maintained, so the
> > > test is equivalent to the PG_workingset bit test, which is the old
> > > behavior.
> > >
> > > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
>
> ...
>
> > > +/*
> > > + * For the classical LRU only: with MGLRU the PG_workingset bit is
> > > + * part of the folio refs count maintained by folio_inc_lru_refs(),
> > > + * and a raw set would corrupt it.  The switching window is exempt
> > > + * because the classical paths legitimately run alongside MGLRU then=
.
> > > + */
> > > +static __always_inline void folio_set_workingset(struct folio *folio=
)
> > > +{
> > > +       VM_WARN_ON_ONCE(lru_gen_enabled() && !lru_gen_switching());
> >
> > Could shrink_active_list() still hit this WARN after the switch
> > to MGLRU completes? It can reschedule after isolating folios and
> > reach this setter after lru_switch is cleared.
>
> Hi Kunwu, thanks for the very careful review!
>
> Right I thought a lot about it after your reply, first your concern
> is right, thanks! I should just remove and replace this WARN with
> something else.
>
> And in theory, we should only call this for isolated folio (for CLRU
> it means a folio moving out of active workingset, isolation is always
> the first step), so this helper is fine - except, for the MADV cold
> case, it will call it on for a on-list folio, and will could skew
> the counter and if it raced with switching. Switching is so painful
> I hope we can get rid of it soon :/
>
> But, good thing is it's easy to fix, we just need (part of this belong
> to another patch, a trimmed diff just for reference):
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 4f65867446dc..c936d1fadfbd 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -261,8 +262,9 @@ static inline void __folio_set_lru_refs(struct folio =
*folio, unsigned int refs)
>
>         do {
>                 new_flags =3D old_flags;
> -               VM_WARN_ON_ONCE(lru_get_gen_flags(old_flags) !=3D -1);
>                 lru_set_refs_flags(&new_flags, refs);
> +               if (lru_get_gen_flags(old_flags) !=3D -1)
> +                       break;
>                 if (new_flags =3D=3D old_flags)
>                         break;
>         } while (!try_cmpxchg(folio_flags(folio, 0), &old_flags, new_flag=
s));
> @@ -569,16 +571,16 @@ static inline void folio_clear_lru_refs(struct foli=
o *folio)
>   */
>  static __always_inline void folio_set_workingset(struct folio *folio)
>  {
> -       VM_WARN_ON_ONCE(lru_gen_enabled() && !lru_gen_switching());
> -       set_bit(PG_workingset, folio_flags(folio, FOLIO_HEAD_PAGE));
> +       unsigned long flags;
> +
> +       flags =3D set_mask_bits(folio_flags(folio, 0), BIT(PG_workingset)=
,
> +                             BIT(PG_workingset));
> +       VM_WARN_ON_ONCE(lru_get_gen_flags(flags) !=3D -1);
>  }
>
>  static __always_inline
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bbbb729ed647..a73d89a2ecca 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -374,11 +374,12 @@ static void madvise_cold_prep_folio(struct folio *f=
olio)
>          * as a workingset refault, and the referenced bit always needs t=
o
>          * be cleared even for inactive folios. For MGLRU, MADV_COLD clea=
rs
>          * refs in folio_deactivate(); MADV_PAGEOUT handles refs after is=
olation.
>          */
>         if (!lru_gen_enabled()) {
>                 folio_clear_lru_refs(folio);
>                 if (folio_test_active(folio))
> -                       folio_set_workingset(folio);
> +                       __folio_set_lru_refs(folio, LRU_REFS_WORKINGSET);
>         }
>  }

Thanks, Kairui. That covers the shrink_active_list() case I was
worried about. With these changes folded into v5, feel free to
add my tag to 17/17.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
