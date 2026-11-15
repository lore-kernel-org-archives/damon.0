Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774759;
	b=jmeBQO0NDZOYxHHRoO0Dt3E2UnLmBbmjCRRpRNO5KFaRuOmdE5Pa/1ulkJ0m1UOsVxOz
	 sTtJR2JKJoBguB+5Z0mlmxKnHaIwbu8XCnNgZPWCpYTpIZEwB0SRd8JGSRCLeayNij+e9
	 O43cM1I1xMi1LpM2QB1g51/KAiPVMZ29I+bdim4cHNtuFKgOJMpzLmCxUR8T2MQHPe+Ai
	 Qq4y8Rx8TWwb952zuImLrfNTG4roGj88QsErnk0FXqzvxdEsiH/A8tsfGDxblK1PCK9iG
	 xVTo1MaOr+L7PwkwUmyzAC4DkE1ZlEWBMnekBTHw8pogHxXwPWnroiaShuoDcOBre7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Qk2RRiZ3rcTiV4q8qB14FdfnvshvWb1Hwx0MWf6WyA=;
	b=oJr9tnGxpGEvGyx4mZx65qcjcd5mNSs4Y5F1kDI1KzcW/+ysYmE6GKSAY0Lw/DVOqbr2
	 K4eVmu7FAgft0GCodddPRX8cyrx+Mvr3lxkC5RyNTAGJItv93rHsEzxQP1G6uHIMYAOft
	 XYuVv3WuACw0mY3dcYDSH2aqLMV5efR65WM1abIc7B3baqWfpNDAlPcM2Mm4w16vphYnV
	 5RxaUtGWkdES1e5ofA2HhYgTB477TH+bDSQptukzDIw6lIOvW0k/eG4sdSFk5UUacmeji
	 RSfXqR2q6/CEquAunE+pWlTdzSknflHguEKGQ6f4SeCrjXCrus0E8QLfFxW88UR9GKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb6sywFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BB606A329
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb6sywFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B04A1F000C4;
	Sun, 15 Nov 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774759;
	bh=8Qk2RRiZ3rcTiV4q8qB14FdfnvshvWb1Hwx0MWf6WyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jb6sywFmv12yplSdYgZyRN6nSOiOdgWK2KIr+OeakB6XUY4QMAp2Wgt96PpJYvz51
	 4oF5Bfh4/xnje4Wu2eAcmupxZt/6q0MwPIvAmzCZsmW6b4bqvQHkJlzC8rhoiiGTai
	 ezigvQqeoaBKGSAL+xXXdylU/mcm8Yd3yecn9y7P9SL2zhDnPGe+Gjw96GJLunvc3b
	 1VgLnb5wGwjDy4ci/TmRUQz0Jfx/CrwHWW/LyEmgqLK/3XBBcnHLCdM5xZ0ofCh6qH
	 TjBewIMp8DjD4Wrv9VwmNz1qIlmqKczey9eDdTmD2uB8SsB8Pzt8IRyHXYyWlDN/0z
	 W7qjuaZDWmTXA==
Message-ID: <sashiko-outbox-215826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 17/27] Docs/mm/damon/design: update for report_made
 probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-18-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-18-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added data attribute report
> existence type probe filter.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D17

