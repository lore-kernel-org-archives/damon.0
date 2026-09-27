Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E73A1684
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531715; cv=none; b=c5WGob5/L+VMlg6ej/AoHnMYTV5QQ3GqqrZKNoIGTMa4Udedp6Asc2MPEEyAFgnjOYQP63S/DUbzRbpwzGsph5sURKMR5SA4qZIe4UXMGeG8OKaHA5uUhjSszmW29DMT8fUzO8PMbCNlOmhfQ5lDOhJ2uKurE0/pjI8F0s+4Fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531715; c=relaxed/simple;
	bh=eElsjnE5i9iiaWoeiPU3DQivNSwzls/WMJ+QDdN6Tyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T6p1xWQpZV0fAKAJvaOkWIklfMUEyPWsoxKvgOPw9Iz10HdaJ25hv8KeIvcoCW+xkIQWqLo0mp4sEk4SC1Qhuy9l3e9wwl4x43exXPTA3KCdRPWzwze1o3uvwPP1EWJ/N6c21TgLOfJkfg1bplzivE6afLiv6B3ytyNQ600R15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg8WOCIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg8WOCIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA451F000FF;
	Sun, 27 Sep 2026 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531714;
	bh=eElsjnE5i9iiaWoeiPU3DQivNSwzls/WMJ+QDdN6Tyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lg8WOCIT4sPZ8aEG3kFdyytrRrpRonIexNkf09SEYgBmLlVso+rUqmvGgSRi3IeuQ
	 DVLAdhB1BMSu255MqXnFFEVwbS1SUnkpaLd4L3XMJI+d9Eh3mcUSBZ9899dknQl/T/
	 OPIuAflO2Ly0wMaTh7E12dsDD6fjxQTf3xdr9y/8GLjLL6qIw+LdoBSLFF/YzkZQeF
	 rOR0uSdeEk3rnk614fj6gwYfdCrVgYmXHhVaSEE8k7y0cnz5KeFh0x/JckbrrKdEZS
	 QIiSlZvrK+yk/FBlnws3NZvIEKpfdCkQPtYhxkjF1kSj9oAoYCm5LXnQdKdUPItRHe
	 eyuEs/3U71wZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/tests/core-kunit: add test for
 unconditionally skipping the last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927175159.60703-1-aethernet65535@gmail.com>
References: <20260927175159.60703-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:55:13 +0000
Message-Id: <20260927175514.1DA451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
> region") fixed a minor bug.
>=20
> Add a KUnit test case to cover this behavior and prevent regressions in
> the future.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175159.6070=
3-1-aethernet65535@gmail.com?part=3D1

