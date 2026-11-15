Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774808;
	b=lMQ8g8bphMBV/V5B8jOpz7Pfi1BHXyUCL54/pAi3t1dCZabwd8SNu7unyoUZPowfJqbC
	 GZyA4+QlW1j3ygCQw9aMVxG4xST5ooC17s0XYDwsV0DSsp7Q337gsbDBRKv6IhjUvJsXT
	 bsARCK9E840QuDpgGgFjqWfS3rOk4d50FU18FUuUTwT4f3JSOYttfaK5iMsiNpngkDO62
	 9z8dAMfqRGxx9SqQ5oUediHS4hyqguzUkR7FSXVP5TzAiEffLps0PZoV9W511UAFJobQ3
	 kBWvFRN03gUBEe8biy8gStNmlYb+rB3ExaZJwzXGffmeIvr8r5jmgPeBZOkPHvDMEvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774808;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FhXuwHxiZQUcl8/qhypUWoaNJHNBVYsxNxSBee854tE=;
	b=nQIR+Fp5dAoHzQ8ZT9gZh2jBDaz4IkiYVIW4zfbgzXxUQ5ERQRWJv3phZEQs/GnWrqlV
	 oe5i4xu+PzH+gD3eqjebap6Y1DFmYWXR0ReB52BFGnRFEWfYD78nunLLsFP+QtZqySyTF
	 nQ2tIzVYh7kYGcKfy08Y2Qro1rY3qn8PTwfwUZkbi0qwfkIbx6yw30T9tONw/76lxUOE0
	 SvRs8urOugepPXgBUtuSfmfID0dktpqHKwmWyK6fhFsExZjYaYfdOo5aUE1oHPbmFCxFf
	 +NoOppIo2ELOpzMIZg0h/u0z961Ct/KXw5Bh8ota1OqsO0OBVn4nKRbb0FaiBJ4njsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAzp2Cr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA95606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAzp2Cr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239421F000C4;
	Sun, 15 Nov 2026 20:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774808;
	bh=FhXuwHxiZQUcl8/qhypUWoaNJHNBVYsxNxSBee854tE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAzp2Cr3D8Lv6xOfKDuCzMY/VxFrSZ5St4YGtbWfwwpiyVfRnYcBpoCADTVH5rwgc
	 8YuicIpo06kROCTx8ZR8sru4kfADf3psxwYsUvXDt9EkLq/dkqU3kaHs4mAvLhF5GK
	 COxy1Jlleq0nwHOCHkYjp+p8JdOJk9gHF0V2+joEi7jWmf8j0Zaz7MehjOafjp+Okn
	 cYJ9jw4fwXm7uo90MLu7r16vFGYuEK/l4F7TIe8LYWTJHekmzNvg6JxwiGWcT9BXIL
	 RzKIio0/ujygXeWYmjwcy2U3owpq6ibQukPSf6VCbkuwa/Di4ecPfnnOOW8cR9q7Cs
	 D+t141BrkRUfA==
Message-ID: <sashiko-outbox-215832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/27] mm/damon/sysfs: implement report producer
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-8-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:33:27 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement a sysfs directory for each report producer.  Create and remove
> the directories for reports/producers/nr_producers file writes.  It is a
> placeholder for sysfs files that will be used for controlling each
> report producer.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D7

