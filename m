Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DDE3BE14A;
	Wed, 25 Mar 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449468; cv=none; b=kK2z8EM+7YoNNCQ2Dn62kgrGmYUiyQA6wvyrR2oRuAD5dU4uWROH+H61zhS0jXVcTD1H7zl3puYXR4k0Y+rlOKBUVuL/zFxiLuv4TrkJQiZl1xDqSP0jPcj6bprRuIIKmwidtgDQ55VfBMWdwsH3kROK9LygF66aYlllMYKXTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449468; c=relaxed/simple;
	bh=k/MsHHjnglulTtuQp2KFJd4JaMLVffpszcrg/qv0xsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCyVldMDDhVcdjTMHkzCa82nM0qquUUYPEi2Ty462XUsWAgXsPbRpfc8m8vUTzAgJzL0DWYUN5nyUdnx5LKtDTnFOok9Csux4pp07bIjzOP0V6/DKUk7lOYsFfnBeiyfjCq0xcJ57zRXAvcBoMp+Zttml5y54sABAiOu/B+oFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ2RtyiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ2RtyiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D5AC4CEF7;
	Wed, 25 Mar 2026 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449467;
	bh=k/MsHHjnglulTtuQp2KFJd4JaMLVffpszcrg/qv0xsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJ2RtyiZOlkU54ojrOOo0w8LrVCduRJ3hDJbsWLSoxu/Fufog6AgrA37CkZa9KLxL
	 vG3hmLIkaT+2QJZGtKVrUi6Vo+/suROFGdl1D5JppxFxCRGf8wn8ACa/dSorvp70eI
	 nFB53f9h6gjT9HqjB4O0z4XrJE+toYcVB7LaWL48ZUuf9bQAUglX9EzJM7z20Vnihb
	 tAeutkdoeXsgRM0IZXjilgrGz3WsrZ0uzB6gRzvffCgD50hiw3J6GHmMPver56JePH
	 pSGrtrgopsuI3v7Yesw78Oot57pRb0Xnt+UPORYjErqsCimfBUvnKCiYy+4AVChGCV
	 BvItSvGr35fWQ==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: validate goal nid before accessing node data
Date: Wed, 25 Mar 2026 07:37:39 -0700
Message-ID: <20260325143740.87690-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325073034.140353-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260325073034.140353-1-objecting@objecting.org
# start of sashiko.dev inline review
commit 7e17cbe1dc95a0cd1a1410be38ab6964f78fb15c
Author: Josh Law <objecting@objecting.org>

mm/damon/core: validate goal nid before accessing node data

This commit adds bounds checking and node_online() validation for the
goal->nid in the DAMON quota metrics. It prevents out-of-bounds accesses
to NODE_DATA() when an invalid or offline NUMA node is provided by userspace.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index db6c67e52d2b..81ce27baa1a1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2245,6 +2245,10 @@ static __kernel_ulong_t damos_get_node_mem_bp(
>  	struct sysinfo i;
>  	__kernel_ulong_t numerator;
>  
> +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> +	    !node_online(goal->nid))
> +		return 0;
> +
>  	si_meminfo_node(&i, goal->nid);
>  	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
>  		numerator = i.totalram - i.freeram;
>  	else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
>  		numerator = i.freeram;
>  	return mult_frac(numerator, 10000, i.totalram);

Could this cause a division by zero if the node is online but memoryless?

For CPU-only compute nodes or nodes where all memory has been hot-removed,
node_online(goal->nid) will evaluate to true. When si_meminfo_node() is
called for these memoryless nodes, it populates the sysinfo struct with
i.totalram = 0.

The mult_frac() macro unconditionally performs integer division and modulo
by the third argument, which could trigger a kernel panic when dividing by
zero.

Would it be safer to check if i.totalram is zero before returning, or use
node_state(goal->nid, N_MEMORY) instead of node_online()?

[ ... ]

> @@ -2261,6 +2265,10 @@ static unsigned long damos_get_node_memcg_used_bp(
>  	unsigned long used_pages, numerator;
>  	struct sysinfo i;
>  
> +	if (goal->nid < 0 || goal->nid >= MAX_NUMNODES ||
> +	    !node_online(goal->nid))
> +		return 0;
> +
>  	memcg = mem_cgroup_get_from_id(goal->memcg_id);

The same division by zero risk exists here when mult_frac() is called at the
end of this function.


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260325073034.140353-1-objecting@objecting.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260325073034.140353-1-objecting@objecting.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
