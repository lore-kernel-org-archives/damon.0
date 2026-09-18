Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4254A3F33
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744057; cv=none; b=LPuwIX1CKYUg4TGWnnQjCJ+/UstOP5q9KW/udxssFyvYcqq0f90FxjR0yIt3I+GrRqUtJ3fNvWTOn18dhZ3B0pv1BUQ5vlPvROSePlIeQNW7x1tWzyKjNwDA/XHeYydmprB5M4UtttrE2+tlsb2bKWuShuK3E1G5m9Y9iS8aXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744057; c=relaxed/simple;
	bh=E0ONb7Y3Z9JL50ENx0N3WugmyJPhWktTmHj6IgNVG7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPIhwsHLx8Eta2h3Ui5d+D3t80tgqhbcuxvUBw/vPag1EgUXrMGd6J5wypnJ7WbPt0ndw7w/xD0742NHPlxF8nVH2rr8kmhNpjpc8RC1AeTPFQ2pC+4MHzeN89fvfo3hDGfDZFD9N4/bKJeyF9/qUnOl8brItyPOB5INGAY1fHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kamJzu+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kamJzu+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6501F000FF;
	Fri, 18 Sep 2026 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744054;
	bh=E0ONb7Y3Z9JL50ENx0N3WugmyJPhWktTmHj6IgNVG7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kamJzu+dSGHBm24r/dsjqDqsnn00h3bwHuN3QSdt1FkhP489S96LWU2KqKV4yoxgP
	 uYcC3Oj8+2apvT198TEr1qeby6s4TSiZUYggCcJwHV2uh5eQzLzNGFTTBmKQLTwI/P
	 z28mEJlx/dYsDtutP3pFPcFshoozKIeQpH4GTrM0OTJ9pmJQlt2l+c5+f8dk5fXRjF
	 LYvXC9vnA1rHIkYNtKHmy0GbScaWjm1Pwn0UT/htv+0VY47WRosXimRttmbvVkPA/E
	 Op0RFX8VOU896hpRk0cseVReF3hyk4QCzdcNGr1n7LOf6YCvRGcg+w6EXE0W7MMm2i
	 swh9ZdaWdJbwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/7] Docs/mm/damon/design: document damos quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-6-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:07:34 +0000
Message-Id: <20260918150734.8E6501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added damos quota goal metric
> value complement flag.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D5

