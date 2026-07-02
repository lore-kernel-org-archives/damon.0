Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D123171AF
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950979; cv=none; b=Wzq75k6S8THNQkfkwj3Xo6qn6NtOPZ1ORhtsDFgukptMdixLskoq8jUqEkaYW/WtRt1NbdiRqkl9uwEARXzqbA6t1uFJ1nYNRzFBwUGQi6sUN60J0F3MxJckCv/asVe6Cs8GBpSvhTZvDw4BGfwHTfsY4WsZ11TV03St1OM0MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950979; c=relaxed/simple;
	bh=Ulzggxnjey6+MgG2BJqL91jdO49LNHJMB511SS0AqgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9bCBTuW7wB1TE9h45VhlbMRvZ6Oc4OJiBvBNhBjD+UFXZUpQVUk2/D1xiyzgdA/o37I28kKWUWcEjcfodM0sEtU0985WbU45sHaPpekZLDJPTwCMIkNmhMhx5d+EK3aythjZIf7poaEac2E2Ka18ZafyUrJgi23QG7rWYsL1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP6odtY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP6odtY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B61F000E9;
	Thu,  2 Jul 2026 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950978;
	bh=PhDhY0wa0+sjmpzLziAXPeRTYTvJIebdOB2FgAFHFh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dP6odtY1rsZUNJ4sI4rLkTIOkrhnMfMtw/PPBYB4kGufzoJWAQXd0sjT0Wvsp7i05
	 1+mzXzzWVczdY+zTudIW+5iaEOuDHnWAmOmB2zqxYbivfR8LkLWY8E7FBREm8CJ7Wk
	 06gvVtDnZrBNapgKrutZbN55OTBk3kwp6T1lSr1a37wUooZ3b+P9X+nzLA0mtapVDX
	 EdNhQrTuGFLEOCRIc0uTzN6uTPkEak+KyZPly3fcAm152jYVYb19ApWtADsFcT56la
	 XtuBBmmBt2xUcSCl6wps+9NxmOohHxtHnACHd8zD//Ok1tfUaCpINhbzKFi3g6chl2
	 FUfjli72zKIXg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/8] mm/damon/sysfs: remove duplicated commit input validity check
Date: Wed,  1 Jul 2026 17:09:25 -0700
Message-ID: <20260702000925.86443-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701152903.DD8D51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 15:29:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the explicit `test_ctx` parameter validation in `damon_sysfs_commit_input` exposes an underlying flaw in `damon_commit_ctx`, allowing invalid sysfs inputs to corrupt the running context and terminate the background kdamond thread.
> --
> 
> Note: Due to system limitations regarding exact code recitation, this report
> uses a free-form summary of the issue rather than inline patch quoting.
> 
> commit bec0828fbe945683bcef8cfdb56247414f2510d8
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/sysfs: remove duplicated commit input validity check
> 
> This commit removes the explicit test_ctx validation inside
> damon_sysfs_commit_input(), assuming the same validation logic is safely
> embedded inside damon_commit_ctx().
> 
> [Severity: High]
> Does removing the sysfs-level test_ctx wrapper expose the running context to
> corruption from invalid user inputs?
> 
> In mm/damon/core.c:damon_commit_ctx(), it appears the underlying validation
> logic tests 'dst' against the temporary 'test_ctx' instead of testing the
> new 'src' parameters:
> 
> damon_commit_ctx()
>    err = __damon_commit_ctx(test_ctx, dst);
>    if (err)
>        goto out;
>    err = __damon_commit_ctx(dst, src);
> 
> Because damon_sysfs_commit_input() now relies entirely on damon_commit_ctx()
> for validation, what happens if invalid configuration parameters (such as a
> min_region_sz that is not a power of 2) are passed via the sysfs interface?
> 
> It looks like __damon_commit_ctx(dst, src) will fail halfway through, returning
> -EINVAL but leaving the running context with maybe_corrupted = true. Can this
> cause the background kdamond_fn thread to silently abort without recovering,
> effectively resulting in a denial of service for the monitoring session?

Correct.  I will fix damon_commit_ctx() side validation in the next revision.


Thanks,
SJ

[...]
