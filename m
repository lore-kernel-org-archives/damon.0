Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295537;
	b=uryL9LB4LSQB4S1Q2g/W9qbgO9BXY9tEwS5VVRMMyJXH7UlsYG8qnqnmcdjYzwmXT/ZX
	 V5q1RKtE0IYGVx2qeJ0UEM9S7AyHSlAp4jFk3Nb8nRn4nDvWNGL1aLa/xoy3ujYGFW3sc
	 eZbyiP+dUC9OICsRiCNLUIpDcCjIouR1dxL5TDR7VrmN++N7TZSl8pqRnsOLhAM8LQDDk
	 5PlaakmDuCvWfMoEjsbx78YsTHT8jkb8J8t9KVIcUalvcpBsrxOzjtFYhES25JZ3qjmMN
	 tX1W2VcIrIfBrUEvcosu6Wx8alkn281Yu7GLJ4AJg2oYq74znXJiu1pulfKV0ANVHEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295537;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ec69od6uylkmEhwRiNf3vf5wlMMnrmWKW5PTLsq8Bdk=;
	b=DqhaGbojZ7bIiX+7UPI/7ZpSGLFjQPXQeT+h/l7ykXcoV96fOCb0AENpLuuuHxtKMAws
	 GVKYuaXYXH6Xma9UlpD/el1xNt4QhH1TjgbZZsUruRSTDKQwUJwHON0rgUeLbtpprBWx0
	 L3NogG74IZHYcc6L4ierCEWrceIuz6kW7jvg+q0lCc2ex9AzO/0TVXuOfzByDCTIOi3hV
	 VvZjnSoX7vkUyuBNnLnIaD+DvA0PIF5vQYSsvRYaFXZYcFHUwnE32rl/lGKs8pwWZmXPn
	 blEQ4rhiz4CXxVWJvNF7chfBndOuaDEnltI+zmT3KiOEuD91VVyIk43f0Vw3p6ju/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYvcJBxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B65606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYvcJBxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3CF1F000CA;
	Sat, 21 Nov 2026 21:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295537;
	bh=Ec69od6uylkmEhwRiNf3vf5wlMMnrmWKW5PTLsq8Bdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYvcJBxD3oub9m9PsY/pJGp1dDYaeJPj2nOgRTR1breRB+usQXdIeEwRT5gcijWn3
	 r8c5BJq+hpP9IZLCNBctU6xior5Kqpyx+GpontMstH93pYklh3+8Q1A3j4r6YSlOli
	 d4E4J0WYLhxK7/CteePeOlnVZuF/cOEVdjoMIN31FtzKg7Yg3lCZb+uvEHuZ9wzP35
	 cbLM/LoCZi4Qc7G0CTAteLSpmCw6FJ0cn/F1GpPJ5NhQBlghGTVfWYBAxN4/z0A0RY
	 +U1luDqz7lXwYndapQOJif3Xk7nSOs1//qT4LSB9w2Ui6BHRs2ggzmHl4Fq4dvpkDk
	 86b2u8mvRyC5A==
Message-ID: <sashiko-outbox-227389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 00/27] mm/damon: let users report their data attribute
 findings
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 21:12:16 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Sashiko has finished reviewing this 27-patch series:

- Patches 1-13 and 15-27: no issues found.
- Patch 14 ("mm/damon/paddr: support REPORT_MADE type probe filter"): 1
  potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 14.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121210013.1303=
97-1-sj@kernel.org
