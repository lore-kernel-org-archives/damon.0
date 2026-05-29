Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE33FB044
	for <damon@lists.linux.dev>; Fri, 29 May 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067024; cv=none; b=cz7yze1HGIjhE1+JkpqsxKou8vbIDFQgQhncrYshuW70pPj1f1jzWwnfnZGq9nKxh69sOTezzK0gUkGtf0kTM+voUP3/23EmpXt04KRJwJM8D9ebjpSJ5hRDUXE9geNXWRxKiYKbUdVx9mJuM94tVP37vCPwoRIj4Y3EMSVlIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067024; c=relaxed/simple;
	bh=8qGauW02PbtYwvU7H48IilgzQ0FWVUg0Jn7hqyyPRew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIjTCth+HDpdIT59IjmWVGm1C0rthpTt+4BCYmRuWOD5D2XhfDsaMgDb7CWKyZsvfkQULkaFBOuo0WOp3YIre86TljUjAvz7Q09An121qLQMJX/E3qaLDucCzgUiEPD5508VTQcW4xqQz3t+y5ryiLcDSK2X5VAX9T8Ihm90JOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n24+eRSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n24+eRSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C761F00893;
	Fri, 29 May 2026 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780067023;
	bh=8U9n7S2YnGUunZ6WY808+AGKxv6WLqze2/PSf4h1Q30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n24+eRSuBLxykh7etJS/sCCQMiw2/bzvfeIVRHc+3/xzvbWbeLXXj5gxBOhPmHm7Y
	 O4DMn/+vjlLMBPTLBX8xIkKjKlhbqkb2yZii1iLuhbQ/p1+33ArJ9bZW5vCxrDkXrJ
	 +ZTOjEUYP73rcsDby8AfH5v+qz5pexKhdggCR7kiOJFsKUQyMaJ0EBCCLaMMOXmjfW
	 kohdj8SmRttiChioj3ltIrVnvOU1FAT5AI3y4xMAbnHpMFEmIxgJ3BYJrjzq8w0ulA
	 vDX2K9QvVbvxNWdXxHuatZJALJyhUrQn0j35HpVPDtWPiRSoCZkzJK4Rx+X5rh3RlC
	 thbWItjKwjheQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Cheng Nie" <niecheng1@uniontech.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 2/2] selftests/damon/sysfs.py: validate memcg_path staging readback
Date: Fri, 29 May 2026 08:03:37 -0700
Message-ID: <20260529150338.84890-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529094327.6D5031F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 09:43:26 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `test_memcg_filter_memcg_path_staging` test inadvertently depends on `CONFIG_MEMCG` and active cgroup configurations due to a call to `commit()`, causing the test to fail inappropriately on environments lacking them.
> --
> 
> commit 45ed1607d8ff8754a1a322fb6da3631cdc56f283
> Author: Cheng Nie <niecheng1@uniontech.com>
> 
> selftests/damon/sysfs.py: validate memcg_path staging readback
> 
> This commit adds a dedicated test to selftests/damon/sysfs.py that writes
> memcg_path to sysfs and verifies its readback. It aims to test the sysfs
> behavior independently of the local userspace cgroup mount layout.
> 
> > diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> > index aa03a1187489f..0f20bc9c46b78 100755
> > --- a/tools/testing/selftests/damon/sysfs.py
> > +++ b/tools/testing/selftests/damon/sysfs.py
> > @@ -250,6 +250,43 @@ def assert_ctxs_committed(kdamonds):
> [ ... ]
> > +    context = _damon_sysfs.DamonCtx(
> > +            targets=[_damon_sysfs.DamonTarget(pid=-1)],
> > +            schemes=[_damon_sysfs.Damos(ops_filters=[memcg_filter])])
> > +    context.idx = 0
> > +    context.kdamond = kdamonds.kdamonds[0]
> > +    kdamonds.kdamonds[0].contexts = [context]
> > +
> > +    err = kdamonds.kdamonds[0].commit()
> 
> [Severity: Medium]
> Could this cause a regression where the test fails on environments lacking
> memcg support or active cgroups?
> 
> The stated goal of this test is to validate the sysfs staging readback
> without depending on local userspace cgroup mount layouts. However, when
> commit() is called, it instructs the kernel to apply the configuration.
> 
> This triggers damon_sysfs_memcg_path_to_id(), which traverses online memory
> cgroups and will return -EINVAL if memcg support is disabled or the root
> cgroup '/' cannot be resolved to an active memcg. This causes the commit()
> operation to fail, which makes the entire selftest report a regression.

Good finding, thanks.

> 
> Would it be better to only stage the values (e.g., via context.stage())
> and then verify the readback, without triggering the operational commit
> step?

We have no stage() method for Kdamonds, though.  I'm suggesting [1] to just do
'start()', but ignore the failure.  Cheng, let's keep discussion on the
original thread [1].

[1] https://lore.kernel.org/20260529150057.84753-1-sj@kernel.org


Thanks,
SJ

[...]
