Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CA1DDA3E;
	Mon,  2 Dec 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166097; cv=none; b=Xj6SNj1pbXZuC0ueTvuw9DTlizavutSaYAIkN+3qsmlWOdifWY1yCUqcqwkMe7KAFqEyhT2UpC8urnDXPGH8fJPkiKm5cY1hY1PvSHm8m6WrfUoTCRbpDvaKGqV3M7mJeK2ZvFG3dw43L86PXTzYCycvHoHRn+DBACidInpXpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166097; c=relaxed/simple;
	bh=hlkKtQX70izKeupKKgD8g9nbfyFBVWQ6P+NaxJf2roc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BE2G+G7t7R0H0CCu+jWSncwF3P3os1rMiMXejCSZiEu+tbv2mj4ngWsON72GmEn6669gTzniRQPE7OrlQ5WoU7YpcMBsGwMt8QAeW/ajk7u131mVuahsG7kxu2/cS5UXBQr+qqVhGuGVyIWemuM2/0EKqX9zGcbVHiUD7blvXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQS2aGTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQS2aGTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E5BC4CED1;
	Mon,  2 Dec 2024 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166095;
	bh=hlkKtQX70izKeupKKgD8g9nbfyFBVWQ6P+NaxJf2roc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQS2aGTWhi7/7AqfDYsH7mJsin87fG7N9a1QuwKce4FciMwTLQjdo6ZFU6jyZeNj6
	 SNB6RftlNdYuo49Oz3zokwyKFcaXnWLi7v/60FVSzqjT9LY1KPs8GkSRGwi68twg84
	 ZaVPAQQIHHGXu8NIvJ3WxBIct6lYRzJ0msb9Xd4HgNg1ocKO35q2bGQEaREjDRSvU9
	 7YMwaNrSkdrDnD/41hOGQwM3uNDw5uc4AqcXVFP7ScN3E744QSizJljxYF40BpRR/F
	 BgRK8b7Bw6Uz5/Czop2QbaJ5y50Tjr/j9B+coas9cUMKCG9Pq4M6ofbvVYbfbSy6N9
	 +DEXSbKVO4x0Q==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 62/72] mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 'sysfs_schemes' not described in 'damos_sysfs_populate_region_dir'
Date: Mon,  2 Dec 2024 11:01:33 -0800
Message-Id: <20241202190133.57122-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202412020702.S7FyZSzV-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Dec 2024 07:55:43 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   b75cfd5260e9e512e1075267a70283e53e661357
> commit: 2385753a6db33141791a25d611e6e5b63a9ddc4d [62/72] mm/damon/sysfs: use damos_walk() for schemes tried regions update
> config: x86_64-buildonly-randconfig-003-20241202 (https://download.01.org/0day-ci/archive/20241202/202412020702.S7FyZSzV-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412020702.S7FyZSzV-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412020702.S7FyZSzV-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 'sysfs_schemes' not described in 'damos_sysfs_populate_region_dir'
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 'ctx' not described in 'damos_sysfs_populate_region_dir'
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 't' not described in 'damos_sysfs_populate_region_dir'
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 'r' not described in 'damos_sysfs_populate_region_dir'
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 's' not described in 'damos_sysfs_populate_region_dir'
> >> mm/damon/sysfs-schemes.c:2199: warning: Function parameter or struct member 'total_bytes_only' not described in 'damos_sysfs_populate_region_dir'
> 
> 
> vim +2199 mm/damon/sysfs-schemes.c
> 
>   2190	
>   2191	/**
>   2192	 * damos_sysfs_populate_region_dir() - Populate a schemes tried region dir.
>   2193	 *
>   2194	 * Called from DAMOS walk callback while holding damon_sysfs_lock.
>   2195	 */
>   2196	void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
>   2197			struct damon_ctx *ctx, struct damon_target *t,
>   2198			struct damon_region *r, struct damos *s, bool total_bytes_only)
> > 2199	{

Thank you for reporting!  I just pushed the fix:
https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=04df30e0d8b2a8cd60873ebaf029414a6bcc4643


Thanks,
SJ

[...]
