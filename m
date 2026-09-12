Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0A399354
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243855; cv=none; b=HyKl3slMl2eSLtcO0rImm/XuD8PKATr1EkIXNHOF0wLcT8PhdfXd9DqIvdHL1eZZnUgwj2E7KG5Suaqvt79dlEe3XbjHFFKooSKqjIG13zlzvSnNpgbFgU2yl4hMTWZaYGdCm9vTZ9B5j7dux/21KAx8tRaerAm50JpcZhh0hLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243855; c=relaxed/simple;
	bh=c6s1GwU42mzR+FpJuCeHapjU1UAqzMDnYqKXtiR2bi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KfryxrQ08wrOSfOpfeMCYqzFSGddNXdvt5BT9VNWz1/iNoeubO348p52alxWK0M+fhN9HqDerl0LPJ8KSdvsbFvRm+LvCNfdb1FenWMqUyX/MbQvS0kE1o6oCaa5LOsOS72Wn9ruMTwaNSutKodtXqrdR9ooQhw7luGHFPyp56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM7MNa6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM7MNa6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D621F000FF;
	Sat, 12 Sep 2026 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243854;
	bh=+kvY/LX5piRJVwT7LIGrOLHxLqHKZinJ8QEtc6LazuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dM7MNa6+SH9UHjLrRU1Yi89NtBeGh16ZtAZ+DY3AwAD72ADTFJt9IJG0R50zWwOpD
	 A7b81w8AG2xb0J++75uUEdJofHJbWKdzS83/diKCd/LbhLtQKgfu0g8qG2bD1RmiOe
	 uashHgQGIcLIZBcqD/tjsjSW9gtP7C5Yw7OB6WUpPnyaBCboYSpXSNxfKl8hep8t2e
	 pn++GvyK+Avf/Yeeyifvu0u+hYT4CY3e8waY3W9wxCWwiD4CAVTvTT2NGlWLABzubp
	 lUE2YoU80Vwy22HUpH1SJhxwK8VfmSUIrZ76z80nz5kz4HQz6zhwZgxorQTXZ1cNdR
	 rD9bo8OSfI6tA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] Docs/mm/damon/design: clarify bp is basis point
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-10-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:10:53 +0000
Message-Id: <20260912201053.D8D621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON design document uses "bp" for "basis point" in multiple places.
> Because it is not clearly mentioned, it is difficult to understand what
> "bp" stands for.  Add the clarification.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infr=
adead.org
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D9

