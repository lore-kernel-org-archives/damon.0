Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91C05427E5
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655790; cv=none; b=laiSW6uRkJ2XVBGMje/hcUBPr9A3Zfy6rztFDOeXAKMdgDhXDv6FNSUwUoFXRWmpiatundegRi9zj0FbhAT+H6uywkGn1qhzTFE4RBLgsKbQo25DlZH/MfRnYvZL/ztJFBmGxURY5t6MY/rOn5ri+CNyykTcv3CYiA4vgvo0Zq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655790; c=relaxed/simple;
	bh=qJ/uqibJqe2zdaxGKUNuOMLUyHL6mJ0DHN4iMdatOyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdtMPvS1Vh1CGhF1345Y9Mh8LRq48n0mlQS9lF4LgHVKYJPmo/oA17FMjGVX9zer2Tt/SqajkkFbE1vxHDBYFoKqw8rTvNwDYEVGBXqNTr5rqmpP5MFpMUNlnmHlGYOGp1r86lUbNePWJe4wZRs2m9i0vQHoqKzWEpIIsWjTKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcA8jHKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcA8jHKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0D1F000FF;
	Thu, 17 Sep 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655788;
	bh=OjV6+bhpfO5u2skqHjNZEqzbRLADrXNQZCOfOh4n8f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lcA8jHKP09Sm5GsM3rbp7sWqITVHiLR19538z9qLMM3OcbodiMhAJUP3FTmfrNufP
	 Bso5Q6wbQK43W3zUglgvLvfelPcNDTD7FpYeNKPrsmL2sQwMtlMOAyuiVLJbXDOacA
	 6ZNmRuleXVFSRvDQWz8RwetE0Xz9L/KkUfy0+y82j/V6dWsQI0oIf16gfRQjPt5GgV
	 OGUTK5K7UnDpE5g3+tPl7YRItQLSZUrz+5T8Tk7Qj3xvBc5RkK6ILmp0SadfVJ2+w8
	 XfjFV2fQgCjAhiTpd/9CWlUN00MdTnbss2Y5J/iF/VgwTP+XIkxk1ioWE6ZExau72v
	 lkAiC0hGG+lSA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 09/10] selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
Date: Thu, 17 Sep 2026 07:36:19 -0700
Message-ID: <20260917143621.91542-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917143154.DC7301F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 14:31:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/damon: test falsely passes on minimal grep due to --quiet flag
> --
> 
> commit 3a025795f6efb7b8edc7858f005049159a83efbe
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak
> 
> This commit updates the DAMON sysfs_memcg_path_leak selftest to explicitly
> check the kmemleak report for "memcg_path_store". It exits with success if the
> leak doesn't appear to be related to DAMON, reducing false positive failures.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > --- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > +++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> > @@ -41,5 +41,12 @@ if [ "$kmemleak_report" = "" ]
> >  then
> >  	exit 0
> >  fi
> > +if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet
> 
> [Severity: Medium]
> Will this script falsely pass in environments with a minimal grep
> implementation?
> 
> If this selftest is executed in an environment (like some BusyBox builds or
> Alpine Linux) where grep does not support the GNU --quiet extension, grep
> will exit with an error code. 
> 
> The ! operator will negate this non-zero exit code, causing the condition
> to evaluate to true. The script will then enter the then block and exit
> successfully (exit 0), potentially masking real kernel memory leaks.
> 
> Could this use -q instead of --quiet to be more portable?

I believe modern test infrastructures support --quiet.  So no blocker.  We can
revisit this if there is any report.

> 
> > +then
> > +	echo "[WARN] memleak found; apparently not from DAMON, though"
> > +	echo "$kmemleak_report"
> > +	exit 0
> > +fi
> > +
> >  echo "$kmemleak_report"
> >  exit 1
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260917142210.90829-1-sj@kernel.org?part=9


Thanks,
SJ
