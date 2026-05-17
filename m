Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49C194AE6;
	Sun, 17 May 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004784; cv=none; b=dLZBOWttIBJMybI17qS2Cs2rgrNIODMlepkGPMJOGsvN+sb2cHp2JknlTLxhYaumZ9Ev2yF/+R/aDrdyZza839pako3/B4IkmYuPxtdkiiO6yXpj18/s1gjv+YqsHzh0n5XIdx016VjWErJSjC33tfj5cxGEUwLrQZDdQ07IM2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004784; c=relaxed/simple;
	bh=+tpOB4cCHIhZwEMPfsD8khe4UWH8UaIc/EI0bo2TbNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwXW2dxDgCZVzYSB4EcwhR/zoFaLCYBEO1UzGrdmxQ4ZFBxibuzhKRJV7XbKHVtwUzWYpT30rmRmuirqO/hm5sC26+FPxzH1Dg/ZuWQ1VB5XBcPNloKQ8E9zu4AUPRxj0yYtKC46aeA9pFHZ30n0KsozPfQtNoT+egc2DKu3ZTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6eKltdV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6eKltdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC854C2BCB0;
	Sun, 17 May 2026 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779004784;
	bh=+tpOB4cCHIhZwEMPfsD8khe4UWH8UaIc/EI0bo2TbNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6eKltdVAcaWb/ZioFDq5zVOhh5NZttHzOTVH9LIOmv9vOHxdg2rqFovnn/aV6NYY
	 1oS6E/uvIb1ggIjoJMaWgatL37vQo1V80ZXXfxzXbbZa5FOZQ0fIIhzMOF7598wXoC
	 9rztgRcunOrRTRxFDoQqHXWjRDNU9pAmF4/Ta1kyP/QRLc7EYW3kW3K+LS4A/VOT2A
	 tCjlIwjZx4BlQxpd34TrI3z1nMEj1dRjyp6ogs7seKwEs5vxf5nQJ+Cet+CxujjMEk
	 ezJou4Q/8ga5hfwLqwBBfUpp829kG9jJpQtiTMlk+jrtvSU4YNtt7zOlKetwmP1uTA
	 XG6NtEqIkjA/w==
Date: Sun, 17 May 2026 08:59:37 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Sakurai Shun <ssh1326@icloud.com>
Cc: SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] design: fix typos in design.rst
Message-ID: <agl1WwiSVH0Nynb0@lucifer>
References: <20260517073433.3015-1-ssh1326@icloud.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517073433.3015-1-ssh1326@icloud.com>

On Sun, May 17, 2026 at 04:34:26PM +0900, Sakurai Shun wrote:
> L140: "unsinged" -> "unsigned"
> L371: "sampleing" -> "sampling"
> L387: "multipled" -> "multiplied"
>
> Signed-off-by: Sakurai Shun <ssh1326@icloud.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  Documentation/mm/damon/design.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index afc7d52bd..9cc70a296 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -140,7 +140,7 @@ as Idle page tracking does.
>  Address Unit
>  ------------
>
> -DAMON core layer uses ``unsinged long`` type for monitoring target address
> +DAMON core layer uses ``unsigned long`` type for monitoring target address
>  ranges.  In some cases, the address space for a given operations set could be
>  too large to be handled with the type.  ARM (32-bit) with large physical
>  address extension is an example.  For such cases, a per-operations set
> @@ -371,7 +371,7 @@ with theoretical maximum ``nr_accesses``, which can be calculated as
>  ``aggregation interval / sampling interval``.
>
>  The mechanism calculates the ratio of access events for ``aggrs`` aggregations,
> -and increases or decrease the ``sampleing interval`` and ``aggregation
> +and increases or decrease the ``sampling interval`` and ``aggregation
>  interval`` in same ratio, if the observed access ratio is lower or higher than
>  the target, respectively.  The ratio of the intervals change is decided in
>  proportion to the distance between current samples ratio and the target ratio.
> @@ -387,7 +387,7 @@ The tuning is turned off by default, and need to be set explicitly by the user.
>  As a rule of thumbs and the Parreto principle, 4% access samples ratio target
>  is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
>  That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
> -to capture 64% (80% multipled by 80%) real access events (outcomes).
> +to capture 64% (80% multiplied by 80%) real access events (outcomes).
>
>  To know how user-space can use this feature via :ref:`DAMON sysfs interface
>  <sysfs_interface>`, refer to :ref:`intervals_goal
> --
> 2.54.0
>
