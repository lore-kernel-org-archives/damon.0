Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2942BC50;
	Wed, 15 Jul 2026 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074722; cv=none; b=Rko8oUuiva9hV4c28hpBMdf2NWrqxzdxogZ2wRu8viHW9T82tE/nmU26dx4nw1ElXrXaCeaPUO/3Yakle4BHzMRiwv4zaVIzIFRm5tRXSTJaSOcaiAQzT3jOwYC/w/OM1pfnlnCBwUaHtlMN7Jo1ULGauAhf4B5/niFVjDkbm4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074722; c=relaxed/simple;
	bh=q+k2DByBVDKCSqgUAGAdIdGAI1INqoJWMv4/0jbgsRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQcWBkJbiGGUMA/NmtZz1SHkdbTkjmyQEBaP+6Z8yxwb56xe6o49cQ1nBhURa/vhUhCWB6ENKS6AswFRsM94ZkrbSWsoE+tarx39qyySKYeC0Pfvp1zsn0JztPsd1rEqVAp49MnYcnTyET7+Mg8ggF85hQkorduEffF6xYWN/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFPo7Yva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFPo7Yva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D31F000E9;
	Wed, 15 Jul 2026 00:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074720;
	bh=o3HZR7bEntVs/K50pnsd0JT6YW8Jt0IbF3Prw+PD4Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFPo7YvamTYKlHjwOtyNaUSjis67MXYZWdKFSkGSx6G4bObncfvdmjEsa5FWh/OPY
	 Trt2dtUHJuvE5gmZRgxhooyhUEB5Zat/ZY79a4BAZcYMQ1Uqw1cZNhmxr6PTeN4ovI
	 G30gsVPCdgBoLy3Kt1h45sUaQuSCc9eAy95MrjUG5CtTfZ+2TiIxwVISb0jkrwBz0r
	 wW1SvgaLHIQsBc/9CYB72kUls6ZRPDWnO3wuFxpI3+jXMnAoGVRVo2mvlZKhSlMUDY
	 EnCImW0pkEP0pz07eCRqFr5nbSapBGAVCNnV0U24UkvSMRJJXw1sHnY9hO8ilNYphP
	 NJQko7jkqNwHw==
From: SJ Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SJ Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] mm/damon: Introduce a huge page collapsing mechanism using auto tuning
Date: Tue, 14 Jul 2026 17:18:32 -0700
Message-ID: <20260715001832.106007-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714150116.382521-1-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Asier,

On Tue, 14 Jul 2026 15:01:13 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Overview
> ========
> 
> This patch set introduces a new autotuning which allows to collapse
> hot regions into hugepages.

I sincerely appreciate your continued work on this.  But, I have to say I'm
holding review of this series for below reason...

> 
> Motivation
> ==========
> 
> Since TLB is a bottleneck for many systems[1], a way to optimize TLB
> misses (or hits) is to use huge pages. Unfortunately, using "always"
> in THP leads to memory fragmentation and memory waste. For this reason,
> most application guides and system administrators suggest to disable THP.
> 
> Currently DAMON has DAMOS_HUGEPAGE, DAMOS_NONHUGEPAGE and DAMOS_COLLAPSE.
> However, there is no way to tune the settings. It will collapse all the
> hot regions that meet the access pattern. If the server is a bare metal
> database or big data server, this will also lead to eventual fragmentation.
> 
> Additionally, currently THP is set globally. Ideally, there should be a
> way to control which tasks can use huge pages.

You told me [1] you will rephrase the above.  But I show no change from the
previous version.

Asier, this is a repeated pattern that makes me reviewing this series very
difficult and tiresome.  I don't really want to waste our time on repeating
same words.  I know you did this great job so far and you can make it well
completed.  Could you please thoroughly and carefully review "all" previous
discussions, address all the comments and resend the new version?

Particularly, please note that I also asked [2] you a question about Sashiko
review, and I'm still waiting for your answer.  If you don't have a very good
and confident answer, I'd recommend simply adding the zero-case check.

To avoid wasting our time repeating same words, I skip reviewing the remainder
of this version of the series.  I will review the next version.

[1] https://lore.kernel.org/b786294f-0ba5-4b05-b956-d902c358dd88@huawei-partners.com
[2] https://lore.kernel.org/20260617041515.98906-1-sj@kernel.org


Thanks,
SJ

[...]
