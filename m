Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26A400986
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396663; cv=none; b=fAA8B3sPp+zPeIvQarm5bN2vJU4Me+rlOLBHPZzyysmpFIWYu8STFd3WJfgdTz+uvEx5Lx8voX3GrMVfVKulwi0n/ic7rBnCqmpP2UMQGx6oiiGkqXwo1iDrUqY0Ibf7Q7D6Aik7GRrqFrw9bbqJYmF72U8mdFwvOThsnvFDFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396663; c=relaxed/simple;
	bh=0eM45WBBPdzhk1ogXEISZ/KdJIjkiEbHnHjDgDrmLsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D81m8PuQ/7jfXFfVScer9+SIkgBOmrq3/8JC96CzVmanBEL0MMmIEt7yyoAVkqylj8Tvv1SuSwoHjh50jCszksqsJdwt/h9Yv5477rXmV40PgQJ3Nshr/JixyF4CPUJZLCbClqf+BNweQlgiChn6vqXsOjUeC0S7Qlzuu1TsQ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyT5761K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyT5761K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC251F000FF;
	Mon, 14 Sep 2026 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396661;
	bh=ozO6XGqBi5vMStZlP7zAr993WJZbBWTBWreS0zriYUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyT5761KoWVV/xnlnqCzrB+2qid1If0dY28beEbqoTBSS7F7tTURwk8+tnqiw1em3
	 O9ix1jBbjkamcAtUbh4KmccD4FZmighyS3Vxn30uUcZIj8o1aWsZfdSog0+Xwj7zEH
	 wD1qs9NbY4QKvJhWE8r6uBAXWIhpITEaPcL0pJmNFVmOiDRR07goENL/Xbk+FzAIJR
	 giLlr9/u2Z9sBRZg9xEWxLa99PM1DBDeId+fbSxBw3Wj93iGgyvYsCOBeAIYD4ihXW
	 eoQspfvs4mDmKJqSph88YoY9Ei+q2WCwwgQLWbsoEKiHLBZ4iY6zrx3CTYEg4QY5ZZ
	 JzUYhxP5YVzgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] selftests/damon: add script dir to sys.path for
 PYTHONSAFEPATH compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-4-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:37:41 +0000
Message-Id: <20260914143741.AAC251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch incompletely fixes PYTHONSAFEPATH compatibility by omi=
tting 3 out of 10 DAMON Python selftests, creating an inconsistent state an=
d a commit message mismatch.
--

commit da82d013622fc33202048b811231e1ede806c92f
Author: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

selftests/damon: add script dir to sys.path for PYTHONSAFEPATH compatibility

This commit adds the script's directory to sys.path for seven DAMON Python
selftests to ensure they can import the _damon_sysfs helper module when
run under Python's safe path mode.

> This breaks all 7 DAMON Python selftests that import the _damon_sysfs
> helper module located in the same directory:

[Severity: Medium]
Are there additional DAMON Python selftests that also need this fix?

The commit message states there are 7 tests, but it appears 3 additional
tests in the same directory also import _damon_sysfs and were omitted
from this patch.

For example, in tools/testing/selftests/damon/sysfs.py:
    import _damon_sysfs

And in tools/testing/selftests/damon/sysfs_refresh.py:
    import _damon_sysfs

And in tools/testing/selftests/damon/sysfs_no_op_commit_break.py:
    import _damon_sysfs

Will these scripts still fail with a ModuleNotFoundError when run in
environments that enforce PYTHONSAFEPATH=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D3
