Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157344;
	b=hS0bCFKg3riqKqTBdAkETXG/4Zydr7fDi2lwFVVorl9iJwhS5IPgUG1JJCz2DZ+IXW1W
	 r0uNNSEuY/aqQJyDIXTSJMzJxdwPRujRuAZ+PGl91xsq7mvfNspHcy7eo9hAbu+k2802Z
	 1xN/p7GJag1/s9e/spt53sS1mVFzaM4mjn3Yvc8fRp7WYmaj2GMB1weUsa+vofLGj5EKk
	 W4zFbmGaXdJc6k03Jb3ZYdEL8HSZjf34vRBpFS+iWNp3It1m0PtghhAl3hIzo5HUjQCln
	 IsOxSxxkIiL6OVR9S6txp90KHO/6iTmHMpXv3gYRbXQezqVJ6G5QYYBNFOD1uZW0MBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n+lyQHOp4KoneVTmx0lXKvEiHfZq/Kgi2CNuQIZ6Z14=;
	b=bhKqn9pSi8c9Sk1wHGH6b0pB2w+UMWMNJhSf82ePZ+KQhrXWYAKtO8umJANP4i4pPSsW
	 opEmfROI2S+XrpxjouVNCiBIg642u5fTsOf+p2DmNzUgKH4DjN8g+jnvtZviOxYVAVCUS
	 BwkRd4qnRaBj68BiD7sLTonEsJVDwhIEpBrkKHFG3IarEAq5nATwQ967E5ROCrLzF1+6J
	 wfdurtQQiRMO4TUTWmu3NglaIIYEQu7PRHxV/B0RZORPrPmX4hGn72pJs9jJJxpRQ7tVd
	 n/DwJ/fcn4xp4lQwFGWgSkV9b9Jdp+ThL3eM39r/vpMKIBUXE1soiohJi/ttizsGJKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zX/G8RkI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAC606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEAC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zX/G8RkI
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so4697395e9.2
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 22:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157342; cv=none;
        d=google.com; s=arc-20260327;
        b=C5BC1MzRYBd4psNGShitLTQACJ+QUEtOaGZH+odoIEDTi+Tl1H3+/sQ2t+KhxSWyhh
         QvXmvTIujdV0QsRiuzgZA3OsNQYRFMxlfdDKrS5L9/PTjA3zZQzJv7kGDtA3X7AzEqC1
         Y9aT0K17ohbvDtIr8JQ2Nn99gREOz2nJ/IRgqyM7uFm/f6vlWdhLM94alZhthGBagUke
         RjLYF9LxmHOS6vGRSy/5GDmHIJndAciZWggDCAhCuxBePVjMkMY57ZNz/G8J54mEbPbS
         nbn0JzBdY9iGuUEqycpfFsRZjt7iuhCKyCDb7FWYiFqYifH8438h+8MACsYr/2qwsDUY
         LMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n+lyQHOp4KoneVTmx0lXKvEiHfZq/Kgi2CNuQIZ6Z14=;
        fh=6cmGzt2EcGP6PSsbrpcTZR8u5BkehZSVRtkGOUNCOLo=;
        b=Qc5YwidR0RPPDhriPUOs5J/utobTYGXcE1vWxnvUMCeMm3PKyvchRVZioLEs9bG/Yz
         rjuZnBgIFsGP3uyw4wtuyybBjBVOhnJERkbMaZEYXiHReQxAYzZSlvfTc+g1EsQsAPq/
         reZYdWhYbkDvnHDYWProUbaOQVzECfVG58A67MbHvqUwFbfgOG2gciETvI2dyMZa/ZpA
         WGO276hUC7jQfvuGAXdH1Tp3C8570/C/QZVZgdNVY2tprDIcKhmOjySvBizlO/wRjtAT
         b+Dm+wDjVv+lwy3zMVYLMazuo07bQqhP5wAmN1gipKY0atSWSQU2VPRX9554QyctEips
         vkUg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157342; x=1795762142; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+lyQHOp4KoneVTmx0lXKvEiHfZq/Kgi2CNuQIZ6Z14=;
        b=zX/G8RkIr6rVEVatYi63hCk9XkrgjOX6AoYFtWHVZEFASG9TyooJi8fvSinw2O0zC9
         8o3k3Thm9jRncITDuL8zjUkhMoza+R1Ru2vD5mzH8Ut0iLwtCSiCfr9uRhqLQzviNoZH
         HI5s1egpGS1dSKtyHnxsBxM6WT+RVgtbVtfgukZn6Iq9tL6BNPav9l80XtBPZdSuX9yG
         y0FdSVDURRTFkWt3Utu/WY3b/Bz/9v/8fkB3NyteOPWQS3cZU2n6ZRTIzPmMAJSn64+u
         oC7MesjEpTZP0ldwwNd4Ir7RoN/YonSOiECT58i0oArKhNP6hyNKkeIQj7EN1GYohPqC
         1lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157342; x=1795762142;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+lyQHOp4KoneVTmx0lXKvEiHfZq/Kgi2CNuQIZ6Z14=;
        b=SdJLnsiPlC0essqVDPPDhQKx02j2y1Nc2zCwfqvP9ZXet/f5UtxUwQtz5DnaCoK6+z
         /C5bnEi+2QJ0p6Jjft6wY8ikvsFUB8SPi7BlTSeqv5zsE3poZ1zeoL+xuGvdnCMbKcE7
         b5UtmrBUedcjR0Zh8Zs24DJrtuTGFGuZQToKIVbNrVWEXjZTfpK9ofVHlW7dwQZhdtmH
         tzo19xMpjmlh31WFXfXKd3T3xp7ftIGNLpCuKKsGUYrbWqL97z2/qZsD80HCnWIMfoQt
         DupGWxwvA4UMqYCBvLcHzEBJ4oJOo+gR8Nk29+Bnf/VGJqfkvk7NYYlG4T5/WO+uwOcJ
         SAKA==
X-Forwarded-Encrypted: i=1; AL+hErH3/hQgXpESEbc83MuBNhxHVHBpH5cAHIlIt7DQOyIkZPkRghtG41TyEYWU9AJuOCd2MreY+w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/TAZnKuXPU1PfJDjZ1YIVuLzBsSERxTEA2LdP1GIvriSccVNYf
	vONHzipmrjK6LNL2T7rvBnVLgEhtEOl6MPX/d4MsDRTLXem5meC6lS1vP3xxgnEf9wx3gUIeZvi
	AUwAq8oMO/bq1q+AbsOOd4o2NH/p+BPc=
X-Gm-Gg: AYBFou0YiqjPs3eT2Y76iF9g8OPgiY2bs6YNXrAtJ2Cp7UrEwUwoTckuehmS2HtWNP1
	QQT8HDWNF4AolW8GwmrOPyAhSYDjvJSI2r66zS8czdVFg1heUpsua8Qs1clEGPRaLso6Yg8mn4g
	wAlBWVbJVE36+nMRbHrybW4tAFHo+fGzuGlZWMS+lMFbTIZ9s0YGAMbx4q0AF4tfIfisO0RthI8
	8Cz0Ux9fa/+KzTM7QLr1uHCEyeMn7gR1VTwPF/mfBmcpWL0vfhzPa9f6XFV/QAO1IoEDeaF3Z8A
	vaqqAFa01QjjWz7urpLuKywVy/SeNmxQuQuYsLblzz/vII8SM5cXVVy+tfHCduEnfwFP8g/d5a5
	Nxl3u79B0Cmsef4lj70WmwB7yzBaV4x1L9pQd8hwDl84x5qKU0F72b3JwpguX6y6nOA==
X-Received: by 2002:a05:600c:3d05:b0:4b8:d17e:da27 with SMTP id
 5b1f17b1804b1-4bb88930872mr41310625e9.27.1795157341259; Thu, 19 Nov 2026
 22:49:01 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 14:48:47 +0800
X-Gm-Features: AclHuK_tpistnJ8n9EgGJGhoSv7JK71sLxGmAZ5e78h-Lbf9KixLF9WGl76rLxw
Message-ID: <CAN_Opa-7j854ph6e7Ckmq6UgmmQerxF8V-ikSr9JNyTAHZCxdw@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
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

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

On Thu, Nov 19, 2026 at 5:03=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> the counter is eventually consistent and only serves as an estimate.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/mm_inline.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 2395ca8ee305..2edb9beef6d3 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -47,12 +47,11 @@ static __always_inline void __update_lru_size(struct =
lruvec *lruvec,
>  {
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
> -       lockdep_assert_held(&lruvec->lru_lock);
>         WARN_ON_ONCE(nr_pages !=3D (int)nr_pages);
>
>         mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
> -       __mod_zone_page_state(&pgdat->node_zones[zid],
> -                               NR_ZONE_LRU_BASE + lru, nr_pages);
> +       mod_zone_page_state(&pgdat->node_zones[zid],
> +                           NR_ZONE_LRU_BASE + lru, nr_pages);
>  }
>
>  static __always_inline void update_lru_size(struct lruvec *lruvec,
>
> --
> 2.56.1
>
>
