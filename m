Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55169353A72
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199558; cv=none; b=lS783gr9cA9zRiTToxmaizMf9A3eQ79w6UyNziXTjqvH+mYpf3PwNnjAl4bgQnQz9enTpFakYEqVFojPO7CQQDfvv09cq+Mhh/jyRy9ekv+A4dVU8r3aRTb4Qbg6BlTZ3esEaE0avgtsO6tef8TJ1EOvjqu03EunCzy6aSYncAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199558; c=relaxed/simple;
	bh=NDw1HK5otqJrkQnFGgIhQWZDCEyGDhp1HnhaMkfN27M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEmbpEU2pIbULcu0txkQK1WNjtpeI8EJZOyLOTslCHz/FBMe4FYrzurWki93LAxBJzYcebceDwq/EEz7ve/chilBXiXuuzpFvhsPwMGwF4I7/C3vl7jVZfM4iUBTcd58PJmb/BC91lvTmUiP1h0bGoliuSCSZSom6ELWO+Sousg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtOAiFoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtOAiFoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1735E1F000E9;
	Mon, 31 Aug 2026 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199556;
	bh=NDw1HK5otqJrkQnFGgIhQWZDCEyGDhp1HnhaMkfN27M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gtOAiFoNO7nH28QaNimbydH7Ct0y7qhjqrqThLYwc7AAbmAPNbcGxNS+8+RXg1Xnv
	 xAuCLDMIaOqtKfK4J5tCHyRAsnGlZef1dmlbThfRZaJ8yMjgVoXbE4L86VUUXJP5Zu
	 QLT3bJAnxB27RXFVL7MXqZwPAqHfEDRMOElgbHlgXJw3LgQu6QECatAMT4Cad58Br5
	 IOWcrxD8tUtkXwg6iERLdGQPxwl090D4qup0YKxEbPzZKx2OmLo5aUGVe4P08c5bth
	 0x8N51kVIGd8sFzzqQ2khD8l3On8Yj3mNVJ1TBCqlBT1Mv7JXoDmpXtJoykZKegJ9O
	 tHmqqtqYLFt0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] docs/mm/damon/design: difference between
 watermarks and nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831150227.83416-3-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
 <20260831150227.83416-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:05:55 +0000
Message-Id: <20260831180556.1735E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Explain the difference between nr_snapshots reaches max_nr_snapshots and
> watermarks.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150227.8341=
6-1-sj@kernel.org?part=3D2

