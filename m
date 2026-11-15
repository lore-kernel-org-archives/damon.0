Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775035;
	b=icSHcvhFN7rhA8VRKU5Li23yifNrdVwOfs/ZenbsZRj9Pj9t1bTJohKx58ndwrfnSKgf
	 36XELIHxXyTEiqiEmCKA202pPt6YXmH7LDYL3WiFCDrJt5D2UEw29S/0y/SmT6g0j0Z4B
	 wvg8RmjSflLRPE8nncBD8h2Oze4JasTgWCUkAhMP3IqTHiwQ2qR9d97ZBO0JWRW1gECKF
	 PTSeiMc0HSTHWl9YKkTYHKXZIdZYxwL8ORQk0X8+9WwN+SsPiWvMKYThX8qTiGhKeB739
	 21oiN51qcI3c0VhApXw05+u/Sq8scY9e9ccXRBR22+bkme2nxZIQFedL4HlS5gX9Oyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=79J9/ZgqXbj3aXaeyM8R3nlMhhLKAP5UT4UJD/Jq4QA=;
	b=AB3DF+nVFb1JIefj+1YqxqPtTqKTU1VO9kB8jxkY2XsSyy6kQVVkwpObVpysgl6yf1qs
	 rc3em7OPr7R9oFsupr7Q3aUK5FtEKovXsEBENVBnfzYm7lRu2PSsTKr0M2WVWoKgwmJQD
	 p4OxhdoT+PGBOdqi0x6klxQOA1fkLkVwDSbFbSmQdYlUp8AxkD0rdCPqpIrC+CMB+xwCd
	 XWTArVg5N6UiYRNpjPrqhMfpdHd2/Ss8wuaRFwEmZG1FUJyVD4BVIvgrqLCEDYxtB3u77
	 fUJiPOkSWOj0FpLqQ9mJW64QWcNjGmBzQWMlwrg2bWGWnJHlDNRKkUXdeHpRGAlsh3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mznTBa29;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003F606A33F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mznTBa29
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D3A1F000C5;
	Sun, 15 Nov 2026 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794775034;
	bh=79J9/ZgqXbj3aXaeyM8R3nlMhhLKAP5UT4UJD/Jq4QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mznTBa29ba77C9xbhxG+2A5Ft4cE9vczDm9npO50r5RPqVv66DMZs601RZ1bQe5s6
	 v506sTJ3QRG1WoWQatJJpcHb7HKmGdwA3DRLvZc9mAHVf3sCY225UFTOyGxR0HE/tH
	 b5QNbe5e9gz/Z5Hfwww1eDJFV1FoGHsReqVAGiBem03eSIg15qK/e3IUVGRtLkE6S9
	 2LnaA6tAbJTPQkQbqf8hwHpfRWOHMc1+6QQVoJsDg0n5YyX9GvkxLw8slLmJ4k/71b
	 FNFd3DhlDrMnsvn8r8ytR+67MGSI4HzHFSJEOsF07Skz1nK3OTRTX/gwGyPf2+E/Hl
	 UvQCRwuQO0DPQ==
Message-ID: <sashiko-outbox-215846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 24/27] selftests/damon/sysfs.sh: add basic tests for
 admin/reports/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-25-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-25-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:37:14 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update sysfs.sh DAMON selftest to cover basic file operations for the
> sysfs files under the admin/reports/ directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D24

