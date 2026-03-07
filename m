Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570B15A864;
	Sat,  7 Mar 2026 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842875; cv=none; b=a27WtZwVLEAO0n8Bn2t/E4QmFFmMSZ7K7CNDqygLvXdPnFx6Vrw+bF+Iw/edG0vJrLoGKlumZUVbmYpbqKkKeOoJkFYzlXRdfDfQcOub+vsyamqHGPLNaVXCAajDKqYL6W2UsyAFV0yoaGIx8AmF24kTIqm88n3UilN/tJx/9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842875; c=relaxed/simple;
	bh=uqHdwNgwIWQfBSHknp0uLe4ul6M3Tot+WSbz66G0te4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWgOKMnaKSHpLbrqae6jxRMsiIglv8jV4kOQXEDRN3KWvXXP3qZxoxEjlNZLERv/TLr/OFwPYDhjvwa0hqJlDwx+lAWwHexoH4c4QwbW72d9Xb1sF9QsNa3ZPEbm5fhH/bfCOqTB04AKKEKqenCMenWQ/SvDT1CqPpIykHMVuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmwAfEbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmwAfEbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9CDC4CEF7;
	Sat,  7 Mar 2026 00:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842875;
	bh=uqHdwNgwIWQfBSHknp0uLe4ul6M3Tot+WSbz66G0te4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmwAfEbnQ1wSHbjNfaEJ42F5hwBgvwXS9sSph+A3kiUEaK/gwfCSZPcoDL5GCMrBi
	 g9yT+7VCQHdc8qDDa3N9PxpUUdxOJXLgg+rRf1boS4RH5hWsgTP07I0EFhm2h5ql0w
	 ghYrCGf5xMPPQe118CxJrclLXDvTq3hMfGreNsFJf95ekOjLYtaTlsbp5FwD5KhIJm
	 +rx7ZJRmCSrcdr1NrdNVLk8d8Yt70bW+onIGK0U1U6tNcrdzLc2KaUMKI42bDbNIom
	 dGDPDpmup4NuO3YcDgpyXzBIcVanBUng7QTL0GU7SS14S9E+DvbihG7eqg7MroKz+x
	 RfQdsChtexJ7A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 01/10] mm/damon/core: introduce damos_quota_goal_tuner
Date: Fri,  6 Mar 2026 16:20:46 -0800
Message-ID: <20260307002046.98992-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  3 Mar 2026 20:41:10 -0800 SeongJae Park <sj@kernel.org> wrote:

> Currently DAMOS quota goal feature utilizes a single feedback loop based
> algorithm for automatic tuning of the effective quota.  It is useful in
> dynamic environments that operate systems with only kernels in the long
> term.  But, no one fits all.  It is not very easy to control in
> environments having more controlled characteristics and user-space
> control towers.  We actually got multiple reports [1,2] of use cases
> that the algorithm is not optimal.
> 
> Introduce a new field of 'struct damos_quotas', namely 'goal_tuner'.  It
> specifies what tuning algorithm the given scheme should use, and allows
> DAMON API callers to set it as they want.  Nonetheless, this commit
> introduces no new tuning algorithm but only the interface.  This commit
> hence makes no behavioral change.  A new algorithm will be added by the
> following commit.
> 
> [1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
> [2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
[...]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e8c44541754f7..c5503fdb10bb7 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -432,6 +432,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  	scheme->quota = *(damos_quota_init(quota));
>  	/* quota.goals should be separately set by caller */
>  	INIT_LIST_HEAD(&scheme->quota.goals);
> +	scheme->quota.goal_tuner = quota->goal_tuner;

Because scheme->quota is overwrote with *quota above, the above goal_tuner set
is unnecessary.  I'll drop this in the next spin.


Thanks,
SJ

[...]
