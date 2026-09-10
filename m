Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDD3A1696
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013434; cv=none; b=Q6GplwH7wJz6N5rKL/mSRLXOq1J83J8iZh6AKw2J2VQmphfpnHacU5n1dzLlByMSn9eZCHSeLcziymT6KfzsX6fsudRXkTO+aeqVktJmWCYqMOlFbFUKRjjF/kyBL/h/sxLlA/aTGDIpcF4jkHxK+jOn8T4h+3CV3hXj7Vw2zuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013434; c=relaxed/simple;
	bh=B73rF8GQm78qWKWyKyvrJxjVGZrn9kSDP4NF8/toyuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXgIk46yz2GwTstFezElXVp3t80tf2o7qQng+DcevTv87wU0xdfsHCpEDBqzX87JP1h9/arkQM0YXCoRMJMoj8vkBHUo5g5jm99rF90uey+PWtikcM9Q0v9Q21Xyw0fbDbC79Rj76fDiTjDP8e+9ENvpP38Y0TLlCn8t2kSy9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzTUpVcB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzTUpVcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180AE1F000FF;
	Thu, 10 Sep 2026 04:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013433;
	bh=B73rF8GQm78qWKWyKyvrJxjVGZrn9kSDP4NF8/toyuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WzTUpVcBtVBypuViL+e3Ye9Gazdas71eKMF4ONKZRHYdWASAJFUZU4FGcAo92Y/tK
	 5nVCeEXVqJBeErCOCIzcBol/1QlLXPRjjX9NjqUk51yv6OatUFUEYEIODytnsGV9wB
	 i997av0ShcZMRFD5Nd1ywmlu5/HGePPdoHiQ41sUMGwtCaDEY8T/gHPuGtE+PbUmcw
	 PvtoyLM2uHA4OTL6osLQ3dFm765iN2jXw1fdbHCwtIrJ59NyxUMAfX6YxpnoNjlDZY
	 UCZ5qtCryXHBwYPQLL8t+WvnvcWjkT9cKT+q5mBDExXcyLJe57FLwGGAm+dda75WxX
	 Su0Blzq2bwiUg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 5/5] Docs/mm/damon/design: update for
 pgidle_set probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040911.148273-6-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
 <20260910040911.148273-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:10:32 +0000
Message-Id: <20260910041033.180AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added pgidle_set probe filter
> type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040911.1482=
73-1-sj@kernel.org?part=3D5

