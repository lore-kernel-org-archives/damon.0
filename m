Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774978;
	b=PyKY6/qdg0aSx8kusIEpvPl7ipqOk8SsByCwedhgjuV4EcXaMlZWbZrpp3h6IvkLerAp
	 W8nWD2lg/7IKq3O7NoQrtSK/wvbQHR+0g0KUBXGu0KAx9JbGSnsr+cUGfDjrOrVRXiYrV
	 mVWFgYanNRqlJWJUumRXfRzcwfkw96MnuHqDNqyHp2lv1U2WQKCSi4IMVaGGTsu0aYQ/4
	 5YaexgOnQ4iiMozeYece08QlupUw1nmqyVxM3vP2Q3IPgMG835Nfx37Fu4Gk5l2SXT8HF
	 ozk9FRXjwYrRTo/FpkQ3nrkZYlXbX6Y8mf7Tg/4bbfD1HS6eXqAuCRgLkd5E9YUcCRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x78uSrkE9KcgcQeNSI69DmtJKA74/bkEnKDA1wNhW24=;
	b=kRJJ1g3RxwlDuPo9VTVZlYaK9F98BoGFUK10HkNkOUzvFz6G/cRotwyComj/lv+QM6+2
	 PyQQWDGpF61jX5QZtputgfbIHwDN4g/wroDU706ZGHKtiJg8azQTEnwz+2QI6CAhJJyX4
	 Iii48GR9FjcaM4W9jj23xBbnHbBgDabXy3f3wZtYUsYb/NPv2iuc626mC1R/fh6dyirAU
	 ZjRFbfH2NzydasqPKargqGEQOzdLutK4DDGV3NXeZEANo3Sdt2QJjKvNE0WYmYsEho8Oe
	 BzRDp34OzB4vnnfCyzHrSIonvWpYnpaozZ+SaYhEoHYY2bRRNlL/9ZgvbR3FBAjffzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTRQcG3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DE606A887
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTRQcG3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221D11F000C5;
	Sun, 15 Nov 2026 20:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774978;
	bh=x78uSrkE9KcgcQeNSI69DmtJKA74/bkEnKDA1wNhW24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTRQcG3eJk6wl42g1NLQuHXjDDpq1qHfbaFr+HCDRFHD9vmnUnaq/cF+WhiJ9aYo+
	 vKUoPw9YBSZD3KMTojv1pppcmfIrgU23ct6bP9GOdyIRVR0ShmnGI0XV+A0xe4m1Xn
	 o03cx52/W/eynSKCtjHZlD22Dq2Q81h2tCOVU66BGUlA9cTDhTGVkjteTS1l6yAOg3
	 /ux845Om6UqYbPge5sD+atWTTwXb9mP6kTmr23zRjfp2KEwih36CPY9OZTiMfH+mGl
	 uQi/8jMyJFqyqmoiySJdNFp2uJE7g1U8wBF72ku2LjICaIq6D/yxrdnK9oIhfWIc2F
	 95gsw6uSg5/kA==
Message-ID: <sashiko-outbox-215844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/27] mm/damon/sysfs: implement report producer
 type and state files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-9-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:36:17 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement report_type and producer_state files under the report producer
> directory.  The type file receives the type of the reports that the
> producer will generate and submit to DAMON.  The producer_state file
> enables and disables the producer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D8

