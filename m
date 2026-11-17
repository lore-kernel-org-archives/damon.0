Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957965;
	b=gr9nDHHwIidlHbIb4PuQzpd4XpkDOssUi9VUB5HcXguEVubQNGOkXhBYTQmbUsQB5mi+
	 nabumEt+vHAueeHGj/GsMWienMBU2FJpGyEYWyCV8ecxYGrc3TnwSHbYwyOc1WZwdW3DK
	 Z9X6jDHu8iIksiE0TQeWCN57ofaOKWk1VLJiNndA5S9ZdYTg0aU0289QIC7pgEWSiud4T
	 SpLBkDLda8T2k6JHfu9adXT4qGSR9zc8pcEJiBz+n8tiI2wq3JD9Wm56Ef2IPFsHSwDNt
	 su1SmptkTJh+YHDEL36Q7LPpVEwjo+SQ+jijxb/kW/kKPKXgiiZ8H/JorKy20JhOhCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wJEKiBhY9HVX0lbIb0bMOIouvQtnApc0shwWlr3YQVQ=;
	b=d5hh0tOxMhcKz4XGfM1yago6N9/7d25r4LVuCMO0NHGImNva3mxEZhxh/eEgjTO3Pi6T
	 pmsvzTTMMsncRQcYPHGT1YqRd9o83/qNgxedOsDuU7k7AoRyBHz6+i6vDzl0fBv6of+eL
	 HclYloqUaZarQ1mwASiTm3eq1X6eFfXUiOVhZsdBfa4adNK2aLKdVfQXUqMddInMNPwxr
	 r1CxLamS5c+HxGSIRmUhdALdqKBVX5IzQR4aaPz+UO3ngO5wCzM6mn4hmUOuY2b/qht93
	 AO1gflOgE0R5CiP0b00B5aG1Y5bMiAsLaK8X3y6adB3bwV0DpIIzIWLVgWDk0ByatqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOadtIFn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B08606A330
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOadtIFn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72511F000C4;
	Tue, 17 Nov 2026 23:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957964;
	bh=wJEKiBhY9HVX0lbIb0bMOIouvQtnApc0shwWlr3YQVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOadtIFnVVeDkqRy0E8fgyDXwwW8YD5ekRI5mrj2+mVobcwyph3dkSny1ZuAFdvvC
	 puQ3ixFbh6SZt3GcU5cEQCfcx1BF+zlXC4YTJFboaN9WfEEcC8J2IBfuv6WcItaUOU
	 ivfG5Jz0WQJhsuDklcAtMmwvBAWzMqFaXuoIHvAJp3P14r5DVFw3/W+nFv7CYlmj22
	 vNancyU5cDmHFkJAO+xYN4GL4GV5rDz2a5l9GfJlvGzQ27rioxN/9DIVsiZoWoOg+I
	 Z9HP0vsiMKe7eepS0ck0yv7W+0E3hBfw7K9tzmEr0meZQBveAbPA7OQjecvywHUGBm
	 k4ZfqX/1mJ0RQ==
Message-ID: <sashiko-outbox-219791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] Docs/admin-guide/mm/damon/usage: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-damon-sz-ops-b4-v2-5-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
 <20261117-damon-sz-ops-b4-v2-5-439888fa04ac@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:26:03 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> Update DAMON usage document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-damon-sz-o=
ps-b4-v2-0-439888fa04ac@uber.com?part=3D5

