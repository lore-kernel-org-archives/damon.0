Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501494C9573
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655126; cv=none; b=aoB02HjIGHPqM19KyZL+4BfDFvVL7FSWF5COvaWyV1JYJ7rA7fxpkD4yMeDivHt4HwLxK8IVujpD/8t89ggGGmZ0HhCVVMnmPapIErZl13P+epv/ARCxztzaF+4uHN7G5FjiiopmxNd9JTx90SRFVzxuvwchbsWrSfa5/l5fkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655126; c=relaxed/simple;
	bh=fNTbT0ZpJITw3+kNR0QxzV635ja057Zzrc0qVn5Jvjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZPT8t6wd7aOxM9GySVpX25gLn3mg3V67sB6oO/Arm2k1ZW7Q+TmsdL0Xlce3xqmU0S+WCx9Q2b2tp2kv29iVB/NGtQ3HIdLUKp0THv0jPFipzIBeFp4c+qnSQF5UNdYKN5W36BMELgbiNvYU3Kurr1D+qmScp7xg5nbVNNjT/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwPJTQEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwPJTQEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4FB1F000FF;
	Thu, 17 Sep 2026 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655125;
	bh=wYJJ63yrQW1NVl/gralzAXr7ZMAxZFoc32jliyMJITo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwPJTQEEXatRf4JwAlGPYn3WVJAWK6YOMWu4sPOaNprus3EsCKvFa/JkNM/plcelo
	 AYGbPk/caZ+h2BMR8ZnlIsAAUE8yf/IecrzcaLkIElT/3a9k9pWvyMMK9fCRQi2eiP
	 l0/aec7QkYNKdIoUORyWDEN7DvvkPHVKfFA7YrXjCJml6QKVnn+zOt3erD4DiHGdsI
	 8HrsrNkBYDRLJVWkkEvcFl1TLaTIilaTGkLzmTCzN9o9V1jd2OSI7ZvNz0QU4SIvN6
	 Sk33DcuJV79dB98punRaU1V6+py9bQ68qmoGNKkqwznCN1xUdBoKkoAaOr3Mm+Twu3
	 hv/D/oSJbKOww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] mm/damon/core: use mult_frac() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-4-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:25:24 +0000
Message-Id: <20260917142525.0D4FB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() does its best effort overflow protection.
> score_goal_diff is always smaller than goal (10,000).  Hence the
> calculation can be replaced to use mult_frac() without concerning the
> overflow.  Use mult_frac().
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D3

