Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC328033B
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440939; cv=none; b=bj6vGRW7rd44NJ/uqwP7EGv9NXekbY2YEImPbWXnk9K+3JEZ8W3yy72VR83p1w4gVT/ItQW/j5pwkcRpUA1o/rBfqWF19eCE6pqd3zdHLA6mI4L82l8zq49MteSmEUDB29F7zmJMOb3hFvPMC4KU48Mbr2YaDg+sNX+luQ8nI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440939; c=relaxed/simple;
	bh=136EN4ADhppTSjdnfWdxiOC89bNO775Gf/FZTu/DZWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyI8o+CN5eR9bCJujp/RMTS8n1cEaFky1O8wZLkWSMAEEiERVfQR0/RN7boJzfl1bywJsHszVGDAB/AqfCBZxfOGWxy8kjlxzwlsrqfH/2NqXZdGuASheJD/sjkYuznMJzxxW0/t0FadDEyYJIS20nG2LwbLqddEtp82XbTiIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1pZpgbJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1pZpgbJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso19935355ad.2
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 19:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789440937; x=1790045737; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rONIJ4rFKQNYtEnPGvXxCw20wCu4aJ48o2Acfvenuc=;
        b=T1pZpgbJerns3T9LZOV/KlyAQfPnJl12crW4oiVcj5u3MjR6WnPvhc2rrN59nfqnMZ
         HqOz4uSTmYcQBKALMpHvIAz8Rk3BnMAy11w98NF6csyD+FhsEOPDGUsnpl85vnF31t6D
         PuqfQ1mUkDhyJakWOKqAl4FEUFgDh8BLAoGlurFgnyFyU8xqrJMYkrMPYgBCmvUK/ze9
         YF/rEL2kv97gJBd9zKQR/+HTF0tXl2pKvtW1JvpyfJ20ZPwVI7v1cD2RHtNI9mrKlc6V
         zUtNLW5dTCUinU5bsejmxA/WS52Qa0dnIC3Lyenusqq3c66oKcDxgAc0bUWudgAc9bCv
         M7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789440937; x=1790045737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rONIJ4rFKQNYtEnPGvXxCw20wCu4aJ48o2Acfvenuc=;
        b=tWRB11KkHlW/bvCX7rQOsW3CKtyHPaBoD2E62FTHqNN/hek7Ig73drEFiNef+D0k7P
         J0KIXeHxj/ENsAXCh6+GQtW14N1qUyA6llzasSB37aV2scWTvVBZ8svfwFMUFNOHkP8H
         K7wm+6S8lhvEmLC21J8miHRJF2KRoJ2QQ247FZQgndlQWARVhMXVJsuE1oKQl9Xbqeqw
         4b4RaK5Sor5uaB44VfQ3aYET0we2T01H+NG7nL88EQ38EH/tzG61EIi5/MogrUV2SwM8
         de5xVDWB2Nkumbz7JlrVwhexfV1fMNalwR8V4KXmwY1L7ZDxhfnAkZ7NJMt+xBmzq+KZ
         ICMg==
X-Forwarded-Encrypted: i=1; AKwUvBycER1wnqIWQRVBW7qg784pPh+oETcP2GUBO1pWlLWEWETAmhgvZ0SOguTJpHxxQDokC2DcGA==@lists.linux.dev
X-Gm-Message-State: AFuF++mDhWEUVt01dCQPZMhqy7xbQCvsfRsmwqp8f8IjyLskiyv/MAQL
	1m7BSgpykbrwuHsjabyiM0Uy++rZb+rtJftuRW0cOuwLLDIRulzyv2wd
X-Gm-Gg: AYBFou2OhV66oZZIRt7ljcxue/kbXIAKA48ijnBL90BfxSRP0iDost6cj4vnL+z+RgJ
	vBoH59ltie8wofyghaPMqMDpRGQH4rQ7LRdKjZilE+ZJ9FjeMIaPqVjiE8npXBSsLT4GQT6cGbK
	bpxdfeOr8lpAUvzewDOG4sTbsRrOA7VYNbyr/DdFsFvv86EGF39Nvcdn9tCux84/nQ2bcV3Upg3
	MHVNE0DvFhm8akjmuQH7GwD+9Oi2msg++jkrcSSEqBBod7Sr/sm3bl4t0+71nepNeNwCV4FLkB3
	SRo4aXFxDGieLyjSXX3xQuoF002Li/4pQXjmHyWxCLSm/5iUiDPPJVgz5vNdgjd/apzmD1qGeXD
	SaWfuctK6is32XsJJlYbpEdHLlXm61K78FsesXUzED9UMOSoBkUCvipwDj1dlFHAu8xvG39O7yT
	ySE93Ga83yqp07cGuZsYvAggGlelCsw0lWqwfLOfKrLuTrDnltwaHIBA/1RjZeIcB0VdOwQWahP
	0YIYJKBzdZI3Ddiz/g4e2AdQZve49DySa9U2+7T
X-Received: by 2002:a17:903:1ac6:b0:2da:e634:370e with SMTP id d9443c01a7336-2dd6c6eb5f4mr114307505ad.14.1789440937165;
        Mon, 14 Sep 2026 19:55:37 -0700 (PDT)
Received: from localhost.localdomain (vmi2317699.contaboserver.net. [85.239.239.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb7720sm57859485ad.37.2026.09.14.19.55.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:55:36 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>,
	sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: Re: [RFC PATCH v2 0/9] mm/damon: hardware-sampled access reports
Date: Tue, 15 Sep 2026 10:54:51 +0800
Message-ID: <20260915025514.2434-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lian Wang (ProcessMission)" <lianux.mm@gmail.com>

Hi Ravi and SJ,

Thank you for sharing this work.  The report path looks potentially useful
for a DAMON observation-granularity problem that we are investigating.

The scenario originated from an issue reported by SXF, and we are planning to
share and discuss it at LPC.  We have now reproduced the underlying observation
difference on both a local PC and an x86 server.  The server run below is our
larger, controlled reproduction.

Our test monitors a QEMU process whose guest memory is backed by a shared
tmpfs file.  The guest repeatedly writes one 4 KiB page in every 2 MiB range
of a resident 48 GiB data set.  The unique 4 KiB spatial coverage of one sweep
is about 96 MiB, or 0.195% of that data set.

Using vaddr DAMON with a 500 ms sampling interval, 20 second aggregation
interval, and 500--2000 regions, two opposite-order runs reported a mean hot
ratio of 1.751% without shmem PMD mappings and 75.836% with them.  A control
that writes the full 2 MiB ranges reported 75.366% with PMD mappings.  Hence,
in this workload the current observation does not distinguish spatially sparse
4 KiB activity from dense activity once the large mappings are present.

We are testing existing DAMON strategy mitigations first.  As a next step, we
plan to replay recorded access addresses through the report/probe decision
path, independently of a live PMU, and check whether DAMOS can distinguish the
sparse and dense cases.  In that experiment, raw report frequency and unique
4 KiB spatial coverage will remain separate quantities; lack of reports will
remain unknown when source coverage or loss is insufficient.

If the report evidence makes the decision reliable, the response we want to
evaluate is an internal, bounded PMD mapping demotion (splitting the mapping
while retaining the underlying THP folio), rather than exposing physical folio
split as a DAMOS action.  We will first keep the response stat-only and archive
the would-act ranges.  After the replay result is repeatable, we can replace
the replay producer with an appropriate hardware source and share the results.

This seems like a useful consumer experiment for the report interface, even if
the vaddr and optimized transport parts belong to the later phase.  Please let
us know if this direction conflicts with the intended report semantics.

We will share the strategy, replay, and mapping-decision results once they are
repeatable.  We are also reviewing and testing this series, and will follow up
with the appropriate tag(s) for the exact revision if that work justifies them.

Thanks,
Lian

On Thu, 10 Sep 2026 10:16:14 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> This series lets DAMON take its access information from a hardware sampler
> instead of from a page-table scan, and lets a scheme's score be weighted by what
> that sampler reported.

Sent using hkml (https://github.com/sjp38/hackermail)
