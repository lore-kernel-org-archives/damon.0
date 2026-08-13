Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB42749DC
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593499; cv=none; b=XQZ2GtLcoUzuJjZc44LpKbl51bQYtIipHqBbQ26/8ToPDKcPWvIq8TOwRiXTMZGPnpuK5Y4OmgVdXyMYxfdRGjNtS5grNZjAeZ6pBXqRB5rjBpmAAkz+20nKYkIwWIlBL2tGvgrzz5S3InSfz62/mtmlEVIYOG2FYe6on+2QKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593499; c=relaxed/simple;
	bh=qJFOG+gOoB/wDrjSqvvhexvz/ciWHnHRyh6GrNsYD58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IswtoMU+YFAEqYjE1FjUMoBdUD7uIxfEkO8W7rQDk8cTubj6yVrIgFvPPeBdG3Pm2/9siLb0hBYn2SEbT/I+KucIcE4LpKQpK0qghsRGmGHlorYos6ncsDfqGn9PJCzudLowa7KO2Mq916EJ8qfVN7bZrS8SLRTY0NvUrCX4UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAy+sQ8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAy+sQ8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4BB1F000E9;
	Thu, 13 Aug 2026 03:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593497;
	bh=lrXOVbI6VeEX4cInWH9kZX49TjcA9ZyLPnMYUJFEtO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LAy+sQ8UqDpDR5BuUtDRamae/GglOSltkwUdprZJcPBvUEuktDBaa4adZHseZJeIj
	 a/tquTXJrhOw1W+PiwTQwxCVcJp85YZjbEVXc/i58ZpDCQQ1hjwxvPscq+baPlxzVC
	 C824YE3ZTABuVCKs54IoHIn4VpKU6LDpqqU/H0c798x2/EvBjH9pIWDzU4x23kWz2P
	 /2XpNsiWXG+209NHvZmCzizrw++CInLWexkSkZTHcCPt4XLd40lDYEANzlU7d72RAq
	 mYert+ARTNXkaQozmeFQYHnpjEr2CsP7i01SlS6hR8mJVAs87WuIEMYyyPb7afpmd4
	 pfKBDzg32Yc3g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] mm/damon/core: handle NULL ctx parameter in
 damon_call()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813035001.97364-2-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
 <20260813035001.97364-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:58:17 +0000
Message-Id: <20260813035817.8A4BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When NULL damon_ctx pointer parameter is passed, damon_call() could do
> NULL dereference.  The caller is responsible to avoid that.  It is easy
> to forget, and there are many damon_call() callers.  Meanwhile,
> damon_call() is never meant to be performance critical.  It uses mutex
> and completion.  Add the NULL pointer check inside damon_call() so that
> callers can pass the parameter without NULL checks.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813035001.9736=
4-1-sj@kernel.org?part=3D1

