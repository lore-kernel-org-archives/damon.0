Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E6A32;
	Mon, 24 Feb 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423708; cv=none; b=Iwqndn93V+YkT0lvIn+EFZ6Zf07Ik8DtY60FfZf3k49pZFu7s/fLBdyuG/28jcFRmjlz4Yx8fho+2ViHbVy8mebUMv281eOu3ZYaDlSZLSVgh1kt3Rpa28NwpNuowMGBHWkmO3kwjyEXxZ42VUA2AiC6B174jdjufRddwme1rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423708; c=relaxed/simple;
	bh=wG7nDVjJHC0pUzNkXRDZmis3Y3vQtVvuiFQUj7UG5mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAdPIhCFPdrEbl67VR9r4cpov1uDlSx5VT6I26wuDvhQMm4TuW07+G9BgTBTvDsmtTm/dv/Dugf/SRnDkVE9WQQlRtJMSjmJZR9fETvVf6iASbReI+KnvYEsBSfH8ZzA+9PeYWAOAsRS33UVbCGd7PIqbwrfaoI2wCl/h5gNoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA+WMCCu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA+WMCCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA49C4CED6;
	Mon, 24 Feb 2025 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423707;
	bh=wG7nDVjJHC0pUzNkXRDZmis3Y3vQtVvuiFQUj7UG5mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FA+WMCCuzi0Fa0v0GJxycox4ekW+1qkyxkUyZqqx6aFmZFe6xRd97djJtP2U8rpDI
	 HzWVEEvEIvz4quyU7qY7rpbl/4MLaJp8+4V1Yv1vLmsoBkZ+NOmzfBgw5cwYfYJCh1
	 wJR6GwkDOE0qxGHRfHkG3zzQGhSjkNxiSkHLIGFoPljJ8MWe0KyRwZf5tudhY3xdsN
	 AjwRLPRe/mteyqtzcLWSHSe7GJGqWwnctYVMXWEU7pEHbT3wccL12sRBWOWq0xxX5E
	 bKbbqmAjEOGvDtPjcWWYnNiJiedcMy0n3f2lT8SB9dsgy/BdzkVhr0mHTvX0/b0x/g
	 BG5UXqNWPBhLg==
From: SeongJae Park <sj@kernel.org>
To: bus710 <bus710@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 11:01:45 -0800
Message-Id: <20250224190145.24272-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224180709.2167187-1-bus710@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi bus710,

On Mon, 24 Feb 2025 10:07:09 -0800 bus710 <bus710@gmail.com> wrote:

> Signed-off-by: bus710 <bus710@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for this fix!

> ---
> Hi SeongJae Park, 
> 
> I found a trivial typo in the Kconfig file of the damon sample module
> while I was trying to do some experiments with sample codes.
> The word "sameple" should be "sample", I believe. Please find the diff below.

I think the above sentence is better to be added to the "Explanation Body"[1]
part of this patch.  This shouldn't be a blocker of this patch though, since it
is very simple.  Please consider doing so if you have a chance to send another
patch in future, though.

> 
> Since the title should follow the format of the project, I sent a new
> email to the mailing list. Sorry for the inconvenience.
> 
> Thanks for the interesting project! DAMON will be very useful for many
> projects.
> 
> Thanks,
> 
> Ps: I found I didn't change the subject! Sorry this is my very first
> communication with the project.

No worry, everyone makes mistakes, like I made the typo! ;)  Thank you for
finding and fixing mine!

[1] https://docs.kernel.org/process/submitting-patches.html#explanation-body


Thanks,
SJ

> 
> 
>  samples/damon/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> index 63f6dcd71daa..564c49ed69a2 100644
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -3,7 +3,7 @@
>  menu "DAMON Samples"
>  
>  config SAMPLE_DAMON_WSSE
> -	bool "DAMON sameple module for working set size estimation"
> +	bool "DAMON sample module for working set size estimation"
>  	depends on DAMON && DAMON_VADDR
>  	help
>  	  This builds DAMON sample module for working set size estimation.
> @@ -15,7 +15,7 @@ config SAMPLE_DAMON_WSSE
>  	  If unsure, say N.
>  
>  config SAMPLE_DAMON_PRCL
> -	bool "DAMON sameple module for access-aware proactive reclamation"
> +	bool "DAMON sample module for access-aware proactive reclamation"
>  	depends on DAMON && DAMON_VADDR
>  	help
>  	  This builds DAMON sample module for access-aware proactive
> -- 
> 2.47.2
