Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12D1E505
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512605; cv=none; b=f32Pkzs8XOmlCYga1mk6nRmEgHzkNguslnsj34VzJPHdSUqjutGInsYjhJik51FTmj1DuTJ7kSTESYvJ8l22rEpXewdVnZYn8g2bonRWO2oiNuK/UcpGgW2wi09NjQ4VzeDxvIzqmM9eRbIefbnxb1YywUBV5LUri/nVMkNH88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512605; c=relaxed/simple;
	bh=bedIuJdtGM23XzUDEafSnQLY1iM2i7Xju6kXnF8UNNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnhi9X/wiG6VCRlQOtjK8npfKsUJr2uupEWBhmRKTuqM/rxnRbn7DTZMsg7UWm2j34Cpa9fm04RB3e4WK9f3HqxHDmbgkBViC7eIDOKuApLUm4XFFntTR/ZRgGmpL4WBXVt9mGE38eEIIccR3hUGolIIRHUM2XHfOkci3tSoFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5nhkrTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5nhkrTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BE51F000FF;
	Sun, 27 Sep 2026 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512604;
	bh=pSTYUVwjSCb6nnimizRy9DXfdot1ZZzOj0AxhxbRowY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5nhkrTexhVNVOk3Tuk6fcG5e+pOkykHydpZG3isj76Q69ao5wQTlAmAJQnQO2ShL
	 /3YDKLuMmHdj7PIWwiY9CiktiS9gLyQKl8Sm8RXKrciWTKE1JKDnoFL5sjGvMnHLGL
	 k2IiWtBUyw4feomF1yjeYXWn4nuwpfwlWlxKB0ZAfTM0RwjYsxt7brvnnbpBNZCZNo
	 xV+pfcdOnoCcDR2qjLY/AtVtnvHFOoPrGEtW1ZIFpk0wZ9/ZEsu4UJRSQJPipm84fz
	 uEaj03rBdHIaPYrrI1DiQ9UDfgiXcZHNEuD5A0kNQ+3Z32k30ExXMQDtP5aAvZUpOh
	 wBTW9HoyMIqqQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v4 6/7] Docs/admin-guide/mm/damon/usage: update for quota goal complement file
Date: Sun, 27 Sep 2026 05:36:38 -0700
Message-ID: <20260927123639.58955-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927121315.31CEC1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 12:13:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] damon: build error in core-kunit.h due to typo complementfalse
> --
> 
> commit eec8b1a2e73ee2822f8574a7a1b78a43cc0fed67
> Author: SJ Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/usage: update for quota goal complement file
> 
> Update DAMON usage document for the newly added quota goal metric
> complement sysfs file.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index df84d9cc7d204..6a13d9bd377cb 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > @@ -930,6 +932,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
> >  		 * Make it kfree()-able.
> >  		 */
> >  		goal = damos_new_quota_goal(dst_goals[i].metric,
> > +				dst_goals[i].complementfalse,
> 
> [Severity: Low]
> Does this regression cause a compilation failure when building with damon
> kunit tests enabled? It looks like struct damos_quota_goal has a member
> named complement, but not complementfalse in
> damos_test_commit_quota_goals_for().

I will fix it in the next spin.

> 
> >  				dst_goals[i].target_value);
> >  		if (!goal)
> >  			goto out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260927120533.50484-1-sj@kernel.org?part=6
> 


Thanks,
SJ
