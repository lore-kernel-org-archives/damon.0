Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AEB1448E0;
	Thu, 17 Sep 2026 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608269; cv=none; b=CgQfI2yyF4UVXA8nMjlx53V2hiTJUU9E6Krfp1Nd6NOkSSBBKPaTIMqMiYX9zwkwXmCYVtLNF6JIrZ+6qk8JQQb08JYS1BWWCL5Dxvj9/sVAL8eoIz4OEciUyP8uKgiPQPray4Fc8q8NNurNyP9V+bTCQxALqh0QRE75cZPUBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608269; c=relaxed/simple;
	bh=UC68QhQcRLaMGB8I8HwQemwmUPJCvrWhVtPioeeqyJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN0fQNnemKP1vmGTT/tdrP9zHZyv2uC3WjDRx8DItj8TVhTPsiE02uyaBNOcflc0tom34mf5Akc89U7Kff0ldl1t0vuTlsIKVUEgHZXMLHjlGz2MhyzQBH/qBtTG0HLJucNg3NdmbIXcfyPuYGVo7jhz1Cs4QFqm0/m6SU7mk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlX87D/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlX87D/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BC61F000FF;
	Thu, 17 Sep 2026 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608268;
	bh=lZ1/JqShDzbJ7IZu7QOMEIySEk70KUHs+UhoEK32jik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IlX87D/Lq6R17YTQTyg93CU3XzxNg0LyM3R516eJBKICYpiceSdQBusGt9JxbwAEY
	 Oetopq4JPfNlc51yws7g3VFOllGU7RnvGvMJ/IDBbvF0s1NwRFdxsHETeTVJwcPfz4
	 kBf7PsyHKeql9NIFUHUuzLd1iVk/zA2+RDkeRcpVToRyKEQRgo4L+KHWhMbocTLpwP
	 iZLmKnR0prC5s0ikktVP/0z/7YoHQquIEdNsZ53gQRgE5ooCJnRNHiJeW8QTXZzCQx
	 jnjAhSzs4eBYFKatCXzMxLp0tr9uMUlNhdNx+YiOZx09TPEy72jGOXhM4pcmoirpqC
	 dbtTtVxXSbeBg==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: charge only the part of a region the filter left
Date: Wed, 16 Sep 2026 18:24:19 -0700
Message-ID: <20260917012420.101087-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917003553.2465523-2-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 09:35:52 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> An address range DAMOS filter that partially overlaps a monitoring
> region splits the region at the filter boundary, so the scheme action is
> applied to only one side of it.  damos_apply_scheme() reads the region
> size once on entry, before damos_core_filter_out() performs that split.
> 
> The quota charge and the statistics update therefore account for the
> region as it was before the trim.  schemes/<S>/stats/sz_tried counts
> memory the filter excluded, which Documentation/mm/damon/design.rst says
> is not counted as tried, and with quotas/bytes set the excluded part is
> charged against the budget, throttling the scheme to a fraction of what
> was configured.

The user impact is that DAMOS could work unexpectedly slow, due to over-charged
quota.  Also DAMOS stat could be confusing.  No critical events such as crashes
or leask happen.

If above is not incorrect, I will add that to the commit message when I add
this patch to damon/next tree.  Let me know if anything is incorrect.

> 
> Re-read the region size after the core filters have run.

Thank you for finding and fixing this bug!

> 
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
