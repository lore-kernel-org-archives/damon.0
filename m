Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158F48034C
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520762; cv=none; b=dlOUWPlBZK9gRVbc6/cd73AUmIRxobxu1PrHC6UZ2t+H/5PZ5Cl/ZcsuD6oesrlNgDzYHYh+ICMP13kcnJPuoTgtI6b+FxVIih9dlgtFzuxw0ApoY6Kg97WbsnVstGl+Z8EMLvscQy1WTjoql55JE0pP+Wl9RgFwhCFvxg1q8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520762; c=relaxed/simple;
	bh=7mbhraUL8Q5wMnCl/4dTYQlByIwiMOI47tuNhJ2Dfb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBHH0mWeMeIlrS5KLOMziuwfP8DOLm8Hc6z66nbEt4mKibawSQcomwAltbJwSSHr17RoXedabAGTq2TIuoDbO18E7+yGeJISqORA6gn+HkkhoqT6yjkVXc/2GJbEiYc7pnRmCM7P8mLMahytJneMp3Ymfqm+me93KYFqI+duALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAPmqlP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAPmqlP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F6D1F000E9;
	Wed,  8 Jul 2026 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520761;
	bh=D9rAYRvPPTIGXfCFgAXUwapTza03puyPnObv9hx9j+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAPmqlP0B7tEsmq1zxgYU3mByWOjRlNaWL5qPJBEoH43fZ7bJCDd50aCiD0x3mZID
	 svmF12XTkO+WMr34u51H7wYYkV1SAM/s5cFhQHEgG2oEYgmFzvA//k4arQ7K+TH31C
	 0BhDZYX8gr3g/OO548zqbr8BBunDSkzbs728V7p3/kT/nMrbGM/UZnah1NXXwvSAUT
	 U4p0uxsiisy5Pf73DCOf2yZoVVpto8OPt1AQ6PBCrXfZPyBtPkWou+c/ZztERemgwE
	 JgJ78Rr6bSXFxZaUJehgvcDMg4XtKQJs54ynDaHVtLHbXRoOcoSJf+kKADhMzMZsif
	 NNCWNcAoJLyfg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 1/7] mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
Date: Wed,  8 Jul 2026 07:25:56 -0700
Message-ID: <20260708142558.123894-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708141335.C33741F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 14:13:35 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The commit message incorrectly references `damon_nr_samples_per_aggr()` instead of `damon_max_nr_accesses()`.
> --
> 
> --- Patch [1]: [PATCH 1/7] mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero ---
> commit f8fbcab0a03e83756cdeec775b4f0bc25f753341
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove comment and test for nr_to_bp() divide-by-zero
> 
> This commit removes an obsolete comment on damon_nr_accesses_to_accesses_bp()
> and its associated kunit test. Previous changes guarantee that the interval
> calculations will not result in a division-by-zero.
> 
> > The comments on damon_nr_accesses_to_accesses_bp() and its unit test
> > warn it can trigger division-by-zero when the aggregation interval is
> > zero.  Commit 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme
> > intervals in damon_hot_score()") modified damon_nr_samples_per_aggr() to
> > always return non-zero.  Hence no division-by-zero of the note can
> > happen.
> 
> [Severity: Medium]
> This isn't a bug, but is the function name referenced in the commit
> message accurate?
> 
> The commit message states that commit 35d4a3cf70a8 modified
> damon_nr_samples_per_aggr() to always return non-zero. However, the function
> that was modified and used to calculate maximum accesses is
> damon_max_nr_accesses().
> 
> Could this description be updated to reference damon_max_nr_accesses() to
> prevent confusion for future code archaeology and maintenance?

Good finding.  I will ask Andrew to fix when he picks this up, unless I find
more issues that deserve v2 of this series.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708135359.122587-1-sj@kernel.org?part=1


Thanks,
SJ
