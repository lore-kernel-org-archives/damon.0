Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122D73B9937
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511213; cv=none; b=o9YrUvMdTVAiIhvGlBhqihmO6EyYT6aYBUbx8jBH/EMSWF3CtEvDYsasFsRKYCBIkiU4q01EOOft+ft+kMlzN+iH+Ee6FA9r1K3A+5cG7TchBMTVtRQtSEgZqPHVA/OI6oZFO2/tnKaH9kOQ3RyWoZ3SG8tLbSN6WH/PepZ2BGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511213; c=relaxed/simple;
	bh=/bj6lQiSH0sEFwP3cDdcZ57SFoHPm29CGeb+wSJyA30=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dB+O1Q6aqPOetksFbK2LN2Uc9BBjye7JYplOuhnmBcB/ER/MYDXaNfF7qJ1UCNOgiz4+ftzN3CXDi3oz3BIsy77v4MS/4JAqNXjuwHGFuQyEhB1tPvrTMChqodwDfaruWA3a+D501KkdgoxmiXpDmT4PZxlMO7yVmIMFr7o2B3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk5lCS40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk5lCS40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5541F000FF;
	Sun, 27 Sep 2026 12:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511211;
	bh=643CvJHXijaQZf5HqLZ/5Mzcf6P3Di/aKqxCLPUyyMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zk5lCS40mOawWpBuK3ie2aCZ9Q6c+ctluLH7Q0kM8JJAuzU0fcQ/pQKBOBiuaV+0T
	 4SMzv32ogO30BkABwTy7sP6iCbsPmJPmYbF3EO+ZlphnXfCyWrYJ78kxtPYb6knyv2
	 TfcDDOAsHiKFQlfwA30WD8J4P68Us3VVW0C4PX2wQ5HiFvFrEHh8ID0mCFNgMcK0Em
	 0GwZhmnpD/s74ftUry7oazmPPZLqLRbnXpT6gkvZAgytMnWnuVx0aGLyD8jD3K7CzC
	 p64N90w4zaTccopVF5mrkU80P+AgPalVG1vKXKxMenGiETxWhrbggrg4FajW7HWupt
	 TLygEcBloUTXg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 4/7] mm/damon/tests/core-kunit: test
 quota_goal->complement commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-5-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:13:31 +0000
Message-Id: <20260927121331.8A5541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend existing DAMOS quota goal commit unit test to test the complement
> flag.  Set the source complement flag and confirm the destination is
> updated to the given input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D4

