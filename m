Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368B2D9ECA
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199436; cv=none; b=gRuRRhnMNiLSbCEHjsZdCd/KxDuQZcrv/oHEC/I5lV/WnJJvs59jTmzaweRpR/HA/MJNJ/VgQ7Dx3N2XbWNbmpka/Ya/tOIzk5j5cIf1ScTIZMhJl8rwavTXGUbwEqpnJCQ4Qp42amEoAkjAZ+7axkoU0FvaRZnconB5fmqyMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199436; c=relaxed/simple;
	bh=r0fUyDnfS3NvYHPR8k/453x0zbJiQriETWP916qHue4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NskSRve/HKRzMmkX66J6UItXCFGvogtOaZAHYiMCVsQ/QTPBoPHGJKz6Q/JrRf0rD6+W4gEWdRCBXNusqnqiQA82BMe8MgA5sTfRLF2th5mhhVS7b201VBtRuqz8LA8EBf2uG3M9pL7SSZILvKlTBoRHzdqpl6YYdUvobPczIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfyrvDI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfyrvDI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FCF1F000E9;
	Mon, 31 Aug 2026 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199434;
	bh=r0fUyDnfS3NvYHPR8k/453x0zbJiQriETWP916qHue4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfyrvDI0CyY3kBQBcKxYW3+4ayyapG+V98YeQkKQcIF2o7IzT6FQWkKcem9NkKMsm
	 gwpIZ0U1zk2nuYN5h8XUJlBic0XufsqzPz2yO0tIbbvxdPjP+qzrizgUerGp/uc5Iz
	 mkGIGyFdY+aZv1qCg9lGXff1l81PygHL+JV5+GiRym/gFbzCZ5FTTS3kCLIfgKb7gW
	 Lsjf4BZr76KBbKfRU7D/JGXW9vyoNh+8zwCeG15M92/4B09PA8SZHQeJMqt+J/imj6
	 D0m2QVybBchAd+L9serrsulXhVf2Gv87QTcUXTEw42f8PlDI1sf+o+b8d69jCvMAFb
	 agkLF4Ovu/0bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] docs/mm/damon/design: accurate semantics of
 nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831150227.83416-2-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
 <20260831150227.83416-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:03:54 +0000
Message-Id: <20260831180354.A2FCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Change "tried to be applied" -> "completely tried to be applied" to
> maintain consistency between the documentation and the code.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150227.8341=
6-1-sj@kernel.org?part=3D1

