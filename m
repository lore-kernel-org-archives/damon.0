Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157552C21D9
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320549; cv=none; b=VMiKJuGm0gA84ogwjP/xVu+mplsQIu2nd6MO/ucYznw431ag1EDnUL81FhQ3EmXwB50xLV4TuGAehZKvZRtWHRLQ9Fay0emxItnFVAeX54obZkjE/G8F6onNAsRqvd5hC2fyDaFtUcSMJD2ymKP4XxR43AHRLBFsDyEJM7UERaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320549; c=relaxed/simple;
	bh=nHo86TTYh8W9CSSdhA2z5x+5hAEz3o8KWt+ja7cNSdQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=acfAMZlTXSf8lOEVo0hkBY6VNFa96YN5UrsjYHlBoes/RRWn95DdAvI0xu40XozYrtJ10cTDyWsIlj9NaJaDCf4ZVhYV22M+XYXFGan9cpW8QcHUZF4PN7lbAOaixE8xaewAqxwSnoDzfcZwt4JdvI40x+nB0dNU+Mn4WgpHcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuYsSeyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuYsSeyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A981F000FF;
	Sun, 13 Sep 2026 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320547;
	bh=ptUG9UQhgpX0cEI89bKSeAbHgwKgyLLVbX6chg3lmZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XuYsSeyFajO0w9vcmsQYk4RoSBTwbkQZ9LIkZoiOoP0XHL1SIHUyELLEs1e4FMF+y
	 RLngoNTpAIhIjW4Rsn4R3IMDoEcdnV9kJskbzWKmjdUePoA7Oa2BKpEUTSUOqtjhfV
	 R6vdXnQfI5fCGN/HHhwbuSCdkI9h5b5YmnnMxjR+vb00gmQChZQKQhZI7aDzegST7H
	 dNsARiyuCm1fepVOMgEYAcAbpr+02xHoFpv8TRYBb4svLXIk07gpHuYHg4O6ANOhNt
	 +wx52M7jyHbE2i5pm2j74JRr4nUDOXgGB857TJ8OlbRAWwybNC8fVGLRgkAQkfk7+T
	 POcU1tJvU8CoQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/8] mm/damon/sysfs-schemes: read
 sysfs_filter->sz_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-3-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:29:07 +0000
Message-Id: <20260913172907.83A981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.  Once for validation, and once
> again for assignments to the variable that will be passed to the core
> layer.  If the user updates the arguments in parallel, an invalid size
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid size range is not really invalid.  It just
> works as having a weird size range.  No critical issues such as a crash
> or a leak could happen.  And sane users ain't do such parallel arguments
> update anyway.  If they do, such racy behavior is arguably somewhat
> expected and deserved.  That said, there is no reason to keep such
> races.
>=20
> Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos=
_filter->sz_range")
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D2

