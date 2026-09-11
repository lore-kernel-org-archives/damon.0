Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BB31ED8B
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135585; cv=none; b=JUmaqZslTHsUZCJVfVeYqmilP8f6qPYD5Z1+uwZ7f1ez/wweaI0TguFQb3NZawjFDRm3tx2KzXmozC+VcnLo230Odnh860ymGoFUjySU6LXHqmeMLNYncz0X4hSUOzR1py/MUFiFxzCeY5taKnLEdqwG9cNqQCrXxeTIpQJ2mOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135585; c=relaxed/simple;
	bh=raIqpMLsc5PHUFO6Rg+5oB6Qu1587W7f8rvupwtsa/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1GhuhUtiKd9diVGVDeoi3Q8+wJVvKp22UOFXgIDUlsx0cnRuJa0j5jKzdEzv2P6q4kCE7CX2Xfu/s+rttufJgZ8u3Y53iTApDUSmD37St6ThwC0tc0ypTzp8LY5F0m6fPqt5L+frTrC1azVkSqO5J3EFGxBo6RzsmubqKof2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqXVw9iA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqXVw9iA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94881F000FF;
	Fri, 11 Sep 2026 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135584;
	bh=raIqpMLsc5PHUFO6Rg+5oB6Qu1587W7f8rvupwtsa/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqXVw9iAr4ZOqvUnXNNomj+th0CzbEFoDfobzk/M6ksAdVUQMFbo56corGzKvsAOV
	 R/kVSfZnLTXQeAtDnI+GR5uKg6jGK17tKSSrktbj2AnAJYpOkdKx9cMQTFSpCOi8Dv
	 PKUeNih9TPh67e5SDafdvYxeZs6wGXAtr+ijLeC5HCjq/Mq5HFlw/g4Zeefdv+E4iO
	 euZ3/Zi6Kvsy4ne1ekXNrqnmLEEg3B8qZ0dwWFHRfEtf/CQr3lV/ptP6rbt1pn7wI5
	 yfXAp21kLQbJcvPuF9s3vkz4EiqtvBTOQ0S/iSDq8G40FrfZPf4DBgDwx7aMCBLant
	 GpT9t5qjAfuAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] Docs/mm/damon/design: update for probe_hits_wsum
 DAMOS core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-7-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:06:23 +0000
Message-Id: <20260911140623.E94881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D6

