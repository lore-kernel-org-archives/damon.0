Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162923;
	b=pzqhmQjgv0D5luBBRZGInxiXhvAPUPgFDEhm+bGvhWwn/xCPyAiE3Lq7HXDrJi9+3ILy
	 ZdHjGAeNhWRQ/RUImzBGUjsTae33jz/2tL6JIwV/FS95P4yrcmcxS+Axyzle4Ug5a/2E2
	 ixdoZH+vOryXoJ6uxPb/IQEiTa1cDph8BItVwvTfwC1px5RsfsvhQGXoYau9gB+ADqRfu
	 dfwJSoYWO0Uc+bzpXDjhRiS8WIxGijGgpx6l3gwSp85SxfLicJ3yYiZBZ5qA2edaqarIq
	 l5862XM/G59cqV+RmpPqF6GZuO1VhJTq0ifJ8mA3t8kvNTrJsHTr3yblb45cbrCrlFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6qaWnWddVt0MJiy+92iRgvW/WkoPo1PC7CtoH61AXG0=;
	b=khFEzeEUxXWKeGGA9I953Wv3rOismxw0jh5J889SQMZctHnhHuKDqxzVLibYF8R4mTMc
	 oxHuPaom4xjQwp0+K4oTWjPZWrrMA71Xl2ea6s8HNUFsl1eY7QlaO6SwfaEPLQtFoc1uO
	 LQ3wRKazvbzvut0drr5/rB219n12UpMXWyDaLmqOcWoxm8aoSqTnYk184eWiO2e6eER4q
	 8eulBr9QOVQ01NsTwJ+AhfW1X5VKs6gHzvGHRkiYjclv1L1+14jK6qz4X2QHMtrMyuWmy
	 eIR6C8wFyqDDFqmg5S6V0YjrfWRsCKwQZ7EuzbEwAjZ0PBLtpuu48EEt2LsFc3JJGmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eKMB/8Tz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C87606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 08:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C87606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eKMB/8Tz
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so901689a12.2
        for <damon@lists.linux.dev>; Fri, 20 Nov 2026 00:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795162921; cv=none;
        d=google.com; s=arc-20260327;
        b=X/Ugcm4Bc0N6GovTT6rc9ZhDWIeHtcXZjbABhv6w9Mx3SJpnl7YItUtil6pCkbZZ0V
         y0vIoJ9ENPrrlTHAc9BaKLEduG6nevPSSCd4ITTq+uA85rTTXXWpmEGWznqoEb3ebjQy
         qJyAC0LkTFGnLnXcr4Luly5HYM3SAzXPAXkUDpE5OCKffGNJTqROBihOqvKBdRLoOcfV
         hgrEj509U3bzK6CybDVqHkiPiXyirR7+g7Z8J8Ug92+MRFl57dRfHh86CbPpRUczr9Zp
         SnmlpgF6Q9WXBW6N9cUFxUmOophdicYwuaPphdYEhkGVgBXo5qNN3alO8JPeMKJtxNWk
         8vZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qaWnWddVt0MJiy+92iRgvW/WkoPo1PC7CtoH61AXG0=;
        fh=QLE29lGDM+CaEfe1FI7+VD7kx8dsoD7a6byg9anWm9k=;
        b=bKJbnmkdIeO9r9wftlcB6DZFqmVkk+6JJtS2UaIDtSnHjb+MwjztStps68DYVQPHFm
         67he3CXUu4WFtzwtJrIgk2/dhNlyaIzBKHXi8EUtO7ZFNaMJWbyCZlu4EvXc3DSzyrKd
         ubq87gg9wxT6hFUe0m6rEZ4+9DZPDi1Ek2Ax71LQlfud2oPgn6BrHeuL59plh6e7hmMI
         K0DJGP0v6SuKH+oa0LmNcbG3rZe2CVJPk2YWm9yDB+09Lr8sgKq78nboHCPRNUpoYInm
         9jvQs1OnY2oxtYn1FWiN0ooek1dLwJxkTXawmhlveP0WaK38f2g8Di7dC25d7HnED37X
         OfaA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795162921; x=1795767721; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6qaWnWddVt0MJiy+92iRgvW/WkoPo1PC7CtoH61AXG0=;
        b=eKMB/8TzIuHcqmRbrFWf2nAmJT5PrNAxoVbwSj+dtVrztRguTAh4jcdzETcs5U744y
         2BdSf3eSvoHeauALwWhnjD4e8XAn7DxTIVCrVDWtSoHcuSb6gtPIoCnsCfWbjzVUMPxo
         wU3wPOSimKDtICiaAbsj4b1Y9B9tLISakYhn7xFykwlUh1p6eTNwVdIomLJnW/3V0B4e
         q5Bbb5wvrkOhuBclb4BiaFW4auBxD/uxP+114+Ojq+upfQMWD60oIq/G1Gry9BB0njSZ
         K0g2pfgblult9YPCmC9/7hDOUv/Iv+dGzhwZpqpm59kc9GKeo8/ksMjlqJGhp+NxMUI7
         v0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795162921; x=1795767721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6qaWnWddVt0MJiy+92iRgvW/WkoPo1PC7CtoH61AXG0=;
        b=OQFy6KWpEug2t6QcKs3YC5laKSFqm6FijWc3B8Tag7qgSw/AO05XubaOcmkKNQEM3R
         bL09fLmeMEL+MQUWU1IGYnMRs1LfBgPL+Hw77pHqsWpHAawd4jOXk1d+BPqxhOdrAvQj
         rKLfyzmkUjkliuCPevHwfg5Qb254vA+FNrBvVVaT1mmjJNHIB4TW3z421pMQ6xzQEjdt
         wrsEUpsQaF8C+AuvopyGSeHlDLIyGPCK9pGf6bB13Xso7fqh8mFuI+AdwXrobuCSbcFR
         geLQG5AQQWsbiiw56eGthSVEMX+PaoO8hUNLzX5JI0VqYVL7aT+BOmgMbPibETSJryBF
         L3yg==
X-Forwarded-Encrypted: i=1; AL+hErFRW5r9Zt0U5gt7ObnXJ+jdseG7a2I706Uy8ZGnxYU8041Cdj0o1eD2zHkNvE6Cvaj4LOxiPw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9QDNxoYsp415AwfiRekUzJCG5Rmwvd+EBCSrYHFl2N64qeE9nd
	UIWiB8JXEIV3dIUzn24fzGizbgBAs4btO7vAvBDrDFx/XYeD2eBwPhhVByOQNGBKqD9u5koRw3B
	JhHg9MBo0F/d4aal3tEcHJcRH8d8kzFw=
X-Gm-Gg: AZFdTZfrsOiqT8m36/rUafpYCnEj4MPU62g+4YI1nU5LBI0XHQ/bYLVnHWc6VPMA+Zm
	5kHea0s+22GfUq9USfs40CCXulRSWxqC70gLARyKpRdbD7GQdPoSViOMFMffHLMFrMGUnvdAbz3
	uHIu9eM2R9gaT+WQ6GWNu67xTDvmOhjrJdcEmP5uppKA8McUMmv827k6gnRj8DBPqqILH3ioxi7
	FOKubDmcnSftiuIIDuPKc08j9OMPcsvJvxeuBlJS0ocnu5OKE4/RByOCGuQmwBUbNiiCLkdvNnf
	Tpj59ll7uZYfG52R5rKm5CP/WDizFBqtFxdX4a66BZfPVRFATMhm4Pvd5+f+XjRTpKF56FsFY4i
	zIomXuoKmc4e4CiZjYKbp+Q99L5YYuPaaQGFFy2RGiXuRGw+3l556lMXc10Pem0U=
X-Received: by 2002:a05:6402:2105:b0:6ba:3738:aa76 with SMTP id
 4fb4d7f45d1cf-6ba37ec713emr1520051a12.28.1795162920798; Fri, 20 Nov 2026
 00:22:00 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119-mglru-fg-v5-12-9eee2fe97a2d@tencent.com>
In-Reply-To: <20261119-mglru-fg-v5-12-9eee2fe97a2d@tencent.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 20 Nov 2026 16:21:48 +0800
X-Gm-Features: Aa3M54oR841ct7toroFKb5-FMop-YAlKT3qgtmdkpn6S2_l60VC8mi_ZrcEbsCc
Message-ID: <CAN_Opa8SFEzeu93GpJY7OkOUP5AeB3P9_8MGuhi6JJnBQsA4Vw@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] mm/khugepaged: convert to LRU refs based
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
> For MGLRU, PG_referenced is only the lowest bit of the folio LRU refs
> count, so folios with nonzero even refs no longer have the bit set.
> folio_pte_referenced() testing the raw bit misses hot folios at
> refs 2, 4 or 6, under-counting the referenced folios of a candidate range
> and aborting otherwise good collapses with SCAN_LACK_REFERENCED_PAGE.
>
> Test the refs count directly when MGLRU is enabled, mirroring the
> smaps conversion.  The classical LRU keeps the plain bit test.
>
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/khugepaged.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4bbe319ef86f..68f7a30e36be 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -579,7 +579,9 @@ static bool folio_pte_referenced(struct folio *folio,
>                 struct vm_area_struct *vma, unsigned long addr, pte_t pte=
val)
>  {
>         /* The folio was referenced previously ... */
> -       if (folio_test_young(folio) || folio_test_referenced(folio))
> +       if (folio_test_young(folio))
> +               return true;
> +       if (folio_check_lru_refs(folio))
>                 return true;
>         /* ... or the PTE mapping was recently used */
>         return pte_young(pteval) || mmu_notifier_test_young(vma->vm_mm, a=
ddr);
>
> --
> 2.56.1
>
>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
