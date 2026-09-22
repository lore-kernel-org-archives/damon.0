Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD68572669;
	Tue, 22 Sep 2026 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097556; cv=none; b=WXKcK2svjKOVdcz6TT+urQVe8aYjyKBUKa3SFGtEbjDIFZ8WqCOECJDt/xC4Y820xBZqRO7wNccTAnemgHJsB6nlN3UtPkGMah5ySCjxEYnyCeyTABz5TBAFLVJHQb2BSo8y7d4yRhFVVAuLYMxU/SbqOjAsPvE9J9GPoEfspZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097556; c=relaxed/simple;
	bh=7lz0VgCpGAx/LnBgEFLc5j8/O+Qhz3D9nWW31eDU4eY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k3STO6E/U4WcB3idKxCORiCckzoumX9zH3Cs8z0UvPKvZl6JE8XdSn0qPTCXldgyOQx6jHyRz7Qlu9YfV+4382+Tl38gyorzFJ5Rz4iOjfKH8+SgcHkNCZkxzqBHoIYHqGkg4xSSlUDgyH08QI4LF5O3ZqEYuO2XKnrT3QrmzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdYKdpmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdYKdpmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD91F000FF;
	Tue, 22 Sep 2026 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790097554;
	bh=7lz0VgCpGAx/LnBgEFLc5j8/O+Qhz3D9nWW31eDU4eY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DdYKdpmxo2sEdyUjPnkVLHzQz9QdIEM3niWUbASl1udcAIEcqmumcPhCK2lpnwBqy
	 Wuec7t4087JyxfNzIkUo47F21Z0h/v4xqCpCa72hOQZWEPbNvyZFZ6YhwAeR3Xevxo
	 JR2DDykynr3Dtpcc32/+WO1va3T/9Q7zel9RMP/DKCMjpmeMfyfLIZ1tm8Ihw91U1M
	 ep2vQD3ux8jaCmOdQy2YM1fQMrRhw9g9QWhR7AIUwV6f0k5ZpRg4d9ZU9rZ0foCjrS
	 NSpdntQDtRB5f6c4oynGd4GJKJtx6yB54TXJAGqiyC4LdnhOQqhv86jYPxhpwdkNA6
	 s0lhp90rc50LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] mm: convert PTE table entry to pte
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, damon@lists.linux.dev, linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-5-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-5-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:19:13 +0000
Message-Id: <20260922171914.63AD91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The non-MMU stub receives hw_pte_t but returns a software PTE value. It
> has no attached PTE that requires ptep_get(), so convert only the stored
> entry through __pte_from_hw().
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D5

