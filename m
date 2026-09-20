Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28942D47E9
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907519; cv=none; b=lwtwVc8eGZQ/utXctrx+uzwcd+qSdOfhgUoI1tNn/kpP4P5chdZ+iU8Ue3THbzkQjnQFa41kEGWYc7natrbdaXGKs1elYw+H1NJZTz7tA23lOu3aDHlRAOadp7JQmbya1HXxJCNfYoF7FQ+/ZyPNebDsD0UX6ATLiXgzFaRjrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907519; c=relaxed/simple;
	bh=pcnz4ihX2Tbf5v7+Ug6CjePSiDm7Xxc0gf6TWWMYeYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCSAQUhdyPelHEieQDZFdPd9KH26VzK5hGpKev29LLukQ/HrMwM/vM7BFfzc1/5nbNiWTPfO8xC8WMmvIuNYqv881zlVHleWMOHTQBT6Nx+rm37B8oJFERXywf1NKV4l1/PuDJz/1+o0qKhEjAKOMDFR3MojYLIEWIEdHk7M/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQKPI5kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQKPI5kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1621F000FF;
	Sun, 20 Sep 2026 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907502;
	bh=+cpaQ1/AkC7g25plYv6uErGi2SSsuUZcU314t8hkUOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQKPI5kI/mEpG3A0FQM1fP10HC+6gCztVyD3qyonFWWOwmNAFkGe3iHZcsRP4gGjI
	 LrGRUKD2WJroFdBmhPJOpGdxBS7W1vFV4eMcB6iK0LOYQeyX2mtE307tYnXASw0Fd6
	 vIr4Q17uMLWDH4Odaz3CwkXwGM/Xzr+kAgB2B/RCPHbuxzCt/V/qjANeqMaUjv+rEU
	 Jkua3FPQ3pdtmnrFlHSdlBE1CPHH7esxGv4ashPso8uGWwT8tTI5hCZcYilOH9D79e
	 JOdO+JFr/hI8ebWatvKKVHaqOzyGBgi9pICJMEpr+vATQcTj/P+ID9fza3JwmwWRjc
	 c2zcdtwJndqvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] mm/damon/tests/core-kunit: test the temporal
 tuner's size quota conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260920122411.610213-3-donggeunyoo.kernel@gmail.com>
References: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
 <20260920122411.610213-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:31:41 +0000
Message-Id: <20260920123141.CA1621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis
> points, so the conversion is exact only up to ULONG_MAX / 10000.  Pin
> the three sizes around that boundary: the largest one that fits, the
> first one that does not, and ULONG_MAX.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920122411.6102=
13-1-donggeunyoo.kernel@gmail.com?part=3D2

