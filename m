Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811C21C165
	for <damon@lists.linux.dev>; Tue,  4 Feb 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710829; cv=none; b=ZvctlUhjpsCXTeycDcpGaxSRZMK51RqDZ5qDalZyOV34VOuR3DX67S6iG2vHfYNC9kr2KWJa11q6Of4Wv3w3XDL44gQDZ/rrFBUbekx4WxYezi6so+5wrmD4T73mr002VKMJGIMEqyKmHNIP3LBkRFsLscz+4fJieacf483clv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710829; c=relaxed/simple;
	bh=1UaofT+c4ejJ6dFBaUjZ019vYzhreeikfVp4M9SwpGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObHr88GuGoporlAcOa8ouPMxuJjOlowhgrUZ0F4436D2Jtr5aEJlbMVfTr/7M+4felvhl3osytP7i1GRxuyWakT9GzJZMpj5Kq5MZFzUmDhDfPc8ydPIhAepJGAG//+CF7y23nkg/2tS9r4pYEiicg17kDFfAdjtBnoO0OAk1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQsZwQiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQsZwQiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307A8C4CEDF;
	Tue,  4 Feb 2025 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738710828;
	bh=1UaofT+c4ejJ6dFBaUjZ019vYzhreeikfVp4M9SwpGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQsZwQiW/kiHbPHPINpAHffeMprVBRYqmU6hnFUCdNhc+8v80bV+W3D4+OWBN7oY+
	 0bkDTP2ii7GFXsDlaB1RT6KgNTnWgsW8tE9661Vdmxz+jzA6NsSxY1moT7uxNqzKig
	 4L7FMnl1tw7pIyIG7QTnW/fCPQUaGYfKprJqljgWagtiTGyS/CNmV37tpqccLLM3lG
	 vTkwoB1apIwUpQ+dCnS70zHA1EmhoOlMp+8/rW5zhJ5PSqwkTARgUBoFW6YAE8hwKH
	 RJ7ZUy4Dsv4AI1w2Hm2bbN+/WjZiRl+TM/hcFH6NRXIz/EhqbVJZlcAdyEn7CNcbtx
	 aPqtbi6qtHQtg==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	david@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 6/6] Docs/admin-guide/mm/damon/usage: Document hugepage filter type
Date: Tue,  4 Feb 2025 15:13:45 -0800
Message-Id: <20250204231345.2857-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203225604.44742-7-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  3 Feb 2025 22:55:33 +0000 Usama Arif <usamaarif642@gmail.com> wrote:

> This includes both the 'hugepage' filter type and the min/max
> files used to decide range of sizes to filter on.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index 47a44bd348ab..5765896aaa7e 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -83,7 +83,7 @@ comma (",").
>      │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
>      │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
>      │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
> -    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx
> +    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
>      │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
>      │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
>      │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
> @@ -406,13 +406,14 @@ number (``N``) to the file creates the number of child directories named ``0``
>  to ``N-1``.  Each directory represents each filter.  The filters are evaluated
>  in the numeric order.
>  
> -Each filter directory contains seven files, namely ``type``, ``matching``,
> -``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, and ``target_idx``.
> -To ``type`` file, you can write one of five special keywords: ``anon`` for
> -anonymous pages, ``memcg`` for specific memory cgroup, ``young`` for young
> -pages, ``addr`` for specific address range (an open-ended interval), or
> -``target`` for specific DAMON monitoring target filtering.  Meaning of the
> -types are same to the description on the :ref:`design doc
> +Each filter directory contains nine files, namely ``type``, ``matching``,
> +``allow``, ``memcg_path``, ``addr_start``, ``addr_end``, ``min``, ``max``
> +and ``target_idx``. To ``type`` file, you can write one of six special
> +keywords: ``anon`` for anonymous pages, ``memcg`` for specific memory cgroup,
> +``young`` for young pages, ``addr`` for specific address range (an open-ended
> +interval), ``hugepage`` for large folios of a specific size range [``min``,

I'd prefer naming it ``hugepage_size``.

> +``max``] or ``target`` for specific DAMON monitoring target filtering. Meaning
> +of the types are same to the description on the :ref:`design doc
>  <damon_design_damos_filters>`.
>  
>  In case of the memory cgroup filtering, you can specify the memory cgroup of
> -- 
> 2.43.5


Thanks,
SJ
