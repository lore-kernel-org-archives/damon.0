Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCA49AA3A
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904099; cv=none; b=e1g72U7Do4vjO+ejPZ6RPX32kCsTqBKelXG46Zh7HkGJ5PgH2RUQs63r9wOZMbCFqcYQD0CH5A1te1kxTHoUbkl7GvveVFhlq9EGLoxlDUy5WnnRzRPRK4mBM5Npzf1Ys01GzACsaQc20GW1Z8TJ9FTPYuCx8pzZjhfosHcx5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904099; c=relaxed/simple;
	bh=GwG/odEJspIj22N3JlCk5cfA3zRaM9ycYiUwpRebpck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vm32Mm5hM2mBJtt2r+mxGmZhxQPUcWzXBKEpwA1/ZktuiIN3+fuvf9U8FFMj7mPlJIDAXmkWJmTVm/5alYpDIyGGFN5QfmlhweTNcbw6S7liel0MI9sapJk9ny3qEqAPV4DI2gPzGDxioeBNKgPN5jzjfNcikG8YANUNnJqJSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJiZBnzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJiZBnzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355E91F00A3A;
	Tue,  8 Sep 2026 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904098;
	bh=KnB2TG4MKm7nUWvLZupKBthgXgjkvXbbfRjCrzAbvnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJiZBnzcCUuwNPjWP5OoIhGTR6rdLM/wZdP4kmImPFLUwhHEK92tgd6vYqEbt0Iu0
	 E8xyfsuiy3x7dvxkhZ62xdf2fqXQwxn8plN11LX/HeQqX8vlGniRMzURvBit5/+wnA
	 zJkL4O59ZvUQfTBseT6iIDpS7k5UiwhKAvCbmWiHjbDDqGHddahe/bNZAS0MgaKEqt
	 RgFgnK3xlhAUzZezyQ8D7WIOpe95tLkFlaiQs9FUVzhC1iTdglqIfumoFj6syARlh+
	 eZyp/W7b0zE9q9c/bOZKl6TdP5z2phQcYU2JjXzYXFMRrQDaDnSC1zo7SehcQ2eun5
	 ua4sxDrAfIyyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: damon: add script dir to sys.path for
 PYTHONSAFEPATH compatibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eva Kurchatova" <eva.kurchatova@virtuozzo.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908214238.2680324-1-eva.kurchatova@virtuozzo.com>
References: <20260908214238.2680324-1-eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:48:17 +0000
Message-Id: <20260908214818.355E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch claims to fix PYTHONSAFEPATH compatibility for all DAM=
ON Python selftests, but misses 3 test scripts, leading to an incomplete fi=
x and a commit message mismatch.
--

commit 3a3c43c4b8c811027e52bf0fa5b68c48216e86c4
Author: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

selftests: damon: add script dir to sys.path for PYTHONSAFEPATH compatibili=
ty

This commit adds the script's directory to sys.path for several DAMON Python
selftests to fix ModuleNotFoundError issues when running under Python's safe
path mode. It claims to fix all 7 tests that import the _damon_sysfs helper
module.

>     This breaks all 7 DAMON Python selftests that import the _damon_sysfs
>     helper module located in the same directory:

[Severity: Medium]
Are there more than 7 tests affected by this? It looks like sysfs.py,
sysfs_refresh.py, and sysfs_no_op_commit_break.py in
tools/testing/selftests/damon/ also import _damon_sysfs but lack the
sys.path.append() workaround introduced in this commit.

If these tests are run with PYTHONSAFEPATH set in the environment or with -P
on the interpreter command line, will they continue to fail with a
ModuleNotFoundError?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908214238.2680=
324-1-eva.kurchatova@virtuozzo.com?part=3D1
