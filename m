Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AA2BEFEF;
	Wed, 30 Sep 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795432; cv=none; b=LLJ6QEpgR+DpcfwH9xT0PUnuqc+l5B1AMzLFkwkbxgdsnkcZMho2TOCQ7QD7HDHKa1IGwV5sXpnVnqc3VNqJc9e4W7T+7njSR6a2d4SYAh8eQKIGD238e7nTzLQT/i4I13zS3xrnSMz2pgB+dn2LcmexHz1uzYwVy5iXohDKx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795432; c=relaxed/simple;
	bh=sUQNTp4e7f4KUZW7bCs4yBW2t5rebzPP/5OYjggKXts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr3nTLwgmJmxCLMeNXtkWaHyBt9nOKjEAuOTbDt5ruSNvfSVbKq0Me0p67lbjh9f/UQHYz+9OA11NbV574QJyH0QA0LQ1udKOPxFtrscj439dTL6Nlgb1k8p9COYeLvobsm+m/N+4ZJj1IZYF1zD9/83lKUuVOFMCPmm4rFG/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jryTlAE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jryTlAE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7437F1F000FF;
	Wed, 30 Sep 2026 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795431;
	bh=JltDv8XdbdpSf/by89RR6xP1PJpm2X1XeEWjzJovhas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jryTlAE1+zr+dk2a+fn6zp9Z9z/lRA/9fbZ8VZgRfxSj+fJ+CqLidMng10tmNNQSX
	 iYAFCfCHEf+F27CU4Tl2ZYAgstIijr+wKO4it13eS5FogF5wdFFAP5Zq2DCGtbIb4b
	 gk47IJMc1WlZLudHU/+fy+Q7qwwXbB3j/WIqtUSTCvIDvvnVu98S1QqOXzsuA2X6PW
	 oxggy1/V73zYIDXSs8mpdyGWCGEn8Opu2eFQbBsQI6xaHq15RGWTHLDxEHrvj3xYdY
	 wqISdq7usq4bjFFHFxxz+2GZBTR5c4D5Z//5vuJ5X8q7l73DgaBEHTQmztTfbB5UHt
	 poI0r0+gHOOVA==
From: SJ Park <sj@kernel.org>
To: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: fix age_in_sec overflow on 32-bit
Date: Wed, 30 Sep 2026 12:10:25 -0700
Message-ID: <20260930191025.63561-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930115812.138864-1-jaeyeon.lee.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jaeyeon,

On Wed, 30 Sep 2026 13:58:12 +0200 Jaeyeon Lee <jaeyeon.lee.dev@gmail.com> wrote:

> damon_hot_score() calculates the age of a region by multiplying r->age
> and the aggregation interval.  On 32-bit architectures, unsigned long
> is 32 bits, so the multiplication overflows once the age exceeds about
> 4295 seconds.  Then old regions are scored as if they were young.
> 
> Fix it by doing the calculation in 64-bit arithmetic using div_u64().
> Also make age_in_sec u64, so the result is not truncated back to 32
> bits.

Looks reasonable to me.  Thank you for this patch.  I'm thinking about if there
is a simpler and more complete way to fix whole possible 32bit overflow issues,
but that shouldn't be a blocker of this patch.

> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260623011652.1354-1-sj@kernel.org
> 
> Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
> Assisted-by: LLM
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
ping me or Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
