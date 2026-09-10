Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF8381E85
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013733; cv=none; b=uRbhMDqwTOuL81Ac2DZ+m2LgN92vhWxOrR+VHOKzCs1mI57coKPV/3pWwZkiKzl6my+ic1rQBpIXbWGd191sdloNsih5UKxr5AKvy4GxF0knADhxz9EMdKJE8KLh8Z1I6bsDf6PnrfcFfqeOxNAUcLIbykjMEerX4CMQYFN1A7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013733; c=relaxed/simple;
	bh=k/Auw4MXt9jGcwD2fT9gqmBm7Ydts2ecaMrwRg9GZ6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ht4+UjlrJctGti4KHw5mQM/U26ykUdhGVAqa+C/h70Q4dZfKGk1P8SojvN3g/DqEBf4EBxYtN6cd4tjsn1GSsgCyW5v8V9unkWy2vPWsRtyQrxih3G4jryvmiz9FG/eVMcHoQ6VNKRMZieutj7p+5eZOdHgGqFtk7klEl4N9ItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6EofRNm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6EofRNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ECD1F000FF;
	Thu, 10 Sep 2026 04:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013731;
	bh=k/Auw4MXt9jGcwD2fT9gqmBm7Ydts2ecaMrwRg9GZ6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6EofRNmkRsQ5VN1ggZp+ELz92WhnQRqs88Vm+oktymSVR2ur9VgPJYBjgqMiT657
	 2FXwcT9zowT219FUg3s6VE41g/4tzfRWkvQzFgFN26zs0s1kCqCAp+n7sCdJKUZQjQ
	 NHvbTQJ6cUfxl3eb3oqv7QlmvQtbunRnz9SoGJtdmv2hAnN0a8BaC2Cq+Mm2prdUZI
	 2+0m3oEw1AbjOu8wl8korbNE5zT9F7ODvvR/ZgQW6Vj1ySIchAIRD72opMhVrjwWqc
	 zpd7mgk0x+zPXsBtSbnl3nFaf2FcivoMLxEgxq7pvWY9irEfjeHRDyI237wigLY4+2
	 NbQQrxjixQoaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 4/5] mm/damon/sysfs: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040911.148273-5-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
 <20260910040911.148273-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:15:30 +0000
Message-Id: <20260910041531.19ECD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to let users setup
> DAMON_FILTER_TYPE_PGIDLE_SET probe filter.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040911.1482=
73-1-sj@kernel.org?part=3D4

