Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85934148836;
	Wed, 22 May 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339638; cv=none; b=pQLM3oSrMjjB4YIZXw1f1qYApPMKd83wt/4sRyOjuouTHBSVCSJ+VIO0+VxHVbOmR8D1vodmCKNdyxzpg3uDY7CqsXgwqdxm9cbgyACUbtTc+0v9SMGnSFww3Z7a7KdPVQcZglWzwzWKlisZDBe8uUgy5YOMUR7i8U0XfkTXnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339638; c=relaxed/simple;
	bh=MhYuz5hxHwEcA/J213/XoPQ9yIK3Rf2PtgNf8nNBVMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7QjImVIZn5R5vbCNvlsX87LifMhQfuan7QtzF5TRBtGduZ1qcFn90xNGkJe0Az/sdEb57DeTYEOh5bQrtO11h+NvV2CbqDVia1bDysTcWF19PIv9sOJC5zw+NYsH4VscmNes554pm+qd1Q4ltHU5SWL/98K2OIDMxXvh2vpnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThGATGNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThGATGNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67309C2BD11;
	Wed, 22 May 2024 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716339637;
	bh=MhYuz5hxHwEcA/J213/XoPQ9yIK3Rf2PtgNf8nNBVMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThGATGNl5WdBJ6krO6ddFKa1Vi7Yud+Y+cNz7qeg8BLswYbqGv2hbq0COi3Ex+Ewr
	 n2obnZQIZBYotClzBsXImUJrBjvivpy1hD8fu7Hu1SDIWwmQAH1syGKHP7wiBFkntK
	 1FvNODkFWUc5Sy8IajSK/gdRWpECSXMTqzikGCUUHiNymyfOTMZXMijrzHAqzuWEI1
	 pH2XExD+CQ4ccYEjCb8UslYH2GvgCaxPf8wngLj9shc/mmvhCZRbwikEGmNyQMNlRa
	 VKSiL1LAk0eht4ivZdcrhabT5h7l+HBr+SinR4tUYmxC65yXomtTLO+DDXy2GBp1mo
	 FV6G5hkWs+wRw==
From: SeongJae Park <sj@kernel.org>
To: Jonghyeon Kim <tome01@ajou.ac.kr>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] Add NUMA-aware DAMOS watermarks
Date: Tue, 21 May 2024 18:00:34 -0700
Message-Id: <20240522010034.79165-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520143038.189061-1-tome01@ajou.ac.kr>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonghyeon,

On Mon, 20 May 2024 14:30:35 +0000 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> Current DAMOS schemes are not considered with multiple NUMA memory nodes.
> For example, If we want to proactively reclaim memory of a one NUMA node,
> DAMON_RECLAIM has to wake up kdamond before kswapd does reclaim memory.
> However, since the DAMON watermarks are based on not a one NUMA memory
> node but total system free memory, kdamond is not waked up before invoking
> memory reclamation from kswapd of the target node.
> 
> These patches allow for DAMON to select monitoring target either total
> memory or a specific NUMA memory node.

I feel such usage could exist, but my humble brain is not clearly imagining
such realistic usage.  If you could further clarify the exampected usage, it
would be very helpful for me to better understand the intention and pros/cons
of this patchset.  Especially, I'm wondering why they would want to use the
watermark feature, rather than manually checking the metric and turning DAMON
on/off, or feeding the metric as a quota tuning goal.

> 
> ---
> Changes from RFC PATCH v1
> (https://lore.kernel.org/all/20220218102611.31895-1-tome01@ajou.ac.kr)
> - Add new metric type for NUMA node, DAMOS_WMARK_NODE_FREE_MEM_RATE
> - Drop commit about damon_start()
> - Support DAMON_LRU_SORT
> 
> Jonghyeon Kim (3):
>   mm/damon: Add new metric type and target node for watermark
>   mm/damon: add module parameters for NUMA system
>   mm/damon: add NUMA-awareness to DAMON modules

Following up to the above question, why they would want to use DAMON modules
rather than manually controlling DAMON via DAMON sysfs interface?


Thanks,
SJ

> 
>  include/linux/damon.h     | 11 +++++++++--
>  mm/damon/core.c           | 11 ++++++++---
>  mm/damon/lru_sort.c       | 14 ++++++++++++++
>  mm/damon/modules-common.h |  4 +++-
>  mm/damon/reclaim.c        | 14 ++++++++++++++
>  mm/damon/sysfs-schemes.c  | 35 +++++++++++++++++++++++++++++++++--
>  6 files changed, 81 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
