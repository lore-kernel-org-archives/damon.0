Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0A39CD0C
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476758; cv=none; b=u+whEH98qPsxRq+2LfkkbCWp2SH5YsHCIgPSHWiGlYuC+3klqMsfyZEROSYMd0y/ftDq5obnLhQb0/breHHEq+gzCwujHT2J1zHbsa6kwXr6nhKYSCM6Civew4FfSFkMbaadqn2/BKTZlZ8Gxu2xWqW8sfcYVgo76z+dUAb0vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476758; c=relaxed/simple;
	bh=uBg8jeA8bOzu413tPTDKn/FiUrpSe7uawrMELiftUY0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gAXkxBSr6ixn1w0ekem1YzVadEEb570lC5A4URXaawIoYa7G6aWsue9E3CL2T1lebIX7dnkxbkAwucDIejEurSQn7Z+xfT0Zb2khNfgDCN15qiyc3JY74J07SJMkVBNJuNTWE/XaaKgIam2ATeJGkTZiz0WaKm2nKXVpcKO5GCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbwsmxAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbwsmxAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034971F000FF;
	Thu,  8 Oct 2026 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476757;
	bh=uBg8jeA8bOzu413tPTDKn/FiUrpSe7uawrMELiftUY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbwsmxAAL75wdcENcT9dHj22VZfxDaLGh3N7s+ipHx9LklqXAi/SnKOTlXcZhYqRe
	 UM7mpvxcohoJ5rnZJ67Ivh53jUqZTH2CEUI/QNpISIqqKcfAKHnAReN1vBB5P6a26S
	 oT+odSclYvFWyi5N7cTCf6m0V7bBB/BjfnuZ4+YLCqAN7AUPQKJmk/UAJrkcU7jVly
	 43jPLBSWozQCwtt6UedJCi01owny3N/TCvoqaLLN/7Hf9P0Wk/f7OrXzM/oBrerx4Y
	 eInXBkTPYtyWXrRR3OR9FSAccCZnBWnHM7RNsEGlCymj0oSMimGCYvODtoNaYOVrR1
	 oEhB0fyJ5kOcA==
Message-ID: <sashiko-outbox-164378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: fix typo and grammar
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261008162010.4010682-2-manuelebnerli@mailbox.org>
References: <20261008162010.4010682-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 16:25:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON_RCLAIM -> DAMON_RECLAIM
> set as -> set to
>=20
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008162010.4010=
682-2-manuelebnerli@mailbox.org?part=3D1

