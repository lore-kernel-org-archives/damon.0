Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2465393DC7
	for <damon@lists.linux.dev>; Sun, 24 May 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629847; cv=none; b=BP8nPvS8VPzR2Ih7budG0gyRxn0uvamKXt9xsGQ7nrqgd0h7asFGGXiNkxG9sk0fqHKIA/DF44Iq4RhpSruTXYqVsi/bDUL0QloyrV5K/UBeQmFgsPM3CtIPCHl9jA63J8pkHR8kbxDL4v+hG1jQNkKYtYuj0bEpnCujDXASp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629847; c=relaxed/simple;
	bh=ZChN/TK63ifkoNG1MDG0wmln/ikSmoGJSIcgvfbnD9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBL+0KVtsEsV+VudRQNmq60lLsPOXKHiAlrvXfY5H2oXnhn7HhiN5rrAY5G5MLt7T74wTroTxYKYiBZOJ/oVXQTvNCJF3KOZS8R75gzDfZnxd8zwHXETlyTVvUPR6fZ9nOm/PoXetMO9Cc1zWdPUUS8S35kP0i4WEL7WPYqi3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BAIZ6fPa; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BAIZ6fPa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779629841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sOoypwVXiJS7FMQk1ugjy+9q2SWezMLwPiTi1PVsw1c=;
	b=BAIZ6fPa9cpaXB+ilch1OPpC99v27Yn87+M8XZZnovqAuZmJZp2BvQRG5QnJDUkFWqIwtb
	eWSqfvWRwzPEManaWLFDBqAbxcjXc14hHmefDC6jcCPwAEDBfuL4PkXPBqgKKL+5Y3Isdl
	IKVkwA90mhMatd+uHBpFD9CgbSHIH68=
From: Lance Yang <lance.yang@linux.dev>
To: mattsva.kernel@gmail.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	sj@kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: fix spelling mistakes in memory management docs
Date: Sun, 24 May 2026 21:37:01 +0800
Message-Id: <20260524133701.3470-1-lance.yang@linux.dev>
In-Reply-To: <20260524124924.405071-1-mattsva.kernel@gmail.com>
References: <20260524124924.405071-1-mattsva.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On Sun, May 24, 2026 at 02:49:21PM +0200, mattsva wrote:
>Signed-off-by: mattsva <mattsva.kernel@gmail.com>

Missing changelog ... and Signed-off-by should use your real identity,
not a handle :)

checkpatch.pl is your friend, please run it next time :)

>---
> Documentation/admin-guide/mm/damon/lru_sort.rst | 2 +-
> Documentation/admin-guide/mm/damon/reclaim.rst  | 2 +-
> Documentation/admin-guide/mm/transhuge.rst      | 2 +-
> 3 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
>index 14cc6b2db897..25e2f042a383 100644
>--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
>+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
>@@ -75,7 +75,7 @@ Make DAMON_LRU_SORT reads the input parameters again, except ``enabled``.
> 
> Input parameters that updated while DAMON_LRU_SORT is running are not applied
> by default.  Once this parameter is set as ``Y``, DAMON_LRU_SORT reads values
>-of parametrs except ``enabled`` again.  Once the re-reading is done, this
>+of parameters except ``enabled`` again.  Once the re-reading is done, this
> parameter is set as ``N``.  If invalid parameters are found while the
> re-reading, DAMON_LRU_SORT will be disabled.
> 
>diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
>index d7a0225b4950..01a34c215b66 100644
>--- a/Documentation/admin-guide/mm/damon/reclaim.rst
>+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
>@@ -67,7 +67,7 @@ Make DAMON_RECLAIM reads the input parameters again, except ``enabled``.
> 
> Input parameters that updated while DAMON_RECLAIM is running are not applied
> by default.  Once this parameter is set as ``Y``, DAMON_RECLAIM reads values
>-of parametrs except ``enabled`` again.  Once the re-reading is done, this
>+of parameters except ``enabled`` again.  Once the re-reading is done, this
> parameter is set as ``N``.  If invalid parameters are found while the
> re-reading, DAMON_RECLAIM will be disabled.

Already fixed in mm-new:

https://lore.kernel.org/20260426231619.107231-3-sj@kernel.org

>diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>index 5fbc3d89bb07..5d08a2a1c15f 100644
>--- a/Documentation/admin-guide/mm/transhuge.rst
>+++ b/Documentation/admin-guide/mm/transhuge.rst
>@@ -210,7 +210,7 @@ PMD-mappable transparent hugepage::
> 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
> 
> All THPs at fault and collapse time will be added to _deferred_list,
>-and will therefore be split under memory presure if they are considered
>+and will therefore be split under memory pressure if they are considered

This one as well:

https://lore.kernel.org/20260520051751.74396-1-leon.hwang@linux.dev

> "underused". A THP is underused if the number of zero-filled pages in
> the THP is above max_ptes_none (see below). It is possible to disable
> this behaviour by writing 0 to shrink_underused, and enable it by writing
>-- 

So this patch is stale now: all three hunks are already covered in
mm-new.

Thanks, Lance
