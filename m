Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796B481664
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398813; cv=none; b=dVzp9uspTgEuQw60FoEoIOX68gHrY7Oe7O1bYbAACdYlhCuCx9jjRWhxzqYEoIAj382W8gr5qcn9W+wWbPio+J4rZv5drs4c34O6MNRbAU5bYvMQBhvsvrV4FtnYt1ed5fBL+VHTq4zPyYhvH9h2gEU5wRt+jKFnumW5QYvIEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398813; c=relaxed/simple;
	bh=bYFRun8Xk5qZcNFNydeSexBTYEdeK/M6Tl0YN4nOXRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDZl5TmRv2ckojiAaorcoZ3ISgoRNTIhcqhuUBabYLwLAZiEucndwQhxC8Bu9xuOe4jNcwWu9p5qeolsnUBk/zSCPjZ4RyjWqlcFK3N1FUdhMc4BpvhNNcnV9wHTbj0AZhcK3Tj6Tq6AmSY4Ih7jg38+o5h3MsCzPq2vWC7whio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8BjFPY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8BjFPY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCBC1F00893;
	Mon, 14 Sep 2026 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398810;
	bh=7+luNJGkbnBUMvKxknLCM4QeH885r+ONuVF2rj4cbYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8BjFPY9rxjupmqdjv80gRn9HIiFSr6UTQR4Qe7RxZn8YbZlvdwe5q3hRZ1cWBGVW
	 tYlveLDLATN85PH4YRPbZzr5LB6vaO14y3pZ3EgiF2giMNAh51dWPIMTuShi68LBdM
	 QnqRAISzlP88HS1ReNk1OPwhSE717hvS58N+KRXbYUIMw5Fhekfghs/TMbrJTHNhdA
	 RColbeYrbUrkc94DodDZGpFPwdQLvj4SbobzIZ1Z/4HOCNks3sLt1S6NbiQKD0XRoq
	 9+OxOI9l1mHasOE+olDUUcIUA9iSnxcpt6BwmR9m5Jg1g41oU/7GVMEwZ5pjtB0Yep
	 mwjCp/XOpk/qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm/damon/core: disallow max < min damos filter
 range arguments commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-5-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:13:29 +0000
Message-Id: <20260914151330.0DCBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_arg() receives range arguments for a few types of
> DAMOS filters.  It allows any range including max < min range.  It is
> fine for the logic, but makes no sense to support it.  Actually DAMON
> sysfs interface is doing the validation on its own.  To avoid duplicated
> validations in multiple DAMON API callers, it would be better to do the
> validation in the core layer.  Add a validation of the given range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D4

