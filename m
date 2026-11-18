Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969018;
	b=eh/rY+udV25bOi1UXtkWpeLIU1u4qfhtOv+/6sNdkvYReiKJ6uB5Hhx9xqeC8wR0sFs3
	 jZdO6JsesJ1BqUCpNkmBDQ0oP3WpY1O2m6mw33wtdeKCggaKtaJgf9YjpFGebKGX69KnY
	 YWe1EqbqOsfXtEf1iL0YqgmZzRdd4MnsVU5WjQnaqf3s7i0xOzA1qMsIOcfU/oasB8ZQF
	 0woPaTF4tabV/u79YJ0NwvRpbfEz782ighbvloFdD5Kp4tgnq3ViQXs0noRPHwjp9OJRW
	 YVQoUUGmuyNAIwDKA1K+B0dqR42bnGPWyhCaG5pbQyxn83MVjKpqhSVHfHDNvQ2li9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9CfKivM9iOr0fxIfpCzvTVwLTvEkaAt3ZbbMPJaCe1Q=;
	b=nr9OE13jxC+RjG/bwjuX++lAcNkIBp6Su+zJfTdgmeNNXBW1KKeFXsqCEQ4V/TiER3R4
	 5FbYqtrx3L2TUxs+dS/fj2Ooy37/wHzgyVSz321N+f0S/c/IwreJsEOt3Gl9tPOIVatnW
	 Y0RQAc6CXeNa/8jewW5IlXqHHwhjrSdE6TM9aydrG0QO/3Ck3/gclUOgqz68AKa9ksp8Z
	 CyClXiNg04KYnFD1zllgltn1GzrG2wAb5ADMGOO4HSgj2vjEf4JH7gepj8G7GMGwvpyzo
	 7A+jsMRSjX5PaSVsRfTBUCid76IADQfa4hf3HXtrGjPyv1gqe6bOK4k8A0a7Zkjy8ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWpAc6Ge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D69606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWpAc6Ge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B891F000C4;
	Wed, 18 Nov 2026 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969018;
	bh=9CfKivM9iOr0fxIfpCzvTVwLTvEkaAt3ZbbMPJaCe1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWpAc6GeiK3634olTgJQ7nHYufDSWB3x+BGrHERHMBTTs8Ojt2dphEbJfqqS7aL3J
	 EG1/S7tB2zyW3Q0wIVuh/PlpZ2l7Mq3vtrAF3aiLLpH5ZjgT57p9N+RDdRKVD6+tTJ
	 4Cgr7lTlTfCFjWFn5UtyrukE7v/ANMPrGhPFveZfjVgarIb5+MQMQbjAHacpYkOOwx
	 uosGhz/ISvKi8JwKcmjz42Ac+lxVSts2ziaZxRJZjgdpxr8JEA+tSCmk5Etj9VCISO
	 7HlZNq1iK3IlR3RFAFCicBHR+75qBx77EIVi5eqa3CQ6CSjzsERKSIQrBqOwQZnUN7
	 Gv6Y00rObMJGw==
Message-ID: <sashiko-outbox-219964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 26/27] Docs/admin-guide/mm/damon/usage: update
 for user_report report support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-27-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-27-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:30:17 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added user_report type data
> attribute report support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D26

