Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2D337699
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013946; cv=none; b=Mf3F89A/UhOP5Od7tplYclVESvRTxx2dEHZjCZc/wU1OJKXTc3c4UjQrg7dKN+38Euj6FUZVfUSin8Z9FuEg2p/xcRKD3mdj+BI7i8jLiSV8gECnOK1kDr6EE3nAKIBrkHCT5OmXYSZPWmxmO9flQS12irRTdhZB4jvZHu1LWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013946; c=relaxed/simple;
	bh=rxKFcbSpwob4hZD2lfdzkkGWmlOihBQXg+a5lUS9xCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fsTqsozLayu7zlsrNJsRwJ11WbwsEUGZbW/V0riGe4WzhvHLZHPgL/YJSGSE02ZxWi9OSe4pvkfETKv5ugF/5nrJ11cr5Dyi/0w4SBjA7ZXwidQkygEN6a2an9hRnZdcqtSGsCqbt3uxZ9yQkScxjf/lJIgvpe0/IIb0b1SSBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0LHkh4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0LHkh4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7631F00898;
	Thu, 10 Sep 2026 04:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013944;
	bh=rxKFcbSpwob4hZD2lfdzkkGWmlOihBQXg+a5lUS9xCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S0LHkh4yCoGE3SdbG4139kC4nB/uyGXIkiFM8T+qtVIrrZrP2oAfhoRrIvKl6z8QB
	 o6EzmtZ8r3FxMuUQ+Xr5DXdFUjY/WwtNDPQ9L+omYSIS4fmWRIiTBbgbNPkKzxRqj2
	 NqR4O4i6buU3uMumGEeVK1cyuGRqYf8rrnojdhHZQPzynwbewOusdZ9UTOeBddABuA
	 EiXnf5+YlFLOEgbMBQ97r0jDD4VmdNd1XbONq9iYc1GKNE5uUni6hIGE79D/drOZqu
	 kzvMIqXSxxd3+A5RVMeJtFkzQHbmV9xuD9uO4Ec2sk/0UwqXfLLsrTKlXJ9xLhAyW5
	 wwrA75JdqifKA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 2/5] mm/damon/paddr: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040911.148273-3-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
 <20260910040911.148273-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:19:03 +0000
Message-Id: <20260910041904.1F7631F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the physical address
> space DAMON operation set (paddr).
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040911.1482=
73-1-sj@kernel.org?part=3D2

