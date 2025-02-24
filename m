Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8626136C
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417007; cv=none; b=kKVKKVyT1r4Zx+N4n5KDgVXMxwMAicBBMh+4cYoKCt9cmXR1UCvw95cnIZC7gBoUjcdB0t0FIhMOivRi/ol4ewVp8mydMNo0AWJbqS4lP6BTlT4G4ZJul922YnhseOIKuvtgPTYZhsF25cRR0S8LMPVPtgtmp7GA+rbKeu+qdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417007; c=relaxed/simple;
	bh=3R0OfJWGkVG7iYWcmlvPRZ7eP2KelYqYohZezCfh+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwdWpQq/Mj/b4i2lTbbQei0S1X+bO4gzB3EPxLuBqNaP74P8MVw12Y7fHLyh/G+rlQhTKvGXMB/Cou0asQ/AiXzuQVMbq/9vCBx1a5/UR9yW9za0eZsf2oKrmAgGIY2PoraoGyr6gY6JDdHQiLHOQE9YmCti/BpVg6+ttA6L9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDFHwiRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDFHwiRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086EAC4CED6;
	Mon, 24 Feb 2025 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740417006;
	bh=3R0OfJWGkVG7iYWcmlvPRZ7eP2KelYqYohZezCfh+0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pDFHwiRhjsUYbzrnpQ4pAxhVHW13vsCFmJcSLjlgWZK9ZX1AT8a3EYF84uch5em+4
	 XkfREwgwunAJOu3Ri74XMOE1rgtb6uegxvsA4HtF7RNa1pD4SNp/DUQem62hEWBr6+
	 H7SgNN7Li4HdF1YxCb1AdZcIURDk8dm8IaI/zcyk5fLio257DNx9bpHqhLxLGAk22b
	 TMz3S/eY6uwsY4vQxLI5UozQCvH+tSkYhvAEA+iM8ZLsQAHSKHc402QRFYO2bTu+dY
	 R95ShcjreesEeFY0MzOKbSl+JVz+YnlZhUFYnuTX6K7Ja4e6V3J+AdDs7hI41R2LSP
	 LcnhUOY7RdZmA==
From: SeongJae Park <sj@kernel.org>
To: bus710 <bus710@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] A typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 09:10:03 -0800
Message-Id: <20250224171003.58091-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224055515.1614285-1-bus710@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi bus710,


Thank you for the fix.  The change looks good to me.  But, we cannot accept
patches that not having proper Signed-off-by: tag.  Could you please add it and
resend?

Also, please update the subjejct to have 'samples/damon:' prefix, and add more
proper commit description.


Thanks,
SJ

On Sun, 23 Feb 2025 21:55:15 -0800 bus710 <bus710@gmail.com> wrote:

> ---
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
