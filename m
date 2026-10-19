Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37545FFB0
	for <damon@lists.linux.dev>; Mon, 19 Oct 2026 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792384116; cv=none; b=dH4sW/bWlazhglVEja+x3UfMN6w4IWsu3W/4D6tLG8hSknuErbVoKyGyhcf2tBru3f7w5kXw+vIGdp+5yPm4G5cwsiNA+o15exMl4q/8GexxkoG9OWENUwIGKX1ohaPG13cQzCI6zQJ8OF2S0vEyfWLb6CMLgOCzfEd5Im/5ilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792384116; c=relaxed/simple;
	bh=nFRq5O2deBLCzLOM35tdkBF3irBTwZmIV/qWpwGNN0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs33L84Aqf/WzjMlJDFO1mW1LjrLb0we0SQD+eHAFE2p9xJyRD6i1Pt5LzhhLk48UthXqiuhKeRelnwV1MFXQCq7iF7B5EU4IOgQ8S7Z00O58lg+3nE8QfFzsGyc3L5rkr8T0CLCmsvYUwE4fhUXBzmCvmVisS9ewFiYEQkIllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX3qmNy8; arc=none smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX3qmNy8"
Received: by mail-yx2-f1.google.com with SMTP id 956f58d0204a3-679f050b6feso39496d50.1
        for <damon@lists.linux.dev>; Sun, 18 Oct 2026 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792384104; x=1792988904; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KPEnziyqohgCiyllOGpLsBcdgNJdfasBLYSYKWDG7f0=;
        b=cX3qmNy8PmXqQNWKOThTetoSbAbyJlfeJs9m6bWbfG8iPK0ln+YWFpLxLrPQDYxbia
         euK9GTl/uK8wtlA0mHwahxqUrlWpSDAhKm3qf4xiPa06EvK2YM3eFwd/8Lcur1YOaOKO
         r388wJ8b5r1BGTXX+d6BUtGm8HDTSO9QqOkfxZhbIYgxT4T+7F1N3X3hm962nqfFYcgJ
         8e29qYR8lv7E7PhYIYdbMebOGswvGmE039pH1K30j0q1fBTCCw4pUf4U2Vfo31AdQDLp
         WxRBE5zsvRdd+eMO6NO8fIRM64KZz5jaIC9/zw8/SgyWNxayxAQsJ+j/+mH8+Z40ATxl
         GMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792384104; x=1792988904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPEnziyqohgCiyllOGpLsBcdgNJdfasBLYSYKWDG7f0=;
        b=E32TLq621hhaWKkIIXg2zj1EO/h7f8aH4PiLkZIMeFTM4tUgjaT8SNd1iWPxy2dlCw
         hmp7DSLdV5Gl8jNIlJvNJEH8BvC0gp3T/od/lksfIqbVnejqUQ42Zx27n0IxBVFZdkgl
         buw9b8e7PfumXNd4Y/48Wki/ZIl7eeV/oua32LjPs8ksxAKiGiBIycoOS8tvwpYzIJkg
         e2DqmcBa15A7gjeb8G73+GqHGRRcOly1LNY+gaPkCJ/80zwFQOHvz8sJr70yawqAtM7a
         4pAO212zvAiBMh3sVyq9mBHHPkxsRwwLDL8KTXeeY0+S+DmlJPy4JwVKAXkGKLfeSXLF
         BsuQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/FW2SE0YMrjdbWRI61Lru0JES+2ldP/jT0xrdhToIhjGJunWo1Y41Bod3rPsigwhkhn/2ZQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLCx2E/U9nZYGQSFW+8RxLOKTVCQDeZJs60w6yrEj3WAk90qSvW
	1zTxvQRibkS49EJp2K2V6mOhXeqndmnBR/waKDX3h2oaAw24+A7Tvac=
X-Gm-Gg: AYBFou2KzWgGrvgFRfJI68Wt8W78/r00W5/H6hrrwdCtipzebY5hnJwOPTxcEDgWlgN
	6yJPxyWx7h39KeKI2nROFb6XZq4xxcFi0LDxbtUrZ78Cl8IStYv3X7iNSSD7vVbbLgRjTIFzYAw
	R49TaeYoisY50vehtkqs4CLfZx2+TjeakEUCdx7/oocLJPk/5CBUpNQjHLIu8ehaicOmLtBCkmj
	Kvd2kLMVGTZziklsiYDvIwS6f/3P9JW84V5WvzCrsEaiItLb+QTGn/FtCnpNF/t1+0SCBAgpgKK
	eBimn9gmPI+NAumzhTQrps35FZv/T+pzaDeGEs/FKHNRNaCF9ky9LpY8Rf5chtDx5WWAh0WB/Mo
	GThPkdscmIgOqAR1MxZbKjgUMHuEaBPfENt3viJcULj3tsw3avtq6bxpGSeq7A29X5aFujBBi0r
	ikwu9FnOOqfeDQ8lUdN+3e2hSS+Ts6QW1zbLFhJv64/Tk0IJWsofDge22rie71rxMbjNb5urPFA
	XwTTX1S5yQoseNS0M7DrN/Uq2oKT0MvoQvB6VPgBUror3i1xpnuKtvSchtAwXViYo00NX8+2WAJ
	DQ51/ecYzR7+c2tR2w==
X-Received: by 2002:a05:690c:4346:b0:8a8:8f62:eb3 with SMTP id 00721157ae682-8b0f21d7fc0mr14428137b3.62.1792384103712;
        Sun, 18 Oct 2026 21:28:23 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4577:1050:ec89:21db:40a3:896])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e591c51bsm35347307b3.34.2026.10.18.21.28.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 21:28:22 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: aethernet65535@gmail.com
Cc: ravis.opensrc@gmail.com,
	ajayjoshi@micron.com,
	akinobu.mita@gmail.com,
	akpm@linux-foundation.org,
	bijan311@gmail.com,
	corbet@lwn.net,
	damon@lists.linux.dev,
	gourry@gourry.net,
	honggyu.kim@sk.com,
	jic23@kernel.org,
	kunwu.chan@linux.dev,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rientjes@google.com,
	sj@kernel.org,
	weixugc@google.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH v4 0/9] mm/damon: hardware-sampled access reports
Date: Sun, 18 Oct 2026 21:28:19 -0700
Message-ID: <20261019042819.1937-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261017211613.16456-2-aethernet65535@gmail.com>
References: <20261017211613.16456-2-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rui Yan,

On Sun, 18 Oct 2026 05:16:13 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> On Sat, 17 Oct 2026 15:11:18 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
[...]
> > Later, I noticed that about 10 minutes after starting DAMON, the 'seen'
> > stopped increasing:
[...]
> I found that if I enable the kernel NMI watchdog, this issue can be
> fixed.  So I think this is not issue of this patch.  What do you think?

Thanks for testing the series!

Agreed, this is an AMD IBS / x86 NMI quirk rather than an issue in this
patchset.

On AMD IBS, when a counter overflows it sets IbsOpVal in
MSR_AMD64_IBSOPCTL, stops counting, and sends a single edge-triggered
NMI.  If that NMI edge is lost (e.g., across C-state transitions),
IbsOpVal stays set and the counter remains frozen on that CPU until
perf_ibs_handle_irq() clears it and re-arms the MSR.  That also explains
why the sample count in your graph stepped down gradually over time
(100k -> 36k -> 18k -> 4k -> 0), as individual CPUs got stuck one by
one.  When the NMI watchdog is enabled, its periodic NMI walks all
NMI_LOCAL handlers (including perf_ibs_nmi_handler()), which spots the
pending IbsOpVal bit and re-arms IBS.

For ibs_op, a larger period such as sample_period=262144 (as used in the
cover letter) or setting config=0x80000 (cnt_ctl=1, dispatched micro-ops
instead of clock cycles) also helps reduce the NMI rate on the CPU.

Also, if it helps for testing, the damo branch in the cover letter [1]
already has sysfs read/write support for the perf_event prep attributes
(commit 1178ccb) and tools/damon_tier_gen.py for generating IBS/PEBS
configs.  Your probe_hits_wsum support in 'damo report access' on your
branch is a nice addition as well.

[1] https://github.com/ravis-opensrc/damo/tree/damo/auto-tier-bw-2026-10-04

Thanks,
Ravi
