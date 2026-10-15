Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178C53ECFB;
	Thu, 15 Oct 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084398; cv=none; b=SELNE3uouOzDQHPTKjeuLX0daOUm3x+KqpA080zcoegqQKwfNis/8YhGFXl/A8gJ5XWUbAnaHJvJHEQr1slVzsjBhIzQz7At4Z1u20PAizHoUjhqc5uOfslqrAZkNSlzAlMIbMhKa0wJIW28lU0EkfZEXF1V53Unf+WitWR7NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084398; c=relaxed/simple;
	bh=7/hLGXmRTOxSRhk/8tHEgZx4tgNsLMA/OAbq44b3JyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5PimvoDKHbgGAf1rpn8wqQR8l8CSiBk382gxuy+6mpEemgefFlzk0HCYITlGVkNjZGc4kXUKEpmeNsM8jJEB/x+yPr7ZT9Nm3ewVIBflA7op4616mshtbYuNplsWFACD9kvwNa9nOsqMDYXxISqHzrwxK1IetcggwJ1PbYR21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5kYrja8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5kYrja8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8B51F000C4;
	Thu, 15 Oct 2026 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792084376;
	bh=Wfze5VWXLXgXs5xl8MP5DoIEk350uqQ1C5W3otbekT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F5kYrja8SaPmmRd62CvpHSgl1CLCslMmBa0Ztex3scwmK9Sj8LW7qAVxkN9sLZjCs
	 a25EZoHTvkMeCa0xTnFnCYxg/i/qE6Llw/idu5W/ceYEhkutc7PF5/y544pqTYxuo7
	 /maVXBQpmvQUvLiHhazAzVu8wifbv+13tDJP+Emsw5ik00VegEaHaVvJ71154pIh9w
	 2ecs9xQ5XVk0nxcl/YYA+rx1u7QqSk3wNm5nKcjybXH0GeHesbVdxnSHZ+M07j0Z4I
	 J7dkNupsuX1pETtzK9C11p/TKb9Pt/bA+XpNJSZDp03RCsJ99x0KoqKON5TJ3dHehm
	 QnYQsjv09WVRQ==
Date: Thu, 15 Oct 2026 20:12:49 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: exclude DAMON docs from MEMORY MANAGEMENT -
 MISC
Message-ID: <atEJkcKqcfOg-Q8g@kernel.org>
References: <20261015-maint-mm-core-x-doc-damon-v1-1-226decb5cd0d@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-maint-mm-core-x-doc-damon-v1-1-226decb5cd0d@kernel.org>

On Thu, Oct 15, 2026 at 06:31:46PM +0200, Vlastimil Babka (SUSE) wrote:
> MEMORY MANAGEMENT - MISC is a list of misc mm sources and also acts as
> catch-all for the mm Documentation subdirectories. Documentation for
> DAMON is well maintained within its own subsystem and also actively
> updated, so there's no need to Cc all MISC maintainers for them as well.
> Thus add exclusion entries for them.
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> I'd love to have the time to check the DAMON documentation changes, but
> it's simply not happening, so this will save some mail traffic for me,
> if others agree.
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..cbe565b353d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17269,6 +17269,8 @@ F:	Documentation/ABI/testing/sysfs-kernel-mm-cma
>  F:	Documentation/ABI/testing/sysfs-kernel-mm-numa
>  F:	Documentation/admin-guide/mm/
>  F:	Documentation/mm/
> +X:	Documentation/admin-guide/mm/damon/
> +X:	Documentation/mm/damon/
>  F:	drivers/char/mem.c
>  F:	include/linux/cma.h
>  F:	include/linux/dmapool.h
> 
> ---
> base-commit: d6d3455d8751854e0d1820f14184682e23ac4475
> change-id: 20261015-maint-mm-core-x-doc-damon-d2da56de5ee8
> 

-- 
Sincerely yours,
Mike.
