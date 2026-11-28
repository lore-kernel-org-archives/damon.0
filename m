Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795870049;
	b=0NzzigBw+VS/Xeipbge6o94cdSAOZQcbEXjt1QYAnAUes44InobFj3C+iYsQBj0GdW++
	 I3aS4hxpcUNaFEgbM2v5geCEefVNo+z7feUdz0uIk0ovSRXTqV/bNwH5QM/vzBeXMcnvk
	 fJyUsvWcevGgf2TUg1/Mvonn+3X5qZIdGayofFhvqKE/hMQYf3/q/XEAjlgV7LJXxsjry
	 HEW/uJOWbMVsO659vbACbDvj0GN8w2KBvsINDvtQX9jJgBSOoFYwxnjTKp+nqUsKYovm/
	 uoHhEeV8/BQlAuFobrG5j5GJYz560oDX43T+LjjlqbTmBoiYgZWfEP/IsoLS7py41aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Neleil5nC8s9bt0MpU40WqwbR7w+O9HixUWBXPDe1yo=;
	b=ll73997EnVTI3DRKHcfQYXM/wgmTsTJxVd2rxBig5lX//DChsjfP+3X9VNwEkq2+BeV+
	 cFpuHf8Nd/QG6wVxzfqb/ONLuVtVBVaOrV+PT9+aOmMyVOWmGWDD4JJ4AnK62F1UmU/sH
	 WnpsT2H9v1AwND9qqxsc/7B0kaxjHpr+mgKshdAEFKeo50YOTTgCJXBqewdz3qHD2/a1H
	 /Shj1TtsMWPt1kLayNG1lTgCK+0EsAojqmid9XzEKf1U0swhORL13CCE2rXxvI3L2J7l3
	 wlZebZFyzgilAKMUd/0rM29k2wsAziZEE+9VlhOWOxg5FC55bUArop9jHuNBFwPCdVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8nYL7qy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C452606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 12:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C452606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8nYL7qy
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4aa5833c263so8614480f8f.2
        for <damon@lists.linux.dev>; Sat, 28 Nov 2026 04:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795870048; cv=none;
        d=google.com; s=arc-20260327;
        b=ou4plt4znt8pxA6iKGTo3dW5ig3XEBZbjt3VuZhJLiN7zOACzwmA8v7yyfzE8TZMJl
         yDdKY4P2ZOVteZ5tJwy/txQPX36An7zSyWbev0+0gDDX4g1IH5QOVTi5lTs9HWnN4rO3
         ZQBp+ARbcpPOO6uXaIHQoUYTGyUrgakO43Dxtse55KeJ+gJS28itSTbXKGs765xtwgYH
         YjT4+SUnIpTsrXiddoi3SXYqvlZVY7TRiOh3DPTsOXRC165TMsbYUh57KWRTEzPISgL0
         n9QhzElAwjYlpqfN8/7zZkSQj6nGfau+2t16DbhqzmpQOYc8sRqNhBJYsrl2UHuIrcEF
         dEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Neleil5nC8s9bt0MpU40WqwbR7w+O9HixUWBXPDe1yo=;
        fh=dT0lNGbbE5RaXKPjsl3BVrjexxsxX9i/WzTuy+/wPCs=;
        b=p+cWZ/WqLgxID0LA1SOH+xIbfAqZmXqDtLdWvul2HQ8g6u0l2D1/KMaocLbq4L/DQU
         /FD2AgaZGLpm+9NMCagcDZpYtuFNJcm4UDCPxCkHZLd6vmwd2Zs6m42jDzrd06cJM2FA
         JdyqTSn7TIqdot0uvu8v1C94xk+8xtSDgSZJnbInTkgX9CaPs/oopnuH88Clko4LMRfT
         WSOVZ9HmIfWr/QPCyRNJ6VZ7812RnYiBq5MHlAun6Zw/eGqS0zVbP8FjGeSdE300RiTk
         3d2hqCycFeZED0OYRXbOlttmqXHVwcrJDrziViQlmoN04MO9FEKLkWolCyb0tp85fXH2
         chMA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795870048; x=1796474848; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Neleil5nC8s9bt0MpU40WqwbR7w+O9HixUWBXPDe1yo=;
        b=r8nYL7qy6jbafu4PuhhluiOJcU/rFiGwJLKsqoafu/6E+Wy4gQljwE/VM3Ooe7FYbj
         u30J9WJ/FLUf+Yrseyr6gnOFevAVQ/xTMeK0YLC30a598DDL7YMxVySW0Xfe+Wst4YiS
         BxlHzouLG/oYwrANTAoFbx63RaiIchlSrsqv70iRkVBsDz2mpFN5nD33BbwU9q71UJDH
         HHfXN+aK2vOEPK/VULSe/66EtDiKod+w5KlHm7l3TvSegIphLSCyGkzRVcAsS8xrEdMJ
         T1GFhICHp3C/AUEigNJ3Fzx6y6llTihVgAMEOzbhT8/KFErh7j/midPaS/uyO61XNJ87
         mX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795870048; x=1796474848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Neleil5nC8s9bt0MpU40WqwbR7w+O9HixUWBXPDe1yo=;
        b=He0DZgvwWFm1IKVVfDq/bjkAQfruTaEvS2O/vwv7UUPQh0xKJnCC0oHpV0dulZtsRg
         l/dEjGrwLBJLSeGQ4VXswbrtUJx+MUheUlCdQxd/4rNyZ6sheTyLFnIntNjuKBFb7S5b
         z23N7KLOKMBTN/8ZJrB1MxsDnl4bO3jombdZZiukKh00Jb7o8odZ/k3XYd61+x3YEPpx
         qlAlPzGoe4ngqjQiJZ4V+KRhiU1wqVT6W/w/2Hqodi165OoPDvw2cTFrElQs+bBmYdAN
         maZGg/LVTCengsyUKxK9QCNySrKAVB6PD6Z4hSsdg2c+9QwRrv8WeJjSdCul2SNgxEk0
         o82w==
X-Forwarded-Encrypted: i=1; AL+hErFNrHDiaIQqNAPg0Pb7goVeFcA/n/Zn0pv7KxMuqe82Fa00ud8GRA/MW+QER9nijfqB6kWlWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DAwIsG8DFMwT+gi8IyxAQMQeDt0YvGvN6wKFXQskG7zGGA9W7
	FuAUlvCqgAKziwq+HS56HCKco/M8yJXhOvQoGqjnqLIi+S850gzKVMMCrhaEsspmK7EortCOh9Q
	yUKCQQllt/HR1vgkQ7oCLt7IPXpEUMvo=
X-Gm-Gg: AZFdTZeyL1Tp4uUaveBIWJXko7lijhh2OsxeahdZQ7jDnO2wdj0vbd5rBMuYsecIFjq
	C4GjHikDAcsOH565psiNyM3KgazLQy8qbSZSJgfH4r8ChpWjIDgEMyF78WE6Rn9xlfXgZ+2uWyy
	Sc3x0Bz4W5kFc3OVleNBnjigaE/AtgGmLSR3R+EcFXIf5vai4X9VnEuP3h8E4ca9qhN9g0lmCte
	KiCD3D2W9eGVKAzWW5pzmYpmCOeL+ERQY4BLX/8YAZ+yeemQ5FbhUB9ruB2vpqxEOCar1BoetiS
	se1R0sZKnmO7n+ln32CwtqowwKn/hjD52Rk/TYGNrTX1yVLVQ4QoYxK799FODkxMbsHWejlqx8r
	9ybwimGPOgn+Ka9B3hTOj7mHBVRLbpyAsz+SHAjYHUtBk14VN+TQiEywKcQBlk2zvRyOIt1rtKX
	h7IlZ/VomDEZQkabl+vZXRIBdEkfU5gU6QVC3dOOFN
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb88817d91mr585296145e9.23.1795870047116; Sat, 28 Nov 2026
 04:47:27 -0800 (PST)
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
 <20261124-mglru-fg-v6-8-8ffea39934a6@tencent.com> <e85a2666-9722-420b-9a60-9d4251fc3d4c@kernel.org>
 <awa30hwg6x82REoo@KASONG-MC4> <8ec3f3e2-5d3a-4bed-a571-88f7ba473b00@linux.dev>
 <CAMgjq7Ayu9H85wurRAUdmXEPWYi9BdLJW13BhK+LMYoBX_7fuw@mail.gmail.com>
 <CAMgjq7DwCNbke2G25Bxfj3bi5aRp3_qkGeYmCTGVGv+Y5XzKTw@mail.gmail.com>
 <60e890bf-d5c4-44db-9f90-ae7970b5de32@linux.dev> <CAMgjq7B9r17gQrOfxffRBiTSepitThjLAUbnraFFjze35t2P6w@mail.gmail.com>
In-Reply-To: <CAMgjq7B9r17gQrOfxffRBiTSepitThjLAUbnraFFjze35t2P6w@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 28 Nov 2026 20:47:14 +0800
X-Gm-Features: Aa3M54oCldtT2Qc6Xyokk6e6N_BkN7eNxmqD5B8ZoTIPwfqT_iCVOdBBMSKp3p8
Message-ID: <CAN_Opa-fUhr5cFDP8vr_47Zb3WOUnSX03LQyNo5c1uQtpyfBHw@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count
 a generic API
To: Kairui Song <ryncsn@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ridong Chen <ridong.chen@linux.dev>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Nico Pache <nico.pache@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
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
	Tal Zussman <tz2294@columbia.edu>, Xiang Liu <liuxiang.277@bytedance.com>, 
	Ehab Ababneh <ehab.ababneh@intel.com>, Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>, 
	Lian Wang <lianux.mm@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Hui Zhu <hui.zhu@linux.dev>, Maxim Muzafarov <maxmuzaf@gmail.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-doc@vger.kernel.org, 
	Tianyi Chen <hi@tychen.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 3:41=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Nov 27, 2026 at 11:33=E2=80=AFAM Ridong Chen <ridong.chen@linux.d=
ev> wrote:
> > Thinking about it more, the header move is not urgent, while this
> > series has been iterated for a long time and fixes real problems, e.g.
> > the swappiness 200 regression you mentioned. Making it depend on a
> > code shuffle would only delay it.
>
> I also prefer to land the FG series first. It's not just a feature &
> optimization, it covers several "bug"-level issues for MGLRU and fixes
> regressions, which are hard to solve without a rework like this.
>

I'd also like to see FG go in first, with the header split as a
follow-up.

Thanks,
Kunwu

> > So if David doesn't object, I would suggest landing MGLRU-FG first,
> > and doing the mm_inline.h split as a follow-up on top of it. That also
> > avoids rebasing this large series onto a moving header. I am happy to
> > work on the follow-up then, keeping the folio refs helpers in a public
> > header for the fs users as you said.
>
> Let's see how others think about this :)
>
> > David, would that work for you?
> >
> > --
> > Best regards
> > Ridong
> >
