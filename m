Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDE4E3EED
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744320; cv=none; b=QJ1LLZkwDEKdMMPkjqGJY6ghi0WZXdy76atrWLbSv7Z0ZJytbVHQuI1QKoBPp38Rg6l3PR4mH/KoZoQMBZrFXJV/UAGIjaS/xVKCvqtYB97Ooz4fjT5gBVRNzTDvVTu8x8Z/+prYBDbVBlvRvnnF05/CO1jqrlO9Xpqc9EM4cZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744320; c=relaxed/simple;
	bh=10zylOM7wFagfwjJjaMC/88ii6Ean73XQb02ymPkHgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D85hptlx1KQpHGNBmkgaIHv+jZZVKcl6gCNoMSpLeF3ReD3lwRoE27Qq9R9ffNaZ8nPtC0xGB4LJiAZ3Nn87zhAcY/wxTLKSJR/zUKjooziqQoOtmVHuTXDGUEs7G5cqi1gKvB4JTyR0cle6IAPUvr7fnDhMQ8uZB0VUm90Rdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3CIq8So; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3CIq8So"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB261F000FF;
	Fri, 18 Sep 2026 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744319;
	bh=iA4QwNw1SWoc+P5WG+Lo4+7uGZ7EbKYK0QHuP9jDUcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U3CIq8So445Z/7y8hTtkGsKaPP32Lardcv/PerUse+2sDiLUMJJa9aW90EIuWHPJY
	 oBku9FnFddgx33VDNKHnJa2dLJcihXF2YaldDenYgeFZ0OXFD/Od05OvuqmE7eV88y
	 SbNrnssxZxhcQkB0SFngESkZOZjl/ehmHhU2vePUQALXgj7cv7fHOQwg9KePi0zuOf
	 RJqD3tomsxgKiwFAzRXzQwvVs+XLGKnbrL/lSbnqoYw6WM2iA7iWtz8h1HfqFiRnn5
	 vbF8qcNBUi5YzVjD6V/5BifMcR3NfFwAIqA+g8j6b+Et5sbGKaUDkN9hxstYuo9XgN
	 fzCQ2DeTo0pEQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 6/7] Docs/admin-guide/mm/damon/usage: update for quota goal complement file
Date: Fri, 18 Sep 2026 08:11:51 -0700
Message-ID: <20260918151152.86571-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918150934.1CC5B1F0089C@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 18 Sep 2026 15:09:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] damon: inconsistent file count in usage documentation
> --
> 
> commit 3ff19ca809eb7c0b839b503a68fe82c349a81160
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: update for quota goal complement file
> 
> Update DAMON usage document for the newly added quota goal metric
> complement sysfs file.
> 
> > diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> > index ba47255448564..b3f2e591fb7e4 100644
> > --- a/Documentation/admin-guide/mm/damon/usage.rst
> > +++ b/Documentation/admin-guide/mm/damon/usage.rst
> 
> [ ... ]
> 
> > @@ -493,11 +494,11 @@ to ``N-1``.  Each directory represents each goal and current achievement.
> >  Among the multiple feedback, the best one is used.
> >  
> >  Each goal directory contains five files, namely ``target_metric``,
> > -``target_value``, ``current_value``, ``nid``, and ``path``.  Users can set and
> > -get the five parameters for the quota auto-tuning goals that specified on the
> > -:ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
> > -reading from each of the files.  Because the kernel does not update
> > -``current_value``, reading it only makes sense when ``target_metric`` is
> > +``complement``, ``target_value``, ``current_value``, ``nid``, and ``path``.
> 
> [Severity: Low]
> Does this introductory sentence need to be updated to say six files instead
> of five files?
> 
> The patch updates the next sentence to say six parameters, but the word five
> in the preceding context line was missed, so it now contradicts the list of
> six files that immediately follows it.

Nice catch!  I will fix this in the next revision.

> 
> > +Users can set and get the six parameters for the quota auto-tuning goals that
> > +specified on the :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by
> > +writing to and reading from each of the files.  Because the kernel does not
> > +update ``current_value``, reading it only makes sense when ``target_metric`` is
> >  ``user_input``.  Note that users should further write
> >  ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
> >  directory <sysfs_kdamond>` to pass the feedback to DAMON.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918142827.85303-1-sj@kernel.org?part=6


Thanks,
SJ
