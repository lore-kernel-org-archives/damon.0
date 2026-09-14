Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3147DF8B
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396214; cv=none; b=VvQBIZz9nXLAretZ2ZlbbExaR1rLE9Cd4YIn3cXq15DCwE0QGqd7wPG3c7CrvhLu7M3xVF8op8cJcr2EVtWUW9H+SZO4u9fN2ptgKOcblWPgiKRZA80fdx+Av6i09/Uop6r5LUOcMyNkMcNq2Ohy1kxwRtmSMy3MgiMzFtllX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396214; c=relaxed/simple;
	bh=1LBOrAaFabsruOJK8owO/+yY+RI3Jx0k3gamKfN0JW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=keLAE3jRst7DEPmxJZ9WrlJC/9ZWsvAUHKuxi0dr5xAoruZVFCeoE/XLfHgw9mdNvdPiByeZPO428kiUjt9IRcvGxDj0qQpaj9C7/z/0QNgoNlpKObNzBVuWwzKxG9wkpgGseJIZsW3/AmbRKz3kMqW8XdqA/S3piiBNMpcQhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb2HPbFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb2HPbFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452C61F00893;
	Mon, 14 Sep 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396212;
	bh=47w0csFtqO4yMyGrb2xP+GHXjb6r0ydxMpUJBvpoqBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rb2HPbFVA3SIi4Fjh3pzgQe8cD+5gNyrf6VBC9Tvg029N1sTKlwZL1vEX+4r4VVO5
	 kCgb5jKQigGgxgSdgAjXNAjNQzVc9MMfFAn05z8DLH0L3AB4TG2Q8L5lvXsy4rRpxC
	 e8Oll63wDWs7tshbLbHlJ/FygVsMhzxXN3kkXId4SUjU+k60Y5IMSOCqtQYP9moLRf
	 a96HYuq45NzCFIZzSPgX4LKMM5ma9D6AvlvmJS20scnNbmSTlKnhfvJEM5dHq8bjPH
	 f6pziEgOrfEDFMqlAjXdu1sE9QAa5pQRlIYPvP9E5NAeXiuR1xhbU6R+CNOuTyBfbo
	 ykJMP9hngTC7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] selftests/damon: stop kdamond on error exits of
 no-op commit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914141952.91465-2-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
 <20260914141952.91465-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:30:11 +0000
Message-Id: <20260914143012.452C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> The sysfs_no_op_commit_break test starts a kdamond via sysfs, but its err=
or
> paths (e.g., drgn not installed) exit without stopping it.  The leaked
> kdamond then makes subsequent tests, e.g. lru_sort.sh and reclaim.sh, skip
> with "Another kdamond is running".
>=20
> Wrap the post-start logic in try-finally so that kdamonds.stop() is
> executed on every exit path.
>=20
> Fixes: 10725cd2b09a ("selftests/damon: test no-op commit broke DAMON stat=
us")
> Assisted-by: GLM-5.3 OpenCode
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914141952.9146=
5-1-sj@kernel.org?part=3D1

