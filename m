Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636138;
	b=Ri861IRGNZekHSo00+yvZkymOJMLgQ2SpEgENZd8RCWCxRtG8240aKqOd3D/2OXBOLHe
	 V5qIiGUgcrDXFgx/3s9zV+jYMGByeEsxN5FWgk0DW7q/f0lLlDrtCLiH3ZVK0+S+CIxgS
	 S0MU+L9jwDt+7etR1Eh3PHs6kj4Y+2Tm9E6t0z5yaJs+pIKjsTS9Qw8YNPDaztIdr1jzh
	 Gh4DK0xuIMH7NH9hbK5poP9eFpDEvLHedfOAHJhS6fpUtbgxCRtrxSOjFTDZseQ2Ym4Ho
	 XI4CUw1rr3fGNxrv2I5c3hkpIz0j2uhGQX/QZ0RF5hCSiqxS4flbfzJn6CfkgIodhBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636138;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cSnX/lDPO84uhZYL3He4tA7vIj3wFfw46jJJRk/azek=;
	b=oQbULYFs07mRRvXqkQat0Ey2lay4WWCJQPTe4xZZSzf5aAps4crejfAi+I2MNyWlFSWG
	 Qz9/BVsD7KoIZciX1tBbyJuUj3ntYr2SSjdFYz4HQ/ZJEdNIaFarL3uGdc8Ra5RVOj+Ue
	 5pSf+BqdA3/6qLaHU8vCZh3kuYShBUmtJhNWxaAco1ip+xs4r/IcBaVB4TWBAWH74YT4s
	 w+GV/+/Jqd/6jEzgagZYev/TyTSgIySHrYK5rup06i++oXKCAsT//AV3UmEawBVMwlC+o
	 dOPDUoAtF5jdbHin+/UDx7dguW7GByQcX/r1whjDpwhVGOIhSzI6wR4lyewWzilY/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lO44GlAL;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB41606A32E;
	Sat, 14 Nov 2026 06:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EB41606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lO44GlAL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cSnX/lDPO84uhZYL3He4tA7vIj3wFfw46jJJRk/azek=; b=lO44GlAL8BpSDnM8BNoovadxIu
	kAYTKzZ2GcRv8ke2DTiZBmoU8qAc9Gmf/kd3E55EyYB2xCW6TtsbGISk42BrLz331ClG0UoQfZvn+
	4auvUXT6EE2wAtpNt8mx6uL+OVlAFX+fTawjVAJZxyHVjUn9BzTjiIs1hm21tGhKnZj73IbrCX0G4
	D28d6zQjJvDtpRQ0PjQfLELliQgEE2D7uVpZT/YOVjexkLTIa9KFmRP6K4sTw0f/E/CigGQbzAYxi
	GlMfGlYzO1qGiM2mYHWhI/bySErpwvOu1vASJlj0GqJoA3qcaymyhMisJYSOPowGF5FVFyo9drTOM
	43TEQRbg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS6q7-0000000FWJ8-3fe1;
	Sat, 14 Nov 2026 06:02:15 +0000
Message-ID: <aabdb561-881a-4824-9d85-860528a99099@infradead.org>
Date: Fri, 13 Nov 2026 22:02:15 -0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/mm/damon/design: replace "same to" with "same as"
To: Enze Li <lienze@kylinos.cn>, sj@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20261114055436.5546-1-lienze@kylinos.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261114055436.5546-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/26 9:54 PM, Enze Li wrote:
> "same to" is not idiomatic; it should be "the same as" or "same as".
> This doc has six such usages.  Fix all of them at once for consistency.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/mm/damon/design.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index b676be697158..6284b9005443 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -292,17 +292,17 @@ DAMON :ref:`context <damon_design_execution_model_and_data_structures>`.  The
>  registration is made by specifying a probe per attribute.  Each of the probes
>  specifies a rule to determine if a given memory region has the related
>  attribute.  The rule is constructed with multiple filters.  The filters work
> -same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
> -filter types.  Currently below filter types are supported.
> +the same as :ref:`DAMOS filters <damon_design_damos_filters>` except the
> +supported filter types.  Currently below filter types are supported.
>  
> -- ``anon``: Same to that for DAMOS filters.
> -- ``memcg``: Same to that for DAMOS filters.
> +- ``anon``: Same as that for DAMOS filters.
> +- ``memcg``: Same as that for DAMOS filters.
>  - ``pgidle_unset``: Matches if the page for the memory is marked as not
>    access-idle.
>  - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
>  - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
>    of a given size range.
> -- ``active``: Same to that for DAMOS filters.
> +- ``active``: Same as that for DAMOS filters.
>  
>  If such probes are registered, DAMON executes the probes for each region's
>  sampling memory when it does the access :ref:`sampling
> @@ -706,7 +706,7 @@ There are two such tuning algorithms that users can select as they need.
>  The goal can be specified with six parameters, namely ``target_metric``,
>  ``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
>  auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
> -``target_metric`` be same to ``target_value``.
> +``target_metric`` be the same as ``target_value``.
>  
>  - ``user_input``: User-provided value.  Users could use any metric that they
>    have interest in for the value.  User space main workload's latency or
> @@ -736,7 +736,7 @@ auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
>  
>  ``complement`` is a boolean parameter that determines whether to use
>  complemented value of the target metric.  For example, if ``complement`` is set
> -and target metric is ``active_mem_bp``, it is effectively same to
> +and target metric is ``active_mem_bp``, it is effectively the same as
>  ``inactive_mem_bp``.  ``complement`` is no-op when the target metric type is
>  ``user_input``.  For the metric type, the user should be able to emit
>  complemented metric values on their own.

-- 
~Randy
