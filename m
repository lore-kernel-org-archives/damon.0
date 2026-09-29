Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58D3A6405
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669267; cv=none; b=bXH1PxKg5SupIS3r9GJp2EHl2gczv8+wyW95cGaflQdrWXkiT0BoqalCgcF/92KwpBSdPwoWnrIIPlzWJueS66E3gD1rWtyLNAnHe5mn61tdyTRL6K2/jrWKQ4kOOfS0zBL/y98mZRjuw67NW/NDNp8/dg3mvp6u/DE0TI6zw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669267; c=relaxed/simple;
	bh=hKHGJ1CsGle8XA8JBXaovhNnMpSyHumD+0EJ6qd5+KY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9F65rIOsHD1QzCFqv0WpzNdqCpSmV4ipYA9ycjILEqMsuQR4+u52W/Lh/cHYYil0uisEh0DpnZ5gMBsCbp62T6bGciy4Hxj3zSavEGhKUyrFgjL6K0ylUq+gvSbkTlReTOVymN8F7tjJjIhWUiLqo9jJii9+6UP+s/easfMPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR70EmyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR70EmyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76341F00893;
	Tue, 29 Sep 2026 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669266;
	bh=NJWSGzDcJGwDl9tgRQjKfDz5oXsgz2kvxdoE+ltlliY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QR70EmyIvD7w2lx7BETS8zEbOoaNQo82F+SSy0hmdHCIcRijWAnGRfrzmlPARTLhr
	 967kowQcxzczMU6xQ2ufd+ypw00OvVPohmH4ZZzBqD/tYTrDR1fv89SQHU2bC928yP
	 6z530MJEo4G4SWyPfdRf6vNl7VsnajZo9UA5bWwarM+Q1cVWQzNIk0Vxzi40gNImop
	 NQiQKDROv7XAmVywNZboMk3SJgC1/gxBt7EusC25cJ6oFclp0XC0VnUtldbRLtAeoI
	 gMeDS39qnaNXWwqikNO7Po97tCQiEtUlh1oQkXHjY1h1b5buJUL48Zicl+yzg2Qn7G
	 BxTMwTCrcKrbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm/damon/core: add complement argument to
 damos_new_quota_goal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-3-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:07:45 +0000
Message-Id: <20260929080745.D76341F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_quota_goal->complement needs to be manually set by each API
> callers.  It is easy to make mistakes.  Extend the quota goal
> constructor, damos_new_quota_goal() to receive and set the complement
> flag value. Also update all callers to use the new signature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D2

