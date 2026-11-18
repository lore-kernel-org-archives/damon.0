Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968891;
	b=fvivPX0m7Ncqq8XYbYc06exmTVHLOlxw3nxa9SW0SXaL1toX4oeV9FP5X5hEAxO+I3Iv
	 NfVpeRrLJyXq1VTPpG0GkY+iFgmvyhcw2btC9Hj8KfGXRJSv9M+Dm3xjj3poWv53juMJm
	 3dEgdOQ91mNtd3khiIKEWryQshLSHKA7IngmrwB/dfhqKFwDNf2VexOz9TWF0QWrcsn/g
	 SAIQ72U2ATToHpFPszPQ6QKX23NvEcslKGtnnqrWPHTv56WN/upw24cQuTAw5yVEfB7Ie
	 o4MJTmP9G4AWSSpCZVk+JHgVyNc72Xmv71RKCM9cBrtPk5P51cWdAVVivL6bh98TSjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CXIdKierYCGpjdcQgZ3KKaaBGOdWkX+vyhjnpFRmQok=;
	b=vpR64qyKLwj06qWL/aE1388/kGgLbthTwgb5epx7WRaSeSIjcMhXNl1N9osDy/46ETIt
	 JFklUB+E89UTXtzAlVSSDcn38SI6mMJ1WJ3q3VWGtlUnfTQMeYTPo47l2D45tbd046eih
	 mHpC+IS3trcCQVV4snnvnyb0ctsw2BcvlNG9NY5V1B6ug20oovPfloosxpLKwl2WJvplE
	 bHwttd8qhQe1lHunMn6GlTdTmmm8W5va+36kyRF8oWb3sHpjvoOKoG7vDobA+lEqw7Lii
	 5ufzXcQQw9JMi0VdVrOlWv5nFeQS95WD4RcUkKkzXbcB6Wdq4E3iOKE3o908O3LFtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LG1Q6NHH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38823606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LG1Q6NHH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC71F000C4;
	Wed, 18 Nov 2026 02:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968890;
	bh=CXIdKierYCGpjdcQgZ3KKaaBGOdWkX+vyhjnpFRmQok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LG1Q6NHHHPlI8uDK2jIQiElOM1IssTMKfl3MXP0tEdCL7k8TJ0xxz5MrQvRd3ewtI
	 lj5laV/0cW3nERRZi1PDWTjCXCDpa1QqvWB4qD88MDmtGaRuIpz2XVSy6piUwDC9t4
	 7NfBYxOlgDpfmNXhd3+C0IhPEq4rOqHlDP3yAM2JIac2I6Lj80SHUwecclkAO8k0NN
	 TY8XTb0kL54J3DIL981/Lv6tFRMah6YjoqcW9aWIQXtkUA3Zh3Zkrcqd7xAl0GtDeD
	 723wn1q4A3Z9RVC5O9TW3PtazX6qLmai009bzJIBYngDoixs9HKFuWvPADL7QMKT+U
	 pRze+qIBnO3gA==
Message-ID: <sashiko-outbox-219951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 19/27] Docs/ABI/damon: update for REPORT_MADE
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-20-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-20-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:28:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added REPORT_MADE type probe
> filter support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D19

