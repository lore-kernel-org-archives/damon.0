Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795808514;
	b=tGRJjpFYJoEz8Bf5GYRHMMQfabbD37M47wNfPAPOBZKXDXP97PBAF1sF76JIq/f3eoDD
	 E8wLfw62OHO5oMVN3AL4jvsUV+mP1qGmTJ75qOfwDdwetmwNfGeJ6M0jgVn3rPWFLBQl/
	 N8wMXVTzU3tncNOh84VrB6lfJytYfdY9uzu2fx+BnqDtK+t7OzmpAUu1IA6qCQ/QRIDjF
	 So20Wx89mILbNmvx/F44WDzxC6F6I+Qu2cxoBwBnUuKBiy96W3AOMn/olBJdNdS9b3CQI
	 XR8J/tGoQ0jyrDmfmRBVAoPtdgbF7xk2sMl3lvVMmUhXAz20M4ibwewE57Q2oHxymmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795808514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hh8eaml/yBFyozdjvUyyf0twA7kkmRnJygaFP+0NC2E=;
	b=gwi92HMJkUTFoyhFFh5+vvwvxFcHS4UzyRvHJZ+/JuWmfMA8hAb/wxKYyTFqGr0YjqMj
	 03zXLKRHrvsvcli4n/EVKibLzZXksQ/4vLv0PEux4YTkA00Xdanza7+yUhWxMXhZkcHHL
	 TPsvGX40YLDIj2zY+uBQQIUP+kY1PaUUTRJnuBOJeUOZwkCpjwhwXN0XItFq1+FGPrcPO
	 j+tr8GR8KYBBoxUQyYGpwWX0qVbV6ZLHW1y448+TyJh204gA8u5hoeLWgA8iAJ6jgmoKS
	 izAQXefuWwokORyBKopkrzsWHCP4kvdEh2Itdcw829yP/VTHqA10va68OOKqcfKmOrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1n9MMHW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0A606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 19:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1n9MMHW
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c51bf011392so357420966b.3
        for <damon@lists.linux.dev>; Fri, 27 Nov 2026 11:41:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795808512; cv=none;
        d=google.com; s=arc-20260327;
        b=FF9oVdkCl3hnUdiVHtrqrUexRYgxGGEzPESXYqB5lvTaelTtBa9nIgWRKvOhV3h+Y1
         N4fjA3dBJdpdR3PiEf9hLlxTWWq0O85ZuSngfmptzqaZ/ctxw6ADkmAAWSOsM0qY5aqN
         R533PbXXlOAz/3xxMKjQ7XeuFhUnFWZD7CroUQ50CJeq5ShzxoSHBi6uhQiLBdZzr5q1
         5NOqQ6Dfq/cA77mAvPfaVA/7BpOuoRUdZ6RlLNWC1dDyIUbygmMKXmPPTQK1uuubOTBf
         oNtsYp4Ox4dRLqOrYkWJcgBUWxc1Z1zT2MT4u/l8w2vLMTfLEsJmqZ1N1fi+ucjr/8Wd
         jj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hh8eaml/yBFyozdjvUyyf0twA7kkmRnJygaFP+0NC2E=;
        fh=N5DZh4FwS4Ae+JN9qwjJoohFxt17t84Tpaxcu67Pbgs=;
        b=UI7fEQkpHhuN0ipObiweiMWybbUyP/AAxZB/a2gMMI5g/f2tdDcI2DTj7M4ZHytFuf
         ezatrcowl9Q1RQzGv10nEnJImE76iwQICkk3RJgZ1zFRavApXgyCXVhoovWkwvTbB7ro
         XwrUqDO0eOZklBojL7Cl7T1usp8M8/aoTzVTjjsjUdLnXMutfqJLzV/pSrTOdaQSuOa7
         yK11kXt6IEXo11QBLnazeiVMesS9JfHcOPruCJ8UP13PmQHLVlgldZVqftj5uRiptkb6
         7wTMzQqR5wexGrfGDZCMPrpZSTWm35Vn/r6/38HcucW7FaKt5NHa+489Uay8MId9cFIU
         uEyQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795808512; x=1796413312; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hh8eaml/yBFyozdjvUyyf0twA7kkmRnJygaFP+0NC2E=;
        b=K1n9MMHW9+k/eSTK8C7glZafmU+tDMYFYvesvIIdVkmLVtwvgrJvsX+Hld9GOKVgKe
         lXqtU7VFTk7tPmw2KMlV3GEGmbeO+nIrrAmn/MQZet9ttZjK/r9a5dhN6gtwuJJiP5IY
         J1is3+gkmqrOTrrvYrHaPQ/4ENQNgCQdsITe644JlneQ05IaQO9NJlbLU1J3GzBaJk10
         0AOXClXS5KVJFIoX2V/DDalGlCZ2h7el1kXkrXBpUPNu9ylIcD17/jRmRNmU2g6ESxlk
         71Zz8WHfPTN5sodPIwkisgrucH2tIfw7OimeMS9Zn5bfvQaA3pejcZzcIFWh3WoE/dxa
         5jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795808512; x=1796413312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh8eaml/yBFyozdjvUyyf0twA7kkmRnJygaFP+0NC2E=;
        b=lTCGmjxAU4z+zzU6vrKOkJ4fNRiomx1FhQohL3MD/EsSi8NPkY4NMED6RUMESkDuLn
         tbD9P+9Bb2fBCpXUMclk1Fay9IPqP8JXyf6UfrQmkUSD4HzRGDnED2+6K9vyZ+GJ1ZgQ
         CLkIV+nI5kdneEseNL6GbMgRdWed4H/Djvo8kARHyq0bKY4EYIeo0wP1twMWrls5OGJ6
         53f6XhzW2tA+HverkFvz3IskrNNY3s1c9NPLJ5abQxRniOvubC7atJBI4avrO73OMb4Q
         +66vQGIaxg0Yk+2VYaicLJXfUk8FPYWgzHnOAv4C08+ZfkHrZmnwG7f1uQD4xcurOTx5
         1aEA==
X-Forwarded-Encrypted: i=1; AL+hErEL0uh65GXR9UlKxsNZV1wivPj4vT2P0Yumw7z51Roj/EkGMe86gPspk66Ftv7NEbp5YDUbZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/17G+91DFse3HRu4ReTgNS0G9jjZdVyAC6K0Grbpr4O7iURMPu
	6I/Dognke11KiThNt5w9ixTDX5KOfrraDpNeBCZwC3WHfsWMt1GibSni2xmaHe+g4gQJewaClBQ
	amKa5C423L8DKbjK1m5MpHHqmVQirLSo=
X-Gm-Gg: AZFdTZcmI5cXs46C6FdtzYThpFS9cFNRyB9btrjEoSwborGlaOp9Yn2tNAZfCQPqWMd
	tUtyQPgB2DhRenRYz36mDPdv6XD+xgBJBW2C/9+m6ZDM6q3Pho6fOinJFrhrw6nrYqdKBaixTFE
	M1lSp8t2Z5jFFJZqf13hZNnh8nESRP3WBa0jogU9CsznU/FhObOJqmZkRrEe5jSTU2q5FG+WYTB
	i7HamPrIn6nafZksz8UusQkqEpurRjPx3RdKO5d5lUMmZXFVpBnS19fjkGy13t8Tk0QLBObjEbs
	H7ir1at0g86Uka3qLZudgBhUWlIdrWsrTf9dx7kNsKKvoeSWKkDFnuVoajGPZ0q6pbCgVgCVokb
	8U2T/qaUJH4/h7He+CnbqJt38T5mBWicRyG3YaKtRF2XjEnZ7TT+pONgRuVxtTqy/m/bFog==
X-Received: by 2002:a17:907:7b9b:b0:c4d:3208:5781 with SMTP id
 a640c23a62f3a-c513a4b1c1fmr2320437166b.1.1795808512384; Fri, 27 Nov 2026
 11:41:52 -0800 (PST)
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
 <CAMgjq7DwCNbke2G25Bxfj3bi5aRp3_qkGeYmCTGVGv+Y5XzKTw@mail.gmail.com> <60e890bf-d5c4-44db-9f90-ae7970b5de32@linux.dev>
In-Reply-To: <60e890bf-d5c4-44db-9f90-ae7970b5de32@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 28 Nov 2026 03:41:16 +0800
X-Gm-Features: Aa3M54q0GwKlgENV-fDrHnc1e8ZIFsqPaG2vdLKK-3H09a0TbqTlTAM4SzLkpj0
Message-ID: <CAMgjq7B9r17gQrOfxffRBiTSepitThjLAUbnraFFjze35t2P6w@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] mm/mglru: make folio lru referenced times count
 a generic API
To: "David Hildenbrand (Arm)" <david@kernel.org>, Ridong Chen <ridong.chen@linux.dev>
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
	damon@lists.linux.dev, linux-doc@vger.kernel.org, Tianyi Chen <hi@tychen.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 11:33=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev=
> wrote:
> Thinking about it more, the header move is not urgent, while this
> series has been iterated for a long time and fixes real problems, e.g.
> the swappiness 200 regression you mentioned. Making it depend on a
> code shuffle would only delay it.

I also prefer to land the FG series first. It's not just a feature &
optimization, it covers several "bug"-level issues for MGLRU and fixes
regressions, which are hard to solve without a rework like this.

> So if David doesn't object, I would suggest landing MGLRU-FG first,
> and doing the mm_inline.h split as a follow-up on top of it. That also
> avoids rebasing this large series onto a moving header. I am happy to
> work on the follow-up then, keeping the folio refs helpers in a public
> header for the fs users as you said.

Let's see how others think about this :)

> David, would that work for you?
>
> --
> Best regards
> Ridong
>
