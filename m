Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D7430BB5;
	Sun,  1 Mar 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772382684; cv=none; b=fmbdvPEO3qdAJPKufR0dd40DncLqXZnm/IklM9+E98rcF3kOQzgSn3YAfbmgYoCJSutq6iIi6C3+we6S9lwWMqAwP733dAPleaowPchYb3bKpuBJ2cVghucyhdfvBmwW7sfEKBzCD9Xvtwono4WvIZYiMCf4h4wmLv7SdZ0njyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772382684; c=relaxed/simple;
	bh=22aGZdkZxgr1mCxPhMwaGp7yN1QNCk/YN9RyhwQlTzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC2wJqraQSwB3AkQVT3y3Qs2/NgpZb7VqgBF+tXwHVlVkCxEJ0TtAKhitmR/S/VKDXmAozZzu2f21hiPezZuJEvTdZpsZNRWl/7zsCncnGMvcDKmvq8HcGnAqStaRUKt9Itzq6+P39fpaprYN7UFyAWrnKzRYx/MR91PFgvpfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiT1p+0r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiT1p+0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D659C116C6;
	Sun,  1 Mar 2026 16:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772382684;
	bh=22aGZdkZxgr1mCxPhMwaGp7yN1QNCk/YN9RyhwQlTzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiT1p+0rswZ3TqaFfijT5eXhTCa6zXXaZN1Xfq9/TIqLQ+0Lg8uZDi5BjTrbjCPsB
	 YOCZLUm8321oCAKOnSXSnyXUDLx0HULdqO/i5U4PlI6OCZBI2Tm+09pQnxYmBdIy0c
	 rjmqjI1Ze1RBpJGRHfmacOIO9kspSPcITgWX9FTFvwQOePM1e9LnBOWF5pyRIk2CJR
	 NO9cVyapDCJQRKLk1KNeh/4f6LCdKPMkWGrx0vnuDRwdWchiT8P+xhyNzSVuchhant
	 BTZh2MNTkO7T8QCDUphwatMl1INqvcEibwsAw5ZGMiMynPeZpazR1UxJeu9a/qx/q+
	 CxuFwAuhVafGQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 01/10] mm/damon: add CONFIG_DAMON_DEBUG_SANITY
Date: Sun,  1 Mar 2026 08:31:20 -0800
Message-ID: <20260301163120.92436-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Feb 2026 11:36:18 -0800 SeongJae Park <sj@kernel.org> wrote:

> Add a new build config that will enable additional DAMON sanity checks.
> It is recommended to be enabled on only development and test setups,
> since it can impose additional overhead.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 8c868f7035fce..413adbd8e4089 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -12,6 +12,17 @@ config DAMON
>  	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
>  	  more information.
>  
> +config DAMON_DEBUG_SANITY
> +	bool "Check sanity of DAMON code"
> +	depends on DAMON
> +	help
> +	  This enables additional DAMON debugging-purpose sanity checks in
> +	  DAMON code.  This can be useful for finding bugs, but impose
> +	  additional overhead.  This is therefore recommended to be enable on

I will s/enable/enabled/ above in the next spin.

> +	  only development and test setups.
> +
> +	  If unsure, say N.
> +
>  config DAMON_KUNIT_TEST
>  	bool "Test for damon" if !KUNIT_ALL_TESTS
>  	depends on DAMON && KUNIT=y
> -- 
> 2.47.3


Thanks,
SJ
