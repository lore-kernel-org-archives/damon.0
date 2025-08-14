Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613381E4A4
	for <damon@lists.linux.dev>; Thu, 14 Aug 2025 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188689; cv=none; b=H5ZfSIMp/6c1fGRVGRDrU3rN5szxBfhvcLZMQGetepl0b0zZjMfag/SYnzIJ9S4yroiLbqh56K4LwH+L1wldY9ZG/DCTQVDJMkgQ6uQ7e4LaCVVqXqwTDtWa2+0+dFcPD2WmEEDgyEXgC0H8llaApy/KHz0x9cN3G278tmXOBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188689; c=relaxed/simple;
	bh=/90Iz8vIooGO4iCtEcpK2bvDlLQw9crMvQb8eGHP9hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oc6NmkZvaXo6rkyeEHmDGYUaqY8kZ3Nr6Q2aZVpfAsdmOj3gkwzChIPzf0x9XnNyLopjFF4RS/Qb/j2rBKOeJwAtd36XXpI1xjuHjyd+V6m72iv4gsEVZJN/csG82YAmWAFBzIDPmrh3SaI7Rs890FWRJ1UIGZNNCIbSkOnVB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/SCaoyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/SCaoyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA653C4CEED;
	Thu, 14 Aug 2025 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755188688;
	bh=/90Iz8vIooGO4iCtEcpK2bvDlLQw9crMvQb8eGHP9hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/SCaoyohj7uAQ7Iach6v/htYHMaejdrTKYIDnnI0wmUitztRMj/XZuoAXteiL4zM
	 ImqrFe2UmxWjTtyNdsT4l832yJ54+O9qZpT5LIzOyOPcOe1XDwwZZLtqHq21c15kTI
	 FHvysF/jUVh2pIc2GkjO484NGWW2iLg8ee4+5+CNOLa/antE/1Hnv6jYFyHgu1ZBAp
	 RB8eU+PXbLXXXsWFXtlxJ3+bblt0poVl3ayDO7pJ0oCFx9a4FwXgc+xHWqIerNw3ZF
	 0XwuC6oGvfEPLB2Zp5z2qRFcQ5668C3vDHmXIRezYiQFMZ2U+es6p6njZHCvKKBfBS
	 7zA7I9opp5Sjw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [PATCH] mm/damon/Kconfig: enforce DAMON_STAT when DAMON_STAT_ENABLED_DEFAULT is selected
Date: Thu, 14 Aug 2025 09:24:46 -0700
Message-Id: <20250814162446.69575-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814121703.648925-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enze,

On Thu, 14 Aug 2025 20:17:03 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The DAMON_STAT_ENABLED_DEFAULT option is strongly tied to
> DAMON_STAT -- enabling it alone is meaningless.

Nice catch, thank you Enze!

> This patch modifies the
> logic to automatically enable DAMON_STAT whenever
> DAMON_STAT_ENABLED_DEFAULT is selected, ensuring functional consistency.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  mm/damon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index b3171f9406c1..5bc71354e6f3 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -105,7 +105,7 @@ config DAMON_STAT
>  config DAMON_STAT_ENABLED_DEFAULT
>  	bool "Enable DAMON_STAT by default"
>  	depends on DAMON_PADDR
> -	default DAMON_STAT
> +	select DAMON_STAT

I don't think we need to drop 'default DAMON_STAT', though.

To me, it seems the problem is the wrong dependency.  What about making
DAMON_STAT_ENABLED_DEFAULT depends on DAMON_STAT, like below?

"""
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index ecbdb3e2ae58..d5f8db812dd3 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -104,7 +104,7 @@ config DAMON_STAT

 config DAMON_STAT_ENABLED_DEFAULT
        bool "Enable DAMON_STAT by default"
-       depends on DAMON_PADDR
+       depends on DAMON_STAT
        default DAMON_STAT
        help
          Whether to enable DAMON_STAT by default.  Users can disable it in
"""

Also, the subject sounds like a bit strong tone ("enforce").  How about

"mm/damon/Kconfig: make DAMON_STAT_ENABLED_DEFAULT depends on DAMON_STAT" ?

>  	help
>  	  Whether to enable DAMON_STAT by default.  Users can disable it in
>  	  boot or runtime using its 'enabled' parameter.
> 
> base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
> -- 
> 2.43.0


Thanks,
SJ
