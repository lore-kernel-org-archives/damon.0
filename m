Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612399;
	b=lLryibABSrEN8CSaok3DPtptEHTb+pm3669uwTrTHtutmgzs9+piZRifsYsi/Um3Pog4
	 QI8Nz7YKcvbQ5VKW2sFOSKEMoHktAU2OTG2aKmMnGDLBI/8Y+fcQtIC+1OSiWzU5dLK22
	 q50CRZ+lgkRlA0dbeVr4z7laVo/Uf+rHkS6aoEXqocs5wV97QHZ1Puyhr7WzStyGL6Lo3
	 KpFXL5ZBM3BavyqfLi3rUN3s8dd4JmOKw6JdxQ2ERbPfciPjbfAq/4Qq01Q7s5YMpMh0f
	 F4EBRvLxyNuqQTxoZRzGSbfnGvjr28uQU041IxM4crBhqr20t9l4rT8niQf5TMGrIew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5Yz7JNlPDDcs8XZFhzYAPoSiu941gv9oYg8JZ/90iT4=;
	b=aFLps3RqtLOIHkKH7wvdPccEO3VXi5OMLv7s9tRQc1969rERbHMm92efOaqYjJm7JJJi
	 YnG8K4qg/eHiFt8ENAwt4ddvGBj65h4L+46n83Wh0FVFG3koTIF/LPtOKQdLb9MPfJ/06
	 h+1VcJKUzF4AmxD7ksTtMx6uBt6Jep0tLIg52cINizozVRdBZRY5A3ZzSwYA70bMs5+Xj
	 yF5G1dD0L+CyYkuEQWTc49aI8PM0tTY6YeKvCi1y1fZ33WfT/23EBJGZs3MsK7QwAlX99
	 ShfCVpomXheHnLj8btGH9sujJ4oimpXpDMfGT8iX7p7AeO370lD1SqQbz+udo1LDotw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc+nkwXy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93946606A31E
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 13:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93946606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc+nkwXy
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so6738686a12.3
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 05:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612397; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5F8Rf84P2UfSjVDWoH800qas0Fhe5rpsz4p+9KQ1HStpFtVHfLh8PWj5IBFdUbFUJ
         B51Ijpm3Kk3G7NrAfObLXTWQDIJm3YEqtODESKWm1GLAjeKtf/xjiBgH92Zqv+yQBKvH
         frLd5C6utjkeFuxjiDp/Ne3IRUkvMuahMGVJ7HyVu38eDP3/a21lbKMn/i/aMD9Ek4Wm
         Tq02sFxG1AJjUHMarGCJphW6gqPDjDI22mSA5rEWc6MaLZRvGZ9ZOCYTVNcFNoAKJ5BL
         l98FRvdY9s3lepDO0E0mbOoBzxWhOCq+uc/mFtIF2/8byuCN2yHJMdcA89bXv4HC8tLG
         IEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Yz7JNlPDDcs8XZFhzYAPoSiu941gv9oYg8JZ/90iT4=;
        fh=6hMdaxEjX0UtD5XcldJHZZZExtCRmxeqQMmPJXxLvQw=;
        b=Eom7thqZb/7nKughVx4S1SJgER2EhyFq+vEj2Tm851XqwXj76IhbFrJxtCL3RqF7uL
         J6MF2vJJMV1UFM/GFoZYJTaLnd9pLyYlWHjEHAMjdGyjy539nORUS5ciOlhgE+004MMv
         kGD6FiwEm5gh5NARyKhlHceZI1bxyKJFeJMap4qaE4/KVTDrh6jZGLWWGtHdEofT05gH
         4kU1RKZsAcFv18a8rghB1IUvLqYVkTNh6Wy1xz2FJkufWKCldNa3FQpOy+6pEVp4LYe1
         bJRNyd6MF4bGgd1eY7YwB6N0IH2IZ7GXJQWsnf6ANmuk/wWYbp9IyoCT6VazE0A2GBzq
         Jqfg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612397; x=1796217197; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Yz7JNlPDDcs8XZFhzYAPoSiu941gv9oYg8JZ/90iT4=;
        b=pc+nkwXyUV+ECenpz/lh4G658gRu/UuvLZlLBIzpo1g/u6U3Aqrz4JP2lqg3GXhWS/
         oGMJ6bF62VMldar6BiUd95UuHxBxKNPQkiVSlDwKiCSEReqK59MN7T9C9e/eDELxpFoc
         G4SXqT8LYEd05x0dXPD1HFCV/fKlmYiTRHO0m41appx5BVSbu/uqu/t9tzDBNgYH0Fl9
         bH1L+a6FTR11qQ5/LjnGzyLr9oxmJ3K3zyt2abkNSRDyLWUyXC4vEgyn1oCCL6UCkaPI
         tJ7qtIMArkcMa78kWMRQMoG7WtYB+aj0IWRuC78q1EaZ2E9d+CMa+vql8zBpbhGdkuIm
         x2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612397; x=1796217197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Yz7JNlPDDcs8XZFhzYAPoSiu941gv9oYg8JZ/90iT4=;
        b=wnDhpbmUD4s1EsKC7b7zyOUclpnRNLLOD9YPh9ObYu+JaXKDIGNSEUenVZYhDWStPU
         lczmNELvKbjELlaBOgHX1hDuv7O3x5FAtnbrmJJ/E3a/gdbnSc+iCWbvtbAY7tpwyPxE
         WZWusNcEUrbrsnvLPOVA7rr/55EUrOz3ia1YoqHYDBPlI74peVO6lokR0ZuzfHTtNIFe
         8Uh6fW5xO9coTlIRlnaFDMNc56mhnlV7q+FKj8JGFCBEpmoXT89YUm/DjoxAKj6/KXuk
         XrjPauFcpoN1U0KitH0WPiw9uDdkwVUjGl+jnXDNnwytvcjwyTaI2I6wDVA1v0ema++T
         yT+w==
X-Forwarded-Encrypted: i=1; AL+hErExHwDYVHDASuaNyjjl+AfnMZAhNfJNBMB6h796dpmLUOGMDk7cqGI+LQi2JQTjvymcqBfhPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/g9ZVI+xGZNBfj21zgLkx+qPnWb/TG9nKGkxfiMnBDzWTi6QZC
	uhiPA9HinXeMtrWf1nV+9jHfBwzo2NQAsQhAzAr9Lc/z/AY0dmWnuOdRqSnwz6LiGjQPH85e0fh
	JXdoOHVhbtBagBObSHpijFMpuzVqlIQc=
X-Gm-Gg: AZFdTZdX6H9RlSqE9vqLsQJaKpuh5AlvYWOJieUnh6yIisGKyVpD6Tr2iSLtnm/stGx
	2H6or1+B04I5arRt08bjejrVyUkkC4O2FRlO70vZfieCvMsK0BMlsGJexY6lMnb8L93AJkLD002
	+DLXHUZ2Sz9a5DNofrnRCFWXJOivc09MsObbaDvrufsY7rOLFF8ga/tw5oUbLA7GBK08zW2Dume
	n1/c+cuzfRVmsoSXbMI5Ln4oaVh2DQOYa3qb8pPcziBDbJkqRiLIdD+GVhD9S+8XPz6/ba4+/SP
	U1rf164vawQAm96o0KajaCbnAlkUUrJYB6m5vOVIPSZNlRUgO7NFVdY/PbTbbvJwf0anAIT/Vk2
	OyKKRbYb+jtSNhExm3AzeU+aie1SlN2MmhYrJBXGbN/Y0qb+rM3VeKJTxscOlhlNn7fao+A==
X-Received: by 2002:a17:907:9693:b0:c4c:ddd1:d006 with SMTP id
 a640c23a62f3a-c513ab47f40mr1378964566b.38.1795612396826; Wed, 25 Nov 2026
 05:13:16 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
 <20261124-mglru-fg-v6-15-8ffea39934a6@tencent.com> <fc51ad85-16f7-41fb-8eb3-2b8ee595e711@kernel.org>
In-Reply-To: <fc51ad85-16f7-41fb-8eb3-2b8ee595e711@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 25 Nov 2026 21:12:40 +0800
X-Gm-Features: Aa3M54rLCFPdJCUVsWAcKF2l0FhpWm6CiFAaLjU-bCfz_TzbQSOhJaNF1aUKI_Q
Message-ID: <CAMgjq7D-EFYsivqq1Z4c60ZMh0pBU2ofgfqVaqp_vbPG8wbSiA@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] mm/huge_memory: mark folio as accessed more
 accurately on split
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
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
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Hui Zhu <hui.zhu@linux.dev>, 
	Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>, 
	Ridong Chen <ridong.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 6:09=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 11/23/26 19:53, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > The behavior of updating the folio's access info isn't consistent for
> > huge mapping splitting or ordinary unmapping. The page table's young
> > flag has to be translated into folio's access info.
> >
> > Right now it only checks and sets the folio's referenced flag, which is=
n't
> > enough since folio flag updates on access have their own rules. Ordinar=
y
> > unmapping (zapping) calls folio_mark_accessed(), and it also checks
> > if the VMA has recency to avoid false updates.
> >
> > So first just use the right helper here to be more consistent. Keep
> > accounting the young PTE as a cache access, sticking to the current
> > behavior.
> >
> > Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> > Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Tested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/huge_memory.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 75e8641bf9ff..fa9f6d21e786 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3122,8 +3122,8 @@ static void __split_huge_pud_locked(struct vm_are=
a_struct *vma, pud_t *pud,
> >
> >       if (!folio_test_dirty(folio) && pud_dirty(old_pud))
> >               folio_mark_dirty(folio);
> > -     if (!folio_test_referenced(folio) && pud_young(old_pud))
> > -             folio_set_referenced(folio);
> > +     if (pud_young(old_pud) && vma_has_recency(vma))
> > +             folio_mark_accessed(folio);
>
> Can we just have a helper that abstracts that? We pass in vma, folio and =
young
> state and it takes care of things?

I think we can have a folio_mark_accessed_vma(), and so it will be:

+     if (pud_young(old_pud))
+             folio_mark_accessed_vma(folio, vma);

Also converts a few other callsites too, also avoid touching too many
other folio_mark_accessed callers, there are a lot of them. We can
audit and see if folio_mark_accessed can benefit more by passing vma
from more places later.
