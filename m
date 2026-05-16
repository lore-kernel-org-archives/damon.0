Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561581448E0
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892107; cv=none; b=GXKaBd6QIvB7kcwBQnqqjAVmBvbXndkkIkiNSheKD2hSm+SDxS1Uji2YX+wCeZgeSET+RN4tfbH4A+ejKZU8dLzPBzxEC4VS9zsd9xEMy8FaVwX/gE1LREvrXSZH+Fvq0BFHkX0Nfei2xMkZeaRTdRCTK/Qqc8VqdipWQzjErSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892107; c=relaxed/simple;
	bh=UuXciB8KHAajyPkccQq4ieF8gl8rSgSizNT5YSLPHKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPs/THXKeoSPg5DMfIKzV/XBiK95X8KNNU6csbFbRpAyvWUz7r/SSVUIA/9n89hRdwEC8Kw6uDTFP+uSF4btM+MhI0V+YW0r7eBTJ6s636nCTZueIcNsi4Jffvs7R0RIl1d38lXaUoyuoNipGI3Va+b4zFXdfxBa4eP+RikO3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb4GwgZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb4GwgZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF3C2BCB0;
	Sat, 16 May 2026 00:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778892107;
	bh=UuXciB8KHAajyPkccQq4ieF8gl8rSgSizNT5YSLPHKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cb4GwgZPm8qroraPyaq+cvOqXnAr5Z1fNTK7czeKmPB44222Gx7IUpOh21jnkzaVb
	 nOZmoQadGLBcuduXOXtxbeSGPYiUzNCrWqrWtZYg5kY18SdJD2508opkR3JpC1cann
	 P9v6U16sak4RtnC27DYYUCzBuZjHOsVJ1gjDX+GWlzNitEtwKW1lfms/U0CVvP1UcD
	 PUwNB5+6WOhHcZIYWzzOEO5L5bSJCZqb32HlE9wQKJpD8jCLFg+iA9d8Kjs0abz1Zj
	 lZUB164fFm/TZfGybwJDK49etvdnth1jCbCytzZKRJ528x7vhXAPxEmfK9HzmL5qSG
	 JTZj2Xc7o0g1Q==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 06/28] mm/damon/core: introduce damon_ops->apply_probes
Date: Fri, 15 May 2026 17:41:28 -0700
Message-ID: <20260516004128.141899-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515005345.4A730C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 00:53:44 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Missing detailed kernel-doc description and execution flow integration for the new `apply_probes` callback.
> - [Low] Mismatch between the callback name in the commit message and the actual code.
> --
> 
> commit 3622281217bcbb69d269a9ab7a22730a743ca395
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_ops->apply_probes
> 
> This commit extends the damon_operations structure by adding a new
> apply_probes callback. This callback will be used for monitoring data
> attributes, applying damon_probe objects to regions, and updating counters.
> 
> > Extend damon_operations struct with a new callback, namely apply_probe.
> 
> This isn't a bug, but there is a slight mismatch in the callback name here.
> The code implements it as apply_probes (plural), while the commit message
> calls it apply_probe (singular).

Nice catch!  I will fix this in the next revision.

> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index bf78ad849a9be..36a1162b6185a 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -621,6 +621,7 @@ enum damon_ops_id {
> >   * @update:			Update operations-related data structures.
> >   * @prepare_access_checks:	Prepare next access check of target regions.
> >   * @check_accesses:		Check the accesses to target regions.
> > + * @apply_probes:		Apply probes for each region.
> >   * @get_scheme_score:		Get the score of a region for a scheme.
> >   * @apply_scheme:		Apply a DAMON-based operation scheme.
> >   * @target_valid:		Determine if the target is valid.
> 
> Looking at the rest of the kernel-doc for struct damon_operations, there are
> usually detailed explanation paragraphs for each callback, as well as a
> paragraph describing the overall execution order in the monitoring thread.
> 
> Should this patch also include a detailed description paragraph for
> apply_probes and update the execution flow documentation to clarify exactly
> when this new callback is invoked during the monitoring loop?

Good suggestion, I will do.


Thanks,
SJ

[...]
