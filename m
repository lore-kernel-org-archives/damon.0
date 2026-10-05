Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E24192FC
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190469; cv=none; b=NLExU9j7d+PwsskgvG3SXBBA2ioP87fmZZixhQUlQpFtdZMu6TXMyfrWw3WBFLqnh3l/WfvIJuQcIBZFEvUsAKL1fxJJvTzoeWWM0OQ3f8NHWUo9DKoimKbEaJ4TPscmA+DNOnV96DsRSh1Vi1xOtkwtuox60cpkZCdSiq0esDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190469; c=relaxed/simple;
	bh=UVy6Am/sD40uGDoDQ1nhUo6k1I65DvileifLVwGA674=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K7i4R2l7V8Kyq18oTp2KQN+iSbEHDVJpQDhloTjZ8g91smF0jIxUIybsaDpJZCFvroS8M+UX/+1hmWbq2tVQBoaeL7bYk3S0+HeevAH5HoelQ/X1FCmBaA+I+OD/FyCEJSGiyOYVPCzPqNFBrBiot3Rg0yCbFCIihUKi9He0wBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLEq+9dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLEq+9dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85371F000FF;
	Mon,  5 Oct 2026 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791190467;
	bh=mTdNEVsLnaEx+vJed4c5QNCCn/FPOzo4qBXm7x5R48k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cLEq+9dkoHI/v77GD7iIycqSl+GeW0VZDEJ2yT37cJBTpYNqXaOG6SnPiNsEcsG1s
	 pcfQ3QjO+n5QoE3VKJqXoysMTvACHfzaKYab39TEJmuAmAS+6bEYKmTGhS2On0A56T
	 QdyKhWw6cF+B7XTs9LH4d4iotCiBX+t94Npa5W2jffH2AA0g9jTXucz2zlxfKrtdDX
	 CVcytLTkFkg4tFlq0o5AJVWV00j2ENY1GxXb9vUaszMNX/rADtdHEq5x1iLLi2gJbv
	 Sqs/X64ygkK5vXsSSF2spVOaKNPWstqymhORffx879zOdY87cJo8eMdtZuQZBBwRn9
	 xtaDZpaae8HGQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-2-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
 <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-2-b03452e137f3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 08:54:27 +0000
Message-Id: <20261005085427.A85371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_report_access() queues reports into the global damon_access_reports=
[]
> buffer under a mutex, and kdamond applies them from there.  A perf-event
> overflow handler runs in NMI context and cannot take that mutex, and the
> buffer has no other producer.
>=20
> Replace the buffer with a per-context, per-CPU SPSC report ring
> (ctx->perf_rings) that an NMI-context producer can publish into, and a
> kdamond drain that credits regions from each ring's pending reports.
>=20
> NMI safety: the producer uses a busy counter to drop re-entrant reports on
> the same CPU, publishes with smp_wmb() before advancing the head, and sets
> a pending-CPU bitmask with smp_mb__before_atomic() so the consumer catches
> any report published between the bit-clear and the READ_ONCE(head).  The
> consumer publishes the tail with smp_store_release() after reading the
> entries, and the producer reads it with smp_load_acquire(), so a slot is
> [ ... ]
> the access_reported flag and kdamond_apply_zero_access_report(), which
> served only the page fault primitive's reports, with no user; remove
> them.
>=20
> Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-damon-perf=
-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com?part=3D2

