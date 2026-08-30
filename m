Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF223393F
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788067124; cv=none; b=ejZzQg6dkb7qIMyxjaldgKVpFmoCspvWPNjffhfMLdTB70ovW8jLzOgME6cczTuIgYWGdzrSH2go7FtS5H8HwxuqAYW3zyPPgeFWt/LxOgIjMWqQ0pSIXPYF5zYDRYO2vHFT2N5a1uJ9J+qGWn3Gfv+Eh2dd/0p+MfT4IYTcyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788067124; c=relaxed/simple;
	bh=NoL1Z6rtJ5gts7N8gTvQ8HBA60CfpGlrdmZTLfI6/Mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHAL4UfmdGKmk71IE9bW0HtM7sSJv1WTiantrgq74CnVAwwERK6QJIg+r1g4SwUugm0owro6dk5hAt+3h5I96mcDoGyysLcvcQsPYrvayud/1kpWDPKTnytrMtcUS13yf10Oo1h1XYRHFaIKFnOUlqrw6smMsDtqftiFRKxxdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFDmqSIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFDmqSIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FBB1F00A3D;
	Sun, 30 Aug 2026 05:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788067123;
	bh=SCKR9GyJqPL24VhnR7yV1Hyyd7W9qei3C8y/P6RL3gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFDmqSIMTHV0qL1qZ6X8KH4D0ENxXrVCuUQEMbR7cS16vofDy/tYApGJvP/38SYrx
	 XUeuIDem9bWjswFceslFBT+bsJXCZ/mbm7LnNGCzyVQfKNrBcynoEOlzuuZsLQIPYo
	 MBIdGiQcE9VYZu0aNnAM7F/1CBFvKsmfTUZPSwUJyZWD6hqXbJ4geLA0FFMKa7QhM5
	 IMHLeDgQpP7oFYHM5jf5xy21ZTrcQtWJxY70zH/3jQray0P3e0CErKSyY2XxiDporl
	 Rn73F9W6QKm8L/My3bjCdyeSy+WdBnPrdqgjJmSXpsVcicbJ6cpVKQ39stJgdPf0c4
	 g9t7FjTooYOBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] mm/damon/stat: support aging_flush
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Iyer" <kiyer@crusoe.ai>
Cc: damon@lists.linux.dev
In-Reply-To: <20260830051407.50008-7-kiyer@crusoe.ai>
References: <20260830051407.50008-1-kiyer@crusoe.ai>
 <20260830051407.50008-7-kiyer@crusoe.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 05:18:42 +0000
Message-Id: <20260830051843.08FBB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Let DAMON_STAT users opt in to flush-assisted access bit clearing via a
> module parameter of the same name as the monitoring context option.
> The parameter is applied when the monitoring context is built, i.e., at
> enable time.  Defaults to off (current behavior).
>=20
> Intended for virtualization hosts backing guest memory with hugetlb
> pages, where non-flushing aging pins the observed access rate to the
> TLB-refill rate (see the aging_flush core patch for details).  Such
> deployments can set damon_stat.aging_flush=3D1 on the kernel command
> line.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830051407.5000=
8-1-kiyer@crusoe.ai?part=3D6

