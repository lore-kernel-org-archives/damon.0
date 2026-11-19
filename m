Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795109651;
	b=lqrSutMzmQTtMf83VdZ4TbQD8sxnOw+AdlpbT5z1CUtXsAEJinjDyH5vk7QMZiGHl3kR
	 YWT2X31qZUc4t8cVUqroajFrkYh/kbW9pj6/GkzJtzcLSkgEn+AXiYmsEGj0Aw/5qht/8
	 H/WUACqOWZ5KOq54T4dZDea0sTGOn9+UimwrHmZdj6a4Nrizn2obttLHsYiPGAMJU0dPc
	 32YVjQvkNofYyJeaQK5i1vpwGsy+jVEAar/VVhqEwZf0A0/naQu2SxLkUlMogZd3at3Oz
	 SUp5OvQB/ujprnn4NW2kR/1/MjCk3dcbeJ2eu0c/QhXwA16qkVNuZvaPz1OYSIXpDcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GU/DHzsJXxqhMdzOYAA9Okmyib9cC+TRn+DETm5eoNw=;
	b=5jA5VUZp++KcutzDchWwnCyHHa0cUottPeTRnO9h5GhLjvIeMq0+IV9Wepyqatb1BZvm
	 6MlAyqrfN3YcHefbS7683gNXApSUBZxFnntPrut7vTIv6MvCuc1PbdEpEZcsMveoyugwU
	 xKWMdy2J9ezZJaH5Msqn6AdqwwP4kTMEIodQtpAoAgEv7CjpIFsUpBnLV/AT7Yo25yKAP
	 xVP9lNztBodo2wcDFy5sokPe5R7+pbmIG/26eiIVrnZyely6KTYfNUX5SUyHoKuY1VnyE
	 N2L1Oyke57aR/o8RssgENLlDthGFoepUE0L39ZudefvpofRUdlufJxcVuFHtVtjD65Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbOXJ3B0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB191606A326
	for <damon@lists.linux.dev>; Thu, 19 Nov 2026 17:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB191606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mbOXJ3B0
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso2436066b.3
        for <damon@lists.linux.dev>; Thu, 19 Nov 2026 09:34:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795109649; cv=none;
        d=google.com; s=arc-20260327;
        b=o6VgpzNk3UWITVEGx6hXLkB/NmfQt7kiFDdnH7JjCqJYM3b4uL6y6WXkUevjXd5Y4t
         k8GVyN+cVKR9PgSzSVVbraN6q5pcLHH8llHonF6cIMredk+OeaNR4kTtXZ8vGteLCJRN
         a7+DLcMbpIbfNKFK5oEr/6pdwJs+YLYHxXdJdeCH4P1OntxmoLqwJunNeJybAXjt5Dj0
         n8+WHTS7YyOnp3Qk/hjppT7wIA9+mNieyUqAS4DwcC1LAQnmkKX9VQFPoM6gNRUqo7VY
         AFbCr08E3ecPnd/tZElYxAHFp+zUUxYnauFoMQM+6Jcu8rJQIi9GMzBVX7TJotH+6ZoB
         whLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GU/DHzsJXxqhMdzOYAA9Okmyib9cC+TRn+DETm5eoNw=;
        fh=ARhmdu3Bbgyu31GnocI3gzZtBhhf+cnoZI8eIGaByQ0=;
        b=qygp6qXnZCAJyR0hz58kNp8IHBrFVE5PfiA/hcp2pF1HhZy0l1k6Sq5xQemr9ZB4Us
         DDsT4cvxAR99SjltRijGJ1k85U/x6MzM0RVaKjoaxb78vsUhj34f2rTzY5mnfyhB7fSI
         92DulTnD8kDYZHUNerp5JwQ/xpKjigyR6jNS0N2GdWqai2OPbfQw8nTGopO/qVwAYyfm
         4LOb8Kzct0EHVLL/aMshzFNVa0W3QCikrkf9oyTKI4yLlQp06vdamVxUYdi+PGqdnlBQ
         z/9afx76NqckU8Y8Vp4D3Ek1vUYTdY4PhCXLnJnuIy8f9n/9ZwlIlp+uKxYr0JLpfHEi
         QUsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795109649; x=1795714449; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GU/DHzsJXxqhMdzOYAA9Okmyib9cC+TRn+DETm5eoNw=;
        b=mbOXJ3B0lPA9WLh5Rbwkf7ZACMPWn3DMOviZV6Oklp+hK1D2H+qvoz3dfTpu2sNqaZ
         4qx2ZzsDSkB0NbGPjQ9/Hs13RnbFb5hk6NWlvg46IPSoVVWObxutQ8iDBP45PzhwECVr
         IPllhkmb8GvAY0MH5+En2j/ljyfmDFTGiazOXH+ETOsvSjlJayRw9KxghjlrZHg8pbr3
         tNZA2oVKj/E7THOjJgtwJDEkCA0220h9LVo2PgoJSOVb8fNAVzaTTBYfg+tCLzloUzua
         7gm2N7da6kyEs8vfQdsKUkSW3doEHv84ADjslL+P8oPy0lr4iApS1DJYrkoc46Abca5Z
         syBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109649; x=1795714449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GU/DHzsJXxqhMdzOYAA9Okmyib9cC+TRn+DETm5eoNw=;
        b=h+n8+XwH4vPOyAMtsEmvAlctXGQZyETUeYLvFquoIVxLuvM0h7WFCwT6a19RNmt+Ya
         t7tASEsves5MGJsW3DJPnO3S//nouRrKbX6g1QZLQFNBT2Awf2VNqkHA58kuOmfuw+jF
         vhut+il0yHXHEASa2UXwi9zL+0HPvmUJwrB0hYxJlXA81KWa2qEgkQXhHV7BRvXdSr+o
         lXhmM5onO2ZS0p4IYUNXu2kXx+ZNUaqfEMrv/I6lq4ePwN68wOc84a2lb9XUcLNcbhO1
         s0FiJoK49NjFfB8cr9ni58tHW8oHLtYzFq2pcGU2sd1HI7IiXHZAiSJl7Ru18kYa6WNZ
         yEHA==
X-Forwarded-Encrypted: i=1; AL+hErHwHRRFh/otVqIFuYKmkBGlqUekFJfuCA/5s+rbYYpuPR4c5Gw/by3CAlkQc84lOK6fqb3BAQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/QKRv6S/r9kRNCgsLdd0vukywngUtxcl1ceoiJ2x3KHpTysJY1
	ssuc0pmyvsLpxpUHd4hUrRdUMY0NqVJjBnivFU/DRc7HPIJwCbWX9wx0Q9UIslSul32vMMOBHAA
	LWOYs2SkP/WtDm5SZZc6zQickZLLLV28=
X-Gm-Gg: AYBFou04PyDy76GcYVCIfNZcEic3s7hIz939ZUj7ivzUyyqLGHWJVTdmy3QOylYkEXA
	YwvK00yziLLBTr6MYWnLh3uTp5D5acw9QUm+q/NtzrpjFiOWFeyMwke4QDgdGChjv/coPoHv+dT
	xzCSr1zqCKb3FKi18yTq35w7m+aKJRQT2D+nSNTcVtYTRQKpLVUktWpFRixYN1S1IYpE+HV/YlS
	m/LI3lzvSL4FcFJ92pgxbOEped5GRivbWdehMgRc8TH56XWS5E8fj2PDTxMVwhsy5OB/JSHHuve
	/s9DJNoXlkSoLG8Pe8d38BoZTnuwAwUcDkfKrr0vox7aWAN/FC/ywdytCufvgjkmtN+Q75YxH+F
	NHNF3F5DhumjrpF1zBFbae24vZEuictBOzO+lr674eq8BAC2nkTvKocyojEybXH72DM1fkTA=
X-Received: by 2002:a17:907:9693:b0:c4d:331c:2e97 with SMTP id
 a640c23a62f3a-c513ab47f5fmr64354966b.36.1795109649032; Thu, 19 Nov 2026
 09:34:09 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119112357.275352-1-hi@tychen.cc>
In-Reply-To: <20261119112357.275352-1-hi@tychen.cc>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 20 Nov 2026 01:33:32 +0800
X-Gm-Features: AclHuK_14i71TxMIEATGAgIqE0r8tCGaC_TLqpyybte_WVRWpRVBP4hHZoQKFT8
Message-ID: <CAMgjq7Dnjsq4vid7H4usOB4f5AS8XzhG75mvf4-Y=an95gBERw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
To: Tianyi Chen <hi@tychen.cc>
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
	Xiang Liu <liuxiang.277@bytedance.com>, Ehab Ababneh <ehab.ababneh@intel.com>, 
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, Lian Wang <lianux.mm@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	damon@lists.linux.dev, linux-doc@vger.kernel.org, 
	Maxim Muzafarov <maxmuzaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 7:24=E2=80=AFPM Tianyi Chen <hi@tychen.cc> wrote:
>
> On Thu, Nov 19, 2026 at 05:03:32AM +0800, Kairui Song wrote:
> > That's because MGLRU deliberately disables hotness tracking for
> > MADV_RANDOM areas while CLRU still has refault distance.
> [...]
>
> I ran the OpenSearch k-NN test from the RFC thread [1] on this series.
> Its .vec/.vex index files are mapped with MADV_RANDOM, so from the
> paragraph above I expected no change. With FG the gap is gone in this
> test.
>
> Setup: 25fee5b1762b with and without all 17 patches (they applied
> cleanly), the same .config, and a fresh 4 vCPU / 5 GiB KVM guest per
> kernel. OpenSearch and a one-pass 96 MiB mmap scan share a 1 GiB memcg
> with no swap. 5 seeds, lru_gen enabled=3D7 vs 0. The script is unchanged
> from [1].
>
> Medians over the 5 seeds, last 1,000 queries after the scan:
>
>                   p99 (ms)   memcg file refaults   .vec resident (MiB)
>  base, MGLRU         66.18               144,387                 99.98
>  base, lru_gen=3D0      2.09                     0                117.19
>  FG, MGLRU            2.16                     0                117.19
>  FG, lru_gen=3D0        2.12                     0                117.19
>
> Right after the scan, base MGLRU had already dropped .vec from 117.2
> MiB to 54-71 MiB (median 66.3) in all 5 runs. FG kept the full 117.2
> MiB in all 5. All 5 seeds go the same way, and classic LRU is the same
> on both kernels.
>
> This is one synthetic setup and I tested the series as a whole, so I
> can't say which patch makes the difference.

Thanks! That's good news.

I think the reason is some of the hardcoded biases this series
removed: FG places purely by refs. Less hackish checks, more generic
performance :) I reproduced it locally on the base kernel too.

FG still doesn't track MADV_RANDOM accesses though, and still no
proactive workingset shift protection. Refault distance will cover the
rest including Maxim's case IIUC, as demonstrated before, it's better
to do that later as it fits much better with FG merged first.
