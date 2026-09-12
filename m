Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666978C9C
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789241306; cv=none; b=lYJ4iSXu1xs9KgpznC4h71Lhskkg/nuPA91xxstQSHz5441/URFOGjUnNxC5XF6EuGJtJb7W3utn4HhxhZ+DgO6ll4Ar6CDbADfisGqe2EoVH94YJZ/BgSn0YKgPMlyLm6kfTZWddC0VAn33vSORTy2QVu8C21dZvHRNpgPzhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789241306; c=relaxed/simple;
	bh=padeoTz+xF6emFYlozUCMgbUVgsCGPas6mbsgEC0O8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OhgzM7JFcEblxNkECrYbhNP0YiDdqvvBfaacFrSOMQvcnr+C8OzpGubaG0Yf3DrosF0o0Gbf2cwSFb5DlfXs+WyRomp3Fd7BfVh0FRMvoxghPVl+9qQHY8fRN5ZGzrCNbKooCjcNJKez2RGmaUVl2UIxZ1qRhEvTbmOq5n39LVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CygAV9qd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CygAV9qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860141F000FF;
	Sat, 12 Sep 2026 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789241305;
	bh=nsewWKsdHXwJLzZH2JVJsAMIemkSVjlIdZUOT1mwOUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CygAV9qdoyQJRXYNWG+dJ2YlQ8RcELYCqjuOQL0nB8V3Cgvxtbdp65IhaXgXft2JX
	 aryYiKbAhdktiDX99QT8id5vl6vKeNa9WI9dahwsYHTHzkdpN3ZybuWu/+XANng7BN
	 31ioqmcWuIf0daV3lzl7d3+b/tKWwp0PRkfJh54rCZa23DE38ld0No+47tB/M46g4I
	 IYsW64ptVhMbIw+brYDINY2fAuiGOWLs4F2deTMn3bFM89jrYhQYmEu24fafs3Jd3j
	 ehIX67hXhJvLgihorPqbW38sdI2KR+/7RpwtAWU6ax070jNcO0grrZKNw7GIQfklQq
	 MQq3U6/B2M4Cg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] mm/damon/core-kunit: extend
 damos_commit_filter_for() for wrong input
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912191807.138502-8-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
 <20260912191807.138502-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 19:28:25 +0000
Message-Id: <20260912192825.860141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_for() supposes damos_commit_filter() to always
> succeed with given inputs.  damos_commit_filter() could return an error
> for invalid inputs.  Existing callers always pass only valid inputs, but
> they may pass invalid inputs in future, for test purposes.  Extend the
> function to be able to be used for wrong inputs-caused error testing.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912191807.1385=
02-1-sj@kernel.org?part=3D7

