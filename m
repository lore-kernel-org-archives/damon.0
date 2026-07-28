Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187912673AA
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218171; cv=none; b=h/DZLMywN8+aCseDfIWCFACHHvymbtfIBdP54rJB8RA8osril+TfjPF4xzwMROITXnkWMxYi7w2m4vv73O7fCaMKCmTSAfhNZ7CXXNbtuYKwtnsb++Iv5QD+/kdghMDSRoiZJwT3aEtt++sMc/Qxer5bHWAW8JaX2Wuufo3bAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218171; c=relaxed/simple;
	bh=5jnnPB5AH5zCJaHVGMsYOMHmsIrIXYOhcwu4Hg9LLCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkNt2nHMHHvEnTU7F1I4BFb60i3ki6u39ytDg70JC+2m3j37VLCr0Jy+LTs8omOh1qapLecqH6YHCR0zMRpIZP03ccasWpZiDXiD53+wwqKZI/F35mwY6bIgnJz8C030hanXserdYsrpTYXBbIRMQGH+EzjiS63vBSmG+P8Drv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhbDyQr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhbDyQr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901D21F00A3D;
	Tue, 28 Jul 2026 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785218169;
	bh=ZjA0Y/e4n2LirVAqITJbEkbtZ3Ma99t/S6S/fDkEGo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WhbDyQr7dnJMLnMQ9/bUsoU4CkMeXZNVxVmHymb6VOLOun9tSuOPN5FEsE8bm/c6d
	 9BkjzfU29GiDjyqdEVvJVooQHpgcH5hacKDDit1lHjlfI12ImTe2Y0CbTDKBXqdLMi
	 cEqS5vqCpoeeHGSvwBPZxmvhHucAjwv7nzH0rnBgRuKxQB0kVx8T7sT2RBcQ7FOr5W
	 ok4L4GJlmAoOoVEmruoQ+NJpBRw23i1U27HgHP1ctp86asgPrmCuQwgfaypYJIHdp0
	 aaRAgL6oHHPH7bdvBYaH2EnuMYYiGzfcf2ewbkd6Mszei6uc50jiMn/a8o5PhXYudF
	 fy3selaeuDtRw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
Date: Mon, 27 Jul 2026 22:56:05 -0700
Message-ID: <20260728055606.211413-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728053533.B293F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 05:35:33 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest unconditionally fails because the kernel implementation for the 'hugepage_mem_bp' quota goal target metric is missing.
> --
> 
> --- Patch [8]: [RFC PATCH 08/10] selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal ---
> commit 033ea051e9d9dfb2787f833f5569853c4af61194
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal
> 
> DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
> input. Test it is accepted in fundamental DAMON sysfs file operation
> selftest.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
> > --- a/tools/testing/selftests/damon/sysfs.sh
> > +++ b/tools/testing/selftests/damon/sysfs.sh
> > @@ -210,6 +210,7 @@ test_goal()
> >  	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
> >  	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
> >  	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> > +	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"
> 
> [Severity: Medium]
> Will this selftest fail when executed?
> 
> Looking at target_metric_store() in mm/damon/sysfs-schemes.c, the kernel
> validation loop returns -EINVAL because "hugepage_mem_bp" is not present in
> the damos_sysfs_qgoal_metric_names array:
> 
> mm/damon/sysfs-schemes.c:target_metric_store() {
> 	...
> 	for (i = 0; i < ARRAY_SIZE(damos_sysfs_qgoal_metric_names); i++) {
> 		struct damos_sysfs_qgoal_metric_name *metric_name;
> 
> 		metric_name = &damos_sysfs_qgoal_metric_names[i];
> 		if (sysfs_streq(buf, metric_name->name)) {
> 			goal->metric = metric_name->metric;
> 			return count;
> 		}
> 	}
> 	return -EINVAL;
> }
> 
> Because the test assumes the write will succeed, the missing kernel
> implementation for this quota goal target metric will cause the write to be
> rejected and trigger a selftest failure.

Implementation of hugepage_mem_bp is not yet in mm-new, but will be merged
before this series.  So, no issue.

> 
> >  	ensure_write_fail "$fpath" "foo" "invalid input"
> >  	ensure_file "$goal_dir/nid" "exist" "600"
> >  	ensure_file "$goal_dir/path" "exist" "600"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728052811.192712-1-sj@kernel.org?part=8


Thanks,
SJ
