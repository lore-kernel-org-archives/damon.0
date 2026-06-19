Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F240D569
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828772; cv=none; b=BUodf6fXGy08xUQ1qSnYL7RgzLs33KW4Mg0bSnkNRruucBZaOlL4O1unruXhX7ZFlK/8j6Gipwr/3Bz7+CuEc9LrlFTb4X+xrNR1RK8P9ouqhglgt7y/Zsmo1nKMebbugTnTjgaMWLX7U/9duUaAiOqMByM73UJrI9w/2AdKE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828772; c=relaxed/simple;
	bh=x5N5U+PF7/5DzycgfZ/7ulD0+nsz0osYqKzeBjn+lqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGAhrTKh+wmm3B4MbU/w+W7d0V8M1NqrDlaJO1GMMgJmqLdbVn/7ptWA/GqzD4ewx3iUp4c7SU3a+dt7lhCFlqKlnTVYtvj1O5TeTkkExWvyv0lrhGA06zonfinAfYQwu1n+Cho2JBJXsHNgwgJ+4THt7j8yM77lt8ThqyZmtwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0eZn7LK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0eZn7LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6221F000E9;
	Fri, 19 Jun 2026 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828771;
	bh=OEczx7ZvJH95wzkSy9KFS48FNo9sZUxLq1c6O7Av4pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0eZn7LKbgyNNReeAKYwElqFr06fdWJPfo5/DDcS5ya8aPU78CeVQwO8RkwPgUuTZ
	 HLpqa4WTyRa2PXGqNPkM8EV9PIsVEIcinH42rbZ3CPWZ3Ec1rLW9fvPTHLk+nuFW0e
	 YQ+bL1MWNaZHKRMwW2zdsPhXW4axLnDNx7sQJE9YfgUE2TH1qVtGsrGolH1TK3mTSM
	 aWtmLHqEJMCqYP8DFDITXWuA3Q4Bk5nYR1UfXXq6m/CcAP4eMj2nCICqX6J97z7ZYl
	 Dv5MOBlHAwHYInScRthwGde7b90aHEptJReJKyFCAt4buvpr7QzBUqSXXpgpQkMd57
	 h5bZP6jfox0+w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 11/11] mm/damon/sysfs-schemes: kobject_del() region for populate_region error
Date: Thu, 18 Jun 2026 17:26:00 -0700
Message-ID: <20260619002601.8667-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618153838.5A6251F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jun 2026 15:38:37 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak in the error path of damon_sysfs_scheme_add_dirs() due to skipped cleanup of the 'stats' kobject.
> --
> 
> commit 73251d9a8366deae80fbc88ff7d3d42f79676704
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: kobject_del() region for populate_region error
> 
> This patch fixes directory creation failures due to name conflicts when
> CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It adds a missing kobject_del()
> call to properly clean up tried region directories in the error path of
> damos_sysfs_populate_region_dir().
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index ebc692682481d..0b8a6f1f6b9fc 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the kobject
> cleanup in this file, I noticed a memory leak in the error path of
> damon_sysfs_scheme_add_dirs():
> 
> mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
>     ...
> 	err = damon_sysfs_scheme_set_stats(scheme);
> 	if (err)
> 		goto put_filters_watermarks_quotas_access_pattern_out;
> 	err = damon_sysfs_scheme_set_tried_regions(scheme);
> 	if (err)
> 		goto put_tried_regions_out;
> 	return 0;
> 
> put_tried_regions_out:
> 	kobject_put(&scheme->tried_regions->kobj);
> 	scheme->tried_regions = NULL;
> put_filters_watermarks_quotas_access_pattern_out:
> 	kobject_put(&scheme->ops_filters->kobj);
>     ...
> }
> 
> If damon_sysfs_scheme_set_tried_regions() fails, it jumps to
> put_tried_regions_out. This attempts to clean up the failed tried_regions
> allocation, but then falls through to the next label.
> 
> Does this completely skip cleaning up the successfully allocated
> scheme->stats->kobj? Missing a call to kobject_put(&scheme->stats->kobj)
> here appears to permanently leak the stats kobject and its associated
> sysfs state.

Yes.  And I was separately working on this.  The patch is now added [1] to
mm-hotfixes-unstable.

[1] https://lore.kernel.org/20260618185830.978911F00A3A@smtp.kernel.org


Thanks,
SJ

[...]
