Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01434041F
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297480; cv=none; b=fSFRkTTNPNCtoOS0X2IyLPyju0dBoxoREadHke7jxYZ01DZnXsyvZdk9+rd3F8NzV4wwjUuwO8qyG5/YrLZChx60mj40myd6x8xfLqJ5KAvGfJ/3qF5eEiTa8KNpv2HCD/SXnEqqlbH8a/SI8OxirFgoGgaLFeJkTFYerpFgK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297480; c=relaxed/simple;
	bh=r0I5Om6N53rp+nNSKuCKXBrOJko03nqO3k+JLyx99Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocNH2SmzqrlqB6A0Jk5IF8mWJpwsHycWfs+BEsmEt0G4VZ1FYf97iPZQtFhBydhKPJD03I1D5CspgEONnQUsJDtaaDcqdz3XUaLiZMXvz43IBTOsjoK9SYLGOMk7TT75Kq6h50cYLyheLX0hGP/1cifzBtX34PpgIzYDD5K5+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqqI9HJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqqI9HJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9511F000E9;
	Wed, 29 Jul 2026 03:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297479;
	bh=tioQqtjq8FqVCZXqjAXczLgFQsKdOYzX/ea/h+AJ3Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqqI9HJGpyKzYRcbfKJpbiGjMSQ2LTe/rIkU/S+JFPiyOfpfzLip+AYpzH7l7cqoy
	 ZB9t7QLHfav+SSiW/v2s/hxVbzUbWlLsfRTsnxEwPC5TycxpWYOprJTGiQnwhc/P9q
	 gRgPPjov93aHp1Sn+V3vUX06o9nIjDeQcT6l0V1lvK0vN0eBL/b8psH4ZGcE9efEQw
	 SNzLhSbVmwyHT+veJ4ztULoRAvjD0Pxn5vdle5ml6+PeVozZjqLayPDhXeuRhLenBr
	 YtHzUNxANKh+U31mw4Wg7H29FaLxyOtTty8hqcykvJwBpUsASoEofyxtjWmgr4adJU
	 R5jmONyruj26Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Tue, 28 Jul 2026 20:57:46 -0700
Message-ID: <20260729035747.131791-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729034505.933E51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 03:45:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest script expects the kernel to accept the 'hugepage_mem_bp' metric for the DAMON sysfs quota goal, but the corresponding kernel feature implementation is missing from this patch series. Writing this value to the `target_metric` sysfs file will return `-EINVAL`, causing the test to unconditionally fail and exit.
> --
> 
> --- Patch [8]: [RFC PATCH v1.1 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal ---
> commit 6c11ff9f30e87caf7ac58e12f507a641d985aebc
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
> 
> This commit updates the DAMON sysfs selftest to verify that the quota goal
> target_metric file accepts the new hugepage_mem_bp input.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > index f7fb94b84e716..8690aef1e436c 100755
> > --- a/tools/testing/selftests/damon/sysfs.sh
> > +++ b/tools/testing/selftests/damon/sysfs.sh
> > @@ -210,6 +210,7 @@ test_goal()
> >  	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
> >  	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
> >  	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> > +	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
> 
> [Severity: Medium]
> Will this test reliably fail because the kernel implementation for the
> hugepage_mem_bp metric is missing from this patch series?
> 
> If the corresponding kernel feature isn't included, writing this value
> to the target_metric sysfs file in test_goal() will return -EINVAL. This
> would cause ensure_write_succ() to unconditionally fail and abort the
> selftest.

This patch will drop RFC tag only after the hugepage_mem_bp implementation is
merged into mm.git.

> 
> >  	ensure_write_fail "$fpath" "foo" "invalid input"
> >  	ensure_file "$goal_dir/nid" "exist" "600"
> >  	ensure_file "$goal_dir/path" "exist" "600"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729033751.131213-1-sj@kernel.org?part=8


Thanks,
SJ
