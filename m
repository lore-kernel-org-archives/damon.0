Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1A326D65;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115675; cv=none; b=GFq0Bec+oENeuPYqG3YEqgWQXAYK+rwoKQsRHZfpg9F6tcBUtNhUsmL5ulQiZHfwPpuPwcaDLHfIN7M4sqlfxQ98IIWTXdEtpLop8YS98y8QJRWbfdOY/d0GT9MO06GXlwQbQIrw86pnETHs5EiQoZSIvH+IIW1oVmr97SjGOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115675; c=relaxed/simple;
	bh=YoReG2ITY2y0HZje9C+bQfiynbTvb6Sk5IqZjXN4jgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcNkHdbgtFp0v0ZMv8raT06DCi6/lhnBnbNi1GFqkWUeEyKkMi/McWGaYjjyRL6/NhYRxsqnz0ab5btSBTbqpLbPLescyRWGVsuW3BOwaZVFsGakNtZwvTBeJvlGXbmN3YeXxT5IFlHfJArrAO+TCDkfMXQgyS+GDnYORkELhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn8hxWdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn8hxWdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F0EC2BCAF;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115675;
	bh=YoReG2ITY2y0HZje9C+bQfiynbTvb6Sk5IqZjXN4jgA=;
	h=From:To:Cc:Subject:Date:From;
	b=Wn8hxWdjY8nwvWguSRylu6QdUeIm950qxeCvN+XJLKNCFiGT1rvu2S3BS5RXw2cxt
	 Esz/AQ9kDq9aoqZS2gvlm/exy7gvh/sPZQYJmZLwErh98XF2l1RsLHDkI0Am6AeDtV
	 JF79+nbLaPdKFb+mn1AH21nzU/DA/fPW4L0XALHGz/6vJxNMRkCE7RaNZ6tyS1CxOY
	 fe4GrcRbccmK+BX5mC2TDQiN1yAcXHtY6AtKZM7AOe6ofrFZl07nsuJrlM4M2fc/Nt
	 pX3SCOAdu21ChF8POhoezaza/gcja1Matw0PGMPkd0Ez9SaxagAGL0AlFW4Ar+RSOk
	 cUCw7yXoHy9bw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] mm/damon/sysfs: fix memory leak and NULL dereference issues
Date: Sat, 21 Mar 2026 10:54:23 -0700
Message-ID: <20260321175427.86000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS can leak memory under allocation failure, and do NULL
pointer dereference when a privileged user make wrong sequences of
control.  Fix those.

Changes from v2
(https://lore.kernel.org/20260320163559.178101-1-objecting@objecting.org)
- Wordsmith second patch commit message.
- Add NULL dereference trigger steps on the commit messages.
- Collect the valid Reviewed-by: from SJ for the second patch.
- Rebased to latest mm-new.
Changes from v1
(https://lore.kernel.org/20260319155742.186627-1-objecting@objecting.org)
- Check kdamond->contexts->nr from damon_sysfs_handle_cmd()
- Collect Reviewed-by: from SJ for the first and the third patch.

Josh Law (3):
  mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx()
    failure
  mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
  mm/damon/sysfs: check contexts->nr in repeat_call_fn

 mm/damon/sysfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 42bc5b563370622d688719aa248a4c861839373a
-- 
2.47.3
