Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B94756CE
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397343; cv=none; b=vFPQZB8TZPY+z+iu5uTmiNkpO/1B9dkioTiprhLd9sP5QXsc9VbNz1NfTG+1jmVi94+rGaKd+jIJBUyxIS5Z0p3cSzq5Tr3QWEjN6xZG5485Ao0PczGjl/nOMGXtyre6/U5Lg+1QtQ1YiSfsrjJb1gIrTizPOihoxSXRmPtJfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397343; c=relaxed/simple;
	bh=Q264ldo2SLs9zQNyEPjPah4HRlE7AxdX1luMla6UuKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQMfhPa0/51dwMkD8gVvG2CFHLIG2CnFrAC4tTyK4SPf66v8wdNvdUYljWd75vk66ZS0Xcoua2dWp4GslSGK7qyzasy+SUIhwPXQSSgQeYyj0AUx+sH3SQ/oadtf1h6a8/+GiLL9MNKAWhmAxs692cFfpalADFSk1RIh6pjLwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLMUxxH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLMUxxH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4B51F000FF;
	Mon, 14 Sep 2026 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397342;
	bh=j08RgwgUZ+BACSUY86hRWyXGI8NO/2l2xLz5R6Ox89A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLMUxxH0IFWDA8vmSdrfwufEoG1aRNzdiOsJ8zz+krzye5ehDrtMEi0iCfnoZDzX7
	 2qRuAw+78CTPqVpHZq5y0HeZBiUakD4Dnzyu/unTx/Xnf/YvuEsxtSqAYpymSwn36G
	 mIpeP9VFTVGI4w0r831DMiEee6rYX+BbscykIb8RGl3t2vkcSdB4IegngXqXxag9O7
	 jOFPLlKKuXf8pxnTS2j5X+y4tKSi/cqZrjzNiHAfs5COoj5asZbUIqI1L4GqezhN6d
	 Wh/n5yoQyC6gMHgAqw/kf0EQwEIcEDpM63UBB/QoY5QMvfr9Bu072hYN4i+4w93P58
	 tD8KlLischlkw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/6] selftests/damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
Date: Mon, 14 Sep 2026 07:48:53 -0700
Message-ID: <20260914144854.94549-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914143741.AAC251F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 14:37:41 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch incompletely fixes PYTHONSAFEPATH compatibility by omitting 3 out of 10 DAMON Python selftests, creating an inconsistent state and a commit message mismatch.
> --
> 
> commit da82d013622fc33202048b811231e1ede806c92f
> Author: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> selftests/damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
> 
> This commit adds the script's directory to sys.path for seven DAMON Python
> selftests to ensure they can import the _damon_sysfs helper module when
> run under Python's safe path mode.
> 
> > This breaks all 7 DAMON Python selftests that import the _damon_sysfs
> > helper module located in the same directory:
> 
> [Severity: Medium]
> Are there additional DAMON Python selftests that also need this fix?
> 
> The commit message states there are 7 tests, but it appears 3 additional
> tests in the same directory also import _damon_sysfs and were omitted
> from this patch.
> 
> For example, in tools/testing/selftests/damon/sysfs.py:
>     import _damon_sysfs
> 
> And in tools/testing/selftests/damon/sysfs_refresh.py:
>     import _damon_sysfs
> 
> And in tools/testing/selftests/damon/sysfs_no_op_commit_break.py:
>     import _damon_sysfs
> 
> Will these scripts still fail with a ModuleNotFoundError when run in
> environments that enforce PYTHONSAFEPATH=1?

Agreed, but not necessarily a blocker of this patch.  I will separately work on
the other tests.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914141952.91465-1-sj@kernel.org?part=3


Thanks,
SJ
