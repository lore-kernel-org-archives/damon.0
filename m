Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7734C85;
	Thu, 16 Jan 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737062290; cv=none; b=KbaZ+s3KdEfOWK88C2UyVWeOlEGtST4Nd7Ey+/UEzVEuKnxTcnwplDi/oNBM3uELVhDj82KMGN+dj+NipwT65HNJFXHJOsf2Hoaq8lrav0qU+P54xW51b1N1FDH9hOa9xTaF53w+6R79SJMcPJ0kg+XQ9fAgAuugke3KZ/z1O3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737062290; c=relaxed/simple;
	bh=4nU4YLVck1cnanHF7eMWqo+M3LlO8RKHg4oPPXm0JUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vmtdo6oiDUdsLB1FWcXoi1lC4joY7PLCoohsE/ZBjKx4+Hb8tAnqwOALTRqNxs2No5F+XtIrSNURBHMwheb/D3PVUp4gYFqIiy7MXfVp6L5LSqylch25Ayb0nxG5+NoxlP27n2y3DIUWV/zPfXzyop6ReclSLQ2eZ01zgdS4C7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp/vGnV7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp/vGnV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B05C4CED6;
	Thu, 16 Jan 2025 21:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737062289;
	bh=4nU4YLVck1cnanHF7eMWqo+M3LlO8RKHg4oPPXm0JUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sp/vGnV782r6dokBVUMw4LBXzeuV/pkXLah8svGVz7vrXFbcH+HpCYIBp07gHN8GE
	 BU5qtIyjasfZIvGuTY7DLmf3+nVhjnUcJnrhBaRGeCQBrh06W2b8UP+ToV0DXExWb8
	 BKyeMd+qNGnivWiDdr9A+/Emk8JdkXVo16mC+RD2irJOB1cfxb1t9MRkcvnq0gYEv8
	 HrDcou7cv7TQ83yAk0nPera34VccZgkj3iLS7CBXIJ8L9hmaBbdV1zuM+lyt2clFqw
	 maNIi3lreizSXILps27sk2Y2nJEb0gEqXBjcZCF5IjQVsJiKCICCmtWB5xOqF1gpe0
	 p8dPBOrIuoThw==
From: SeongJae Park <sj@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: Use str_high_low() helper in damos_wmark_wait_us()
Date: Thu, 16 Jan 2025 13:17:58 -0800
Message-Id: <20250116211758.47368-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116204216.106999-2-thorsten.blum@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Thorsten,

On Thu, 16 Jan 2025 21:42:16 +0100 Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Remove hard-coded strings by using the str_high_low() helper function.

Thank you for this patch!

> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0776452a1abb..ae1715a338d4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/psi.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/damon.h>
> @@ -1894,9 +1895,8 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
>  			pr_debug("deactivate a scheme (%d) for %s wmark\n",
> -					scheme->action,
> -					metric > scheme->wmarks.high ?
> -					"high" : "low");
> +				 scheme->action,
> +				 str_high_low(metric > scheme->wmarks.high));
>  		scheme->wmarks.activated = false;
>  		return scheme->wmarks.interval;
>  	}
> -- 
> 2.48.0
