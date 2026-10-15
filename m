Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7073939A2;
	Thu, 15 Oct 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082021; cv=none; b=abalzpzDaKHa5TIeZ3DjMtCNUWGEtLBTr6tOEoUTdhJjbuELELI3zoDDng9zERJq74wuzzdtPcaDUnFn7u7+rvgtZs1zy9sGXXHxSGFicPK4fz+Rt4CjgZhAnJxvVIflSRLRkyDQoTJqVJtOXKzPpvNEbANustlazyEIdT0GPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082021; c=relaxed/simple;
	bh=rvUDJ5coe/g3in+yWuUokYMULA0JxvqrpSyvwFlBe48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEfz0mBo3mvj9N2GoLejX7Nlz6Syo7OR+WPwT0YM4/tQ8xMECRm7CtNJOTJqR0NBD8DeDLwon7t02YtLsi4TFhUoKgqIb73VAbwMBcGb9USgXxRnQcDncrAToogLqtNBy8GuUoHmnhC5CjLQHAuoP5uzVlP1sMPMlaZVwGLHFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VudioFi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VudioFi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B79C1F000C4;
	Thu, 15 Oct 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792082010;
	bh=wB0tk+aH7s3MMfbB8Iw2GRSSbSBPsDhiY+SCoFkNsE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VudioFi2FIVI2/fFALAn/y1jf4ZzoXofytfczFv34fp72Oif46y1ry4mQu+WPZP2s
	 E2ZZGLtjF7Yau/YIJgdgFi2o+fzQ1/oWgWA0fmYfhcPyas0xomvMYlOMmZcaDJgYYX
	 lGifki/2RHy25ChSrFrEIUhPWnEHPPeBAoldjq1RZaIUJX5M8gb4tlFwDKlP6gQSlm
	 tbcHEoHih1M6N2E84RmeaRtd0IybWXnRwy1i37aRUnlRDR4+llM/owiXQEzvdbPqvN
	 aifGd5Zwdu8D4RirzErTFtrV3ak9iK0tVb9PIfy/4bBhTO+gmLbo7gaNkjwQ5IxtcD
	 JBAXTmYR4V2ew==
Date: Thu, 15 Oct 2026 17:33:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: exclude DAMON docs from MEMORY MANAGEMENT -
 MISC
Message-ID: <atEAOFcrkyEsqhcw@gremlin>
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

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

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

TIL about the X: tag :)

>  F:	drivers/char/mem.c
>  F:	include/linux/cma.h
>  F:	include/linux/dmapool.h
>
> ---
> base-commit: d6d3455d8751854e0d1820f14184682e23ac4475
> change-id: 20261015-maint-mm-core-x-doc-damon-d2da56de5ee8
>

--
Cheers, Lorenzo
