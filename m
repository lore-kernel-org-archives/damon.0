Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04354937D;
	Mon, 31 Aug 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191114; cv=none; b=dEDwuejFeW6p79lc5EJb+gtEUcebLQ+xGMh5OC9d/kw37AgavFH8Ov1yOr1mBqTE+2dUHuQD0rnIBRU0OsJrc9qVFeH4A2l0zJLnQkbcv7vQZZZKTQT5vPD/k4SCqSVHBcER7nkclldR3nyRJQKERXHHlIX5wOBg0RHUhYyyPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191114; c=relaxed/simple;
	bh=jy07sXZapQxw/1iN29gzUcPOiHz63cZXJvSY3pkqrr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMV1cv2nS40FYnFqg+xzpo1ktp7h5u0oEfyW1teS4DcVBNBFRtlE1axar8kdG2TKz3cOQVLrvWIEQqErnEXuk7kQ6h6sCABNn0CBZIdkns1vz81UoG+FG/qLfsLsM0MdS8fE3dsEfT2t5vDXvPmNscovFJpyhZRPowVcvISwisg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=If5PZsid; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="If5PZsid"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=N+ozKP2hZTv9niFnVaruRiYppqsUd5pv1oHMpzqQ8/k=; b=If5PZsid3cVdrDrjcSN5KO7Wcw
	FJVve4GhzTiIekZvsysa7UiZ1zmzOE86kvHxzKxtBJ6JOUpWiT+GD14OzCPvVOKNWHmrcMeAUcXHc
	uzzm7oGdJz/T3L7r9N+/32jGa+siIIhDpSJ2kI7JRil6uOsonUDYJEG42Cgv4YQgODy7g5w7L0Zjq
	9aL7ew46uc0EzYN5qNBeLjsUomCJqr5gOpeogYA+DE2VN/2oQgYpp9ExpfODe9U+Qp2g6aXfVlwoh
	+sjltxOqUJezGD6R7dAw0skpYsKl2oV+W7yVg/QSz4KH6cdghLTwWCeX4b4uIEURIckRCsjLHML6P
	6yulnspQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x14Bz-00000009uuz-1oVn;
	Mon, 31 Aug 2026 15:45:03 +0000
Message-ID: <f06ca3de-1cd9-4082-8c66-f6a26e417824@infradead.org>
Date: Mon, 31 Aug 2026 08:45:02 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp
 target metric
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260831144732.80910-1-sj@kernel.org>
 <20260831144732.80910-4-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260831144732.80910-4-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/31/26 7:47 AM, SJ Park wrote:
> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Document hugepage_mem_bp metric exposed by sysfs.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/design.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index aed6cb1cf4831..a8c163475ef2b 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
>    bp (1/10,000).
>  - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
>    of a node in bp (1/10,000).
> +- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
> +  (1/10,000).
>  
>  ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
>  ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to

I've looked thru the entire design.rst file and cannot find anything telling
me (or anyone) what "bp" means.  Explain??

thanks.
-- 
~Randy

