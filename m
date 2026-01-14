Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62367397AD8;
	Wed, 14 Jan 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393827; cv=none; b=ONr3VMlzHwTyQNpXrfbgMBO1QYm2wi4ULGVzAx8FLDe6mmlDjI2axLwoz2sHeAeIMB+urZ/osbOJ561ZJdBSfORyJFZ/6AH5FmAMILnOtgARvL8XK/ZMXv61RFULGITNgiecp1CeynHiPJOZyH72DEmthRk1ex1ZKXSuojYc7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393827; c=relaxed/simple;
	bh=MMcA4evYvQ2r3p1jl0thax0EXbx3CXjrPAGZsnMpdzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MH9qhWfF/RXtc1xA81+G1TS6t3SkLSbWJ+gvjinNRzFxjIprE9fyEKy+p6BIUXCUUdXRcllOqS9QrBc2Bv0Hdm9HPhh6A+bymzqK4uY7WLxwHDkK6j+F9MScn+nk26B3dEL8xXp1NU7er/PKCyq5WTCk5cX83EIVoR5/btjei8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=rU0LOMSt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="rU0LOMSt"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60E0vj3v1639598;
	Wed, 14 Jan 2026 04:30:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=3xx7hVX5a7BDbwvL9Uo4YtUuy/fcXiraO3yJp5fQH2k=; b=rU0LOMSteOlW
	9r7vQKWgxw5heSTb3auWr3qNqJk1h2ypjqE8LWOQO2RLMvwwYDChX/LItDB8Z/wv
	F3d1OiEZ3zvGuRBy2y2yZbrPjxgu99uGutgnQpSMV8Ez6QLGduoSEClZ1vtOFkbO
	Yyjtd31i/YZaYzSNAxLnuYhXG1w79jKl2yt8GhniA9osKWAiav835cY/MgoaefX1
	5JrNFoUnU0RawqV0In39EIsE++gtp1qf1OZAlDuDPYb904Fxd5YgpTiFG1mqJtdu
	xIrC6yPrgVG2dsUuNVoHjpbie/uiARF2HdnU3mFv5rgnCtIFVar8SsoYJx1v9Ck+
	XqZUFfzKuw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bp12ac1ur-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 04:30:18 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 12:30:17 +0000
From: Chris Mason <clm@meta.com>
To: SeongJae Park <sj@kernel.org>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH 01/12] mm/damon/core: introduce nr_snapshots damos stat
Date: Wed, 14 Jan 2026 04:29:56 -0800
Message-ID: <20260114122959.1164957-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-2-sj@kernel.org>
References:
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1v6XLzs9dHS1tuZRU45PQbVeWuBiXluk
X-Proofpoint-GUID: 1v6XLzs9dHS1tuZRU45PQbVeWuBiXluk
X-Authority-Analysis: v=2.4 cv=KcjfcAYD c=1 sm=1 tr=0 ts=69678c5b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=Od8CE_c8tX5E95hOnl0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwMiBTYWx0ZWRfX9d+dKIcMmmue
 KZAqq/ogQtdckoPBnAQgakFwp4xMH0Jrz3NtsWqstVgYJA+NyFXzOqVCNirS+M4xR4rIJWjnlqv
 dbuXIJ2RgEw7TrQJ0PNIizF5skvXiGGxuQUmkahww2UZi1qiOGb3a+QHWRk3zIqvnI9h7FNhmjE
 yn6BZP/2JLh1MXjNjr1xjhcMTKv/gzXSOTbiSTreltZcgo0qZ3ajB3aPSFaJr5wAJYnyXWlu8rQ
 zzaqtDDZ/D6lzauzOPb/FS19qnNnQR2204lYsdZ7MbeVbfNoVfNfNeAPP59ebTFS+OQBR2hyzX6
 LyV82SQA0z1QG29EGpd5n5NMWcn8xluKLtsUPOXy4NebXwP/qa4wbBKvSgR4LtNt07fSQ3aeeC9
 qkZltodZ42JMcjNtIXmiL3AVIF+EzcLYgn2xcmKFynotQksrN5Fu+mlmFgI5vgtTt6a5YhEKE3I
 F7VDvpmRClolCnMnDog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01

On Tue, 16 Dec 2025 00:01:14 -0800 SeongJae Park <sj@kernel.org> wrote:

> DAMON generates monitoring results snapshots for every sampling
> interval.  DAMOS applies given schemes on the regions of the snapshots,
> for every apply interval of the scheme.
> 
> DAMOS stat informs a given scheme has tried to how many memory entities
> and applied, in the region and byte level.  In some use cases including
> user-space oriented tuning and investigations, it is useful to know that
> in the DAMON-snapshot level.  Introduce a new stat, namely nr_snapshots
> for DAMON core API callers.

Hi everyone,

I ran mm-new through the AI review prompts and this one was flagged:

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -157,6 +157,12 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
>  	damon_free_region(r);
>  }
>
> +static bool damon_is_last_region(struct damon_region *r,
> +		struct damon_target *t)
> +{
> +	return list_is_last(&t->regions_list, &r->list);
                           ^^^^^^^^^^^^^^^^  ^^^^^^^^

Are the arguments to list_is_last() swapped here? The kernel's
list_is_last() expects (entry, head) but this passes (head, entry).

Looking at include/linux/list.h:

    static inline int list_is_last(const struct list_head *list,
                                   const struct list_head *head)
    {
        return list->next == head;
    }

The current code checks if t->regions_list.next == &r->list, which will
be true when r is the first region in the list, not the last.

Compare with the existing damon_last_region() in include/linux/damon.h
which correctly uses &t->regions_list as the head:

    static inline struct damon_region *damon_last_region(struct damon_target *t)
    {
        return list_last_entry(&t->regions_list, struct damon_region, list);
    }

Should this be:

    return list_is_last(&r->list, &t->regions_list);

> +}
> +

[ ... ]

> @@ -1978,10 +1984,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,

[ ... ]

> +		if (damon_is_last_region(r, t))
> +			s->stat.nr_snapshots++;

If the list_is_last() arguments are indeed swapped, this will increment
nr_snapshots when processing the first region of each target rather than
the last, causing the stat to be counted once per target instead of once
per complete snapshot.

>  	}
>  }


