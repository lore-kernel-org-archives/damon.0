Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6241D112
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483475; cv=none; b=eVLboXIl6ARd1LQCTcAdwClyFWKj09uS4L5pyCyuoQpYR+L3Yp70jLdGMOZ5S/Y3UZGS/vEyN0bsZlJfkAFqMx0AqWlGFLqDu64wmn21jIxt+FF2NG2GkbRx0TbyeSg4XvbKFqjVomqPafLkWX69MBCFnEwiWKdNO6N6uX6Js2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483475; c=relaxed/simple;
	bh=YXqXQXZO0cWVA9eLcf91POiszeAl/3LbhswoUyJ/Tsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k+kaGPdoF+BvObLyfoRtZ9UN0ZhN6WCbtnIIEVyWY7jefXV6QIokAG3o5r35lhk41kTPiOP6ep5yGiNKDVGN4wD1b8qpPbRUCDEeOQ/3uNBsIAbnySVaMMKmG8UobeQYCj7OAXrNcrDiTMWbS8XxkGQunM70Z3xrr8KFPQ545fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0Tu4EW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0Tu4EW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A8D1F000FF;
	Tue, 15 Sep 2026 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483473;
	bh=uREEnIJBMakr3QES1kK0jQbQc0wdA+0kHFyd7kxs7sQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0Tu4EW4OYsayAV8md2JGd3xkg5bgvmYi8fnXdDiMb0k4ccJpflnINkQyL2FLkPpr
	 iEEqmjZOl6dcJ+j7+q5E0FEG4Ualjr+MMTKurTxKzfJL4P3UOrcmdL/+imlI2CW6Xa
	 iCXKdSN3t8KeoqjZJsRUKKF6G9FnjYlpvqMImaAyOE59evP8stCqsJJecHvzBEjzg9
	 3GQ5lqcxwQ4E0dvKsF+3TWgUmjXReBAdwPP8tSk0RAe7LQqARRd6Mn3/PY+/6DRsKy
	 kxHywIjJXLzRA2gAQaHYF6mb1jPGwWO0t1N2M7JVehQOiYd6EVCAzTgVOE/jyzphMa
	 v62sc0/vMo9FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] mm/damon/sysfs: support hugepage_size probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-6-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:44:32 +0000
Message-Id: <20260915144433.40A8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to support hugepage_size probe filter.
> Allows hugepage_size user string input to the filter type file.  Pass
> the size range argument that users set via min/max files under the probe
> filter directory to the DAMON core.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D5

