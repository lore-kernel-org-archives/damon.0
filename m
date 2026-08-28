Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BC23EAA0
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942661; cv=none; b=KOtSZ3/dUQ2d41n0MfZmfL2ObbhoTf2Ull7VvjcopkUPk8Tw+Ni57s5H0O8tr+QPNnekmK3t/pVTPIiQQ7y+QuIEH6SXdSP8pOR3cX3ZqYM0gEA6ran7Fr0owdQbQujHzfBHs7HJ3OC38L88Jn86zD6jGLwMUL893B6Gqu5hDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942661; c=relaxed/simple;
	bh=BovXy65zVDSR+dIz+HaKsXSbs+R8iOEbxhD1PI5mbT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duFSizTZVVRVaZii4G9E+p581HThoVA5OKD3Oiefyx7XvBBklLjez/ffLZDkWZLx2Mfe/PE2uJUZgqdzaP2574HkBzbjcn5UCs5E3SjW4Q4HUAb5t01GCK55xHSd70HOp+cXyT9jYNgelN9HzDU5fKJrLH08RvjDtvPcwr307AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwC59xxY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwC59xxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DFE1F000E9;
	Fri, 28 Aug 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942659;
	bh=MUFJyG+KWiEOoxIAMPgtVjXh5WMOfFmW3ZrJwex2p+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwC59xxYGgs35ANd9eu3P7yzal2hLFResaciMndRIAXKopTSeCr6qiof7xm/HCxel
	 YNQquhg3xN/Zjox4z7oJvLT+LekmcJ/HRe6uBvnz4oV85aPcBZauXjN/r9QgpZjWqV
	 eiAcnNcpxucpyxydc0KKoisSa8C4ZC6/YekKRq6qp/A6eufggK7MVtnwDfz6KrgmE/
	 aZq5LFp0TjeBUDqBqKLETocCB72oPZpDA/G97dOhn0CklDcm0E6sL1+dFUEERnpdYl
	 rA/Hs275u+2NgqsX6NGfg44PXcTSAvOOp28YkdpR/HO4VjsgXHPyxWB7u5RrBMvsjF
	 M7ypbaDnjo9BA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.3 1/4] mm/damon/tests/core-kunit: test committing
 psi goal to psi goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828183649.71192-2-sj@kernel.org>
References: <20260828183649.71192-1-sj@kernel.org>
 <20260828183649.71192-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 18:44:19 +0000
Message-Id: <20260828184419.82DFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_test_commit_quota_goal_for() is set to test committing a new psi
> goal on an existing psi goal.  However, damon_test_commit_quota_goal()
> is mistakenly not covering the test case.  Add the test case.
>=20
> Fixes: 99f89debafc5 ("mm/damon/tests/core-kunit: add damos_commit_quota_g=
oal() test")
> Cc: <stable@vger.kernel.org> # 6.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828183649.7119=
2-1-sj@kernel.org?part=3D1

