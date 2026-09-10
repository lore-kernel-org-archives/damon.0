Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67449F13A
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051016; cv=none; b=IiGPzWGjPfmiWPWVM2KFWi07ubIgwHyIc8S6AL6O0aXRWvTiZMsabJ6523RBn7dCOpNA7Q7FRKun1E85IexCwUNPffJ8TXo+AcOBGcHXGGDR2AJNhRDHoNNaLTcEffkmTPHi968UBl+UYQLBiMHc5+9qwyfQZeKq2OaPYxafGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051016; c=relaxed/simple;
	bh=H9TFqxkc7ljsYg29gk1zsxdo672lhRWfdi61D7kJwoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qy/l5h11DAfqzx2qB1HhVokvnISHRISy00mFNUDrAukptqPvUxuMa4j/cfnSJFzhf5FGau9mw2V388ycJLWwYFbiHICyWXclEQf9n+T7IvSLDuvZN1tVOc8PiWV/VWarEkgJUvXSe4XTFrS/F2Vt9EcmzsD/RdV08iECsazyH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Lw4XAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Lw4XAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1551F00893;
	Thu, 10 Sep 2026 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051014;
	bh=H9TFqxkc7ljsYg29gk1zsxdo672lhRWfdi61D7kJwoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2Lw4XAoiLBqM/+6GYcPMMCwIc9uTywj31ttmqxdtE2hvjDsdfv5DcpQ/kz43UHvI
	 2omQu9Jk0lpoZ7nZszeNGQ99LkbMXPZsratSmedVSa7Xz0/M6o4zZ38vKBKUZh0/Mq
	 mTZGFUKxiZmzpCOF3/wk4PcIOHyZOZWALbLpE/gUQAE2ePsfehsi/u3JhbiJ+m6S8i
	 gpiEHrVDMNSwyF9awhaVlEsuacTLv0BMncBynocJE7UJc/vgzLQk9xlzJQV1JxyeeI
	 5nsiqo0DuDcS0n84wXDA6cRO0snfbPe7jKVJU/ar502Dk/ZfesBawR9/zjs/jP9c5V
	 ECAUA4U6gQDxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] mm/damon/paddr: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142234.171562-3-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
 <20260910142234.171562-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:36:54 +0000
Message-Id: <20260910143654.BD1551F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142234.1715=
62-1-sj@kernel.org?part=3D2

