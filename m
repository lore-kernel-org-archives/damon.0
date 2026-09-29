Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4F23EA83
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669165; cv=none; b=LuR4dnUw0JTEYnDFIVgvA2QQk/GJnW/pwyxTdcpcLzzKkWsdJxWZd3b3JUfwxi6/dYJkZVaUepn3nZQyu4LKQiBuje059l/XVThYcxPLnyqWPz25XA1X/nO+BD2MlpVkoyjcIq2mPgZDHtctpv+fUfFNZ0snRmBBa4kLprNgVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669165; c=relaxed/simple;
	bh=tdggbOhUo2IfZ4awxXT8xRlJDd3PQAwDXCjzEpxCBCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHMLS9AYqAd3fBIQUvscjmlOmvpOYMS7ivDnEayH3BcUX/fGTlqAcbZvDjNYL7HkmlJrmAabka33uNfjYb3mIdnB+4yg8CwQ83xdfrk06u5p0ByrXqVKhOJJVkb/ZEI8jfqnAITXipuC/DOeH/EzJot/qZwFsSdVqHRv8GC2sYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI+3OciV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI+3OciV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5AB1F000FF;
	Tue, 29 Sep 2026 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669163;
	bh=EPzgTWdh93SIW5SGbcUB14dk6XnxkG2PrhkwY/oSQcA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CI+3OciVHHewU8YPF7KT1ia7+z28tYbeykUYlPSPl1BuQu9KPl7tcI/VGH6QVHuTw
	 rgG7S81J9O7S5LC6A+NLLFs7VW47s/ZiNd16q4/srMnwBlKbddiSaHHOlLZXTIczC5
	 QMJEJdOR6GO6HwjV49AeilSqUwzfA+OOWqb93q+hxM+qoGRCrYId07O+o9YwE1qleP
	 hTSJW1N6xXkUAAnq+XYvfLt73jWkNocZtT1zTzbDyH0pkiWGZIBhVxvJu9tqgqZ4GO
	 HWd0hnsioQ+Ii1XSxyp3Av6trEtfpR0ZW6w34S+E1HHclBvyrdM3l0HEJ/GZtpzecl
	 93KJYI2Sz0AfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] mm/damon/sysfs-schemes: support quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-4-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:06:03 +0000
Message-Id: <20260929080603.9E5AB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add a new sysfs file, complement, under the quota goal directory.  It
> works for setting and getting the quota goal metric complement flag
> value.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D3

